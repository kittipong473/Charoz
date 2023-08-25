import 'dart:io';
import 'dart:math';

import 'package:charoz/Model/Api/FireStore/banner_model.dart';
import 'package:charoz/Service/Restful/api_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class BannerCRUD {
  final ApiController capi = Get.find<ApiController>();
  final banner = FirebaseFirestore.instance.collection('banner');

  Future<List<BannerModel>> readCarouselList() async {
    List<BannerModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await banner.where('type', isEqualTo: 1).get();
      for (var item in snapshot.docs) {
        result.add(BannerModel().convert(item: item));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<BannerModel?> readBannerByType({required int type}) async {
    BannerModel? model;
    try {
      capi.loadingPage(true);
      final snapshot =
          await banner.where('type', isEqualTo: type).limit(1).get();
      for (var item in snapshot.docs) {
        model = BannerModel().convert(item: item);
      }
      capi.loadingPage(false);
      return model;
    } catch (e) {
      capi.loadingPage(false);
      return null;
    }
  }

  Future<String?> uploadImageShop({required File file}) async {
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
