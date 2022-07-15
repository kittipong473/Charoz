import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future getAllUser() async {
    List<UserModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiUser}getAllUser.php');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(convertUser(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getUserWhereId({required int id}) async {
    final url = Uri.parse('${RouteApi.domainApiUser}getUserWhereId.php?id=$id');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return convertUser(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getUserWhereToken() async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}getUserWhereToken.php?token=${GlobalVariable.accountUid}');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return convertUser(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getUserWherePhone({required String phone}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}getUserWherePhone.php?phone=$phone');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return convertUser(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future checkUserWherePhone({required String phone}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}getUserWherePhone.php?phone=$phone');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future checkUserWhereEmail({required String email}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}getUserWhereEmail.php?email=$email');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future insertUser({
    required String firstname,
    required String lastname,
    required DateTime birth,
    required String email,
    required String phone,
    required String role,
    required String token,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}insertUser.php?firstname=$firstname&lastname=$lastname&birth=$birth&email=$email&phone=$phone&role=$role&token=$token');
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

  Future editUserWhereId({
    required int id,
    required String firstname,
    required String lastname,
    required DateTime birth,
    required String image,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}editUserWhereId.php?id=$id&firstname=$firstname&lastname=$lastname&birth=$birth&image=$image&updated=$time');
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

  Future editPinWhereUser({required String code}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}editPinWhereUser.php?id=${GlobalVariable.userTokenId}&code=$code');
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
