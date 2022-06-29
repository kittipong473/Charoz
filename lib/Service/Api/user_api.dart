import 'dart:convert';

import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Service/Api/Convert_Model_Type/convert_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future editUserWhereId({
    required int id,
    required String firstname,
    required String lastname,
    required DateTime birth,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}editUserWhereId.php?id=$id&firstname=$firstname&lastname=$lastname&birth=$birth&updated=$time');
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

  Future getAllUser() async {
    List<UserModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiUser}getAllUser.php');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(ConvertModel().user(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getOnlyLocationWhereToken() async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}getOnlyLocationWhereToken.php?token=${MyVariable.accountUid}');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return json.decode(response.body)["userLocation"];
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
        return ConvertModel().user(json.decode(response.body));
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
      if (response.statusCode == 200 && response.body.toString() == 'null') {
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

  Future getUserWhereToken() async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}getUserWhereToken.php?token=${MyVariable.accountUid}');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return ConvertModel().user(json.decode(response.body));
      } else {
        return null;
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
    required String tokenE,
    required String tokenP,
    required String tokenG,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiUser}insertUser.php?firstname=$firstname&lastname=$lastname&birth=$birth&email=$email&phone=$phone&role=$role&tokenE=$tokenE&tokenP=$tokenP&tokenG=$tokenG');
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
}
