import 'dart:convert';

import 'package:charoz/screens/user/model/user_model.dart';
import 'package:charoz/services/route/route_api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  Future<bool> checkUserWherePhone({required String phone}) async {
    final url =
        Uri.parse('${RouteApi.domainApi}getUserWherePhone.php?phone=$phone');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      if (response.body.toString() == 'null') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> registerUser({
    required String firstname,
    required String lastname,
    required String birth,
    required String email,
    required String phone,
    required String password,
    required String create,
    required String update,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApi}register.php?firstname=$firstname&lastname=$lastname&birth=$birth&email=$email&phone=$phone&password=$password&created=$create&updated=$update');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future loginUser({required String phone, required String password}) async {
    UserModel? result;
    final url = Uri.parse(
        '${RouteApi.domainApi}login.php?phone=$phone&password=$password');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        result = UserModel.fromMap(item);
      }
      return result;
    } else {
      return null;
    }
  }

  Future getUserWhereIdPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    UserModel? result;
    final url = Uri.parse('${RouteApi.domainApi}getUserWhereId.php?id=$id');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      for (var item in json.decode(response.body)) {
        result = UserModel.fromMap(item);
      }
      return result;
    } else {
      return null;
    }
  }

  Future editUserWhereId({
    required String id,
    required String firstname,
    required String lastname,
    required String birth,
    required String email,
    required String time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApi}editUserWhereId.php?id=$id&firstname=$firstname&lastname=$lastname&birth=$birth&email=$email&updated=$time');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future editFavoriteWhereUser({required String favorites}) async {
    if (favorites == '[]') {
      favorites = 'null';
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    final url = Uri.parse(
        '${RouteApi.domainApi}editFavoriteWhereUser.php?id=$id&favorites=$favorites');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future getAllUser() async {
    List<UserModel> result = [];
    final url = Uri.parse('${RouteApi.domainApi}getAllUser.php');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        UserModel model = UserModel.fromMap(item);
        result.add(model);
      }
      
    }
    return result;
  }
}
