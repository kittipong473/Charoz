import 'dart:convert';

import 'package:charoz/Screen/Notification/Model/noti_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:http/http.dart' as http;

class NotiApi {
  Future getNotiWhereType(String type) async {
    List<NotiModel> result = [];
    final url =
        Uri.parse('${RouteApi.domainApiNoti}getNotiWhereType.php?type=$type');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        NotiModel model = NotiModel.fromMap(item);
        result.add(model);
      }
      return result;
    }
    return result;
  }

  Future getNotiWhereId({required String id}) async {
    NotiModel? result;
    final url = Uri.parse('${RouteApi.domainApiNoti}getNotiWhereId.php?id=$id');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        result = NotiModel.fromMap(item);
      }
      return result;
    } else {
      return result;
    }
  }

  Future changeNotiStatus({required String id}) async {
    final url =
        Uri.parse('${RouteApi.domainApiNoti}changeNotiStatus.php?id=$id');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> insertNoti({
    required String type,
    required String name,
    required String detail,
    required String image,
    required String refer,
    required String start,
    required String end,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiNoti}addNoti.php?type=$type&name=$name&detail=$detail&image=$image&refer=$refer&start=$start&end=$end');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future deleteNotiWhereId({required String id}) async {
    final url =
        Uri.parse('${RouteApi.domainApiNoti}deleteNotiWhereId.php?id=$id');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }
}
