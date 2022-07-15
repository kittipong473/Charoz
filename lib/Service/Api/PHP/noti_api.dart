import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:charoz/Model/noti_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class NotiApi {
  Future getAllNotiWhereType({required String type}) async {
    List<NotiModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiNoti}getAllNotiWhereType.php?type=$type&id=${GlobalVariable.userTokenId}');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(convertNoti(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future insertNoti({
    required String type,
    required String name,
    required String detail,
    required String image,
    required int userid,
    required DateTime start,
    required DateTime end,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiNoti}insertNoti.php?type=$type&name=$name&detail=$detail&image=$image&userid=$userid&start=$start&end=$end');
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

  Future editNotiStatusWhereId({required int id}) async {
    final url =
        Uri.parse('${RouteApi.domainApiNoti}editNotiStatusWhereId.php?id=$id');
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

  Future deleteNotiWhereId({required int id}) async {
    final url =
        Uri.parse('${RouteApi.domainApiNoti}deleteNotiWhereId.php?id=$id');
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
}
