import 'dart:io';
import 'dart:math';

import 'package:charoz/Model/Api/Request/shop_admin_request.dart';
import 'package:charoz/Model/Data/shop_model.dart';
import 'package:charoz/Model/Api/Request/shop_manager_request.dart';
import 'package:charoz/Service/Restful/api_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ShopCRUD {
  final ApiController capi = Get.find<ApiController>();
  final shop = FirebaseFirestore.instance.collection('shop');

  Future<ShopModel?> readShopModel() async {
    ShopModel? model;
    try {
      capi.loadingPage(true);
      final snapshot = await shop.limit(1).get();
      for (var item in snapshot.docs) {
        model = convertShop(item, null);
      }
      capi.loadingPage(false);
      return model;
    } catch (e) {
      capi.loadingPage(false);
      return null;
    }
  }

  Future<bool> updateShopByAdmin(String id, ShopAdminRequest model) async {
    try {
      capi.loadingPage(true);
      await shop.doc(id).update(model.toMap());
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateShopByManager(String id, ShopManagerRequest model) async {
    try {
      capi.loadingPage(true);
      await shop.doc(id).update(model.toMap());
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<String?> uploadImageShop(File file) async {
    int name = Random().nextInt(100000);
    try {
      capi.loadingPage(true);
      final reference =
          FirebaseStorage.instance.ref().child('shop/shop$name.png');
      final task = reference.putFile(file);
      capi.loadingPage(false);
      return await task.storage.ref().getDownloadURL();
    } catch (e) {
      capi.loadingPage(false);
      return null;
    }
  }
}
