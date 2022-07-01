import 'dart:io';
import 'dart:math';

import 'package:charoz/Service/Route/route_api.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class SaveImagePath {
  Future<File> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 600,
      );
      return File(result!.path);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> saveProductImage(String image, File? file) async {
    if (file != null) {
      String url = '${RouteApi.domainApiProduct}saveImageProduct.php';
      int i = Random().nextInt(100000);
      String nameImage = 'product$i.png';
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);
      FormData data = FormData.fromMap(map);
      await Dio().post(url, data: data).then((value) => image = nameImage);
    }
    return image;
  }

  Future<String> saveShopImage(String image, File? file) async {
    if (file != null) {
      String url = '${RouteApi.domainApiNoti}saveImageShop.php';
      int i = Random().nextInt(100000);
      String nameImage = 'shop$i.png';
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);
      FormData data = FormData.fromMap(map);
      await Dio().post(url, data: data).then((value) => image = nameImage);
    }
    return image;
  }

  Future<String> saveNotiImage(String image, File? file) async {
    if (file != null) {
      String url = '${RouteApi.domainApiNoti}saveImageNoti.php';
      int i = Random().nextInt(100000);
      String nameImage = 'noti$i.png';
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);
      FormData data = FormData.fromMap(map);
      await Dio().post(url, data: data).then((value) => image = nameImage);
    }
    return image;
  }

  Future<String> saveUserImage(String image, File? file) async {
    if (file != null) {
      String url = '${RouteApi.domainApiNoti}saveImageUser.php';
      int i = Random().nextInt(100000);
      String nameImage = 'user$i.png';
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);
      FormData data = FormData.fromMap(map);
      await Dio().post(url, data: data).then((value) => image = nameImage);
    }
    return image;
  }
}
