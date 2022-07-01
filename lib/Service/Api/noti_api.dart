import 'dart:convert';

import 'package:charoz/Model/noti_model.dart';
import 'package:charoz/Service/Api/Convert_Model_Type/convert_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:http/http.dart' as http;

class NotiApi {
  Future getNotiWhereId({required int id}) async {
    final url = Uri.parse('${RouteApi.domainApiNoti}getNotiWhereId.php?id=$id');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return ConvertModel().noti(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getAllNotiWhereType({required String type}) async {
    List<NotiModel> result = [];
    int id = MyVariable.userTokenId;
    final url = Uri.parse(
        '${RouteApi.domainApiNoti}getAllNotiWhereType.php?type=$type&id=$id');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(ConvertModel().noti(item));
        }
        return result;
      } else {
        return null;
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
}
