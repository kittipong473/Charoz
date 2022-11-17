import 'dart:io';
import 'dart:math';

import 'package:charoz/Model/Data/shop_model.dart';
import 'package:charoz/Model/Api/Request/shop_admin_modify.dart';
import 'package:charoz/Model/Api/Request/shop_manager_modify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShopCRUD {
  final shop = FirebaseFirestore.instance.collection('shop');

  Future readShopModel() async {
    try {
      final snapshot = await shop.limit(1).get();
      for (var item in snapshot.docs) {
        return convertShop(item);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateShopByAdmin(String id, ShopAdminManage model) async {
    try {
      await shop.doc(id).update(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateShopByManager(String id, ShopManagerManage model) async {
    try {
      await shop.doc(id).update(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> uploadImageShop(File file) async {
    int name = Random().nextInt(100000);
    try {
      final reference =
          FirebaseStorage.instance.ref().child('shop/shop$name.png');
      final task = reference.putFile(file);
      return await task.storage.ref().getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }
}
