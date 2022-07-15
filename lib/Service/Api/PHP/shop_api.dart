import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Model/time_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ShopApi {
  Future getAllShop() async {
    List<ShopModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiShop}getAllShop.php');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(convertShop(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getTimeWhereId({required int id}) async {
    final url = Uri.parse('${RouteApi.domainApiShop}getTimeWhereId.php?id=$id');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return convertTime(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future editShopByAdmin({
    required int id,
    required String name,
    required String announce,
    required String detail,
    required String address,
    required double lat,
    required double lng,
    required String image,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiShop}editShopByAdmin.php?id=$id&name=$name&announce=$announce&detail=$detail&address=$address&lat=$lat&lng=$lng&image=$image&updated=$time');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() == 'true') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future editShopByManager({
    required int id,
    required String name,
    required String announce,
    required String detail,
    required String image,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiShop}editShopByManager.php?id=$id&name=$name&announce=$announce&detail=$detail&image=$image&updated=$time');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() == 'true') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future editTimeWhereShop({
    required int id,
    required String type,
    required String timeOpen,
    required String timeClose,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiShop}editTimeWhereShop.php?id=$id&type=$type&timeOpen=$timeOpen&timeClose=$timeClose');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() == 'true') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
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
}
