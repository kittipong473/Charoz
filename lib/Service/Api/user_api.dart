import 'dart:convert';

import 'package:charoz/Screen/User/Model/user_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future getUserWhereToken() async {
    String token = MyVariable.accountUid;
    UserModel? result;
    final url = Uri.parse(
        '${RouteApi.domainApiUser}getUserWhereToken.php?token=$token');
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

  Future getUserIdWhereToken() async {
    String token = MyVariable.accountUid;
    final url = Uri.parse(
        '${RouteApi.domainApiUser}getUserIdWhereToken.php?token=$token');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        return item["userId"];
      }
    } else {
      return null;
    }
  }

  Future getUserLocationWhereToken() async {
    String token = MyVariable.accountUid;
    final url = Uri.parse(
        '${RouteApi.domainApiUser}getUserLocationWhereToken.php?token=$token');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        return item["userLocation"];
      }
    } else {
      return null;
    }
  }

  Future<bool> checkUserWherePhone({required String phone}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}getUserWherePhone.php?phone=$phone');
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

  Future<bool> checkUserWhereEmail({required String email}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}getUserWhereEmail.php?email=$email');
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

  Future getUserEmailWherePhone({required String phone}) async {
    UserModel? result;
    final url = Uri.parse(
        '${RouteApi.domainApiUser}getUserWherePhone.php?phone=$phone');
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

  Future<bool> register({
    required String firstname,
    required String lastname,
    required String birth,
    required String email,
    required String phone,
    required String role,
    required String tokenE,
    required String tokenP,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}register.php?firstname=$firstname&lastname=$lastname&birth=$birth&email=$email&phone=$phone&role=$role&tokenE=$tokenE&tokenP=$tokenP');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future editUserWhereId({
    required String id,
    required String firstname,
    required String lastname,
    required String birth,
    required String time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}editUserWhereId.php?id=$id&firstname=$firstname&lastname=$lastname&birth=$birth&updated=$time');
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
    String id = "";
    final url = Uri.parse(
        '${RouteApi.domainApiUser}editFavoriteWhereUser.php?id=$id&favorites=$favorites');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future getAllUser() async {
    List<UserModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiUser}getAllUser.php');
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
