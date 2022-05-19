import 'dart:convert';

import 'package:charoz/Screen/Home/Model/banner_model.dart';
import 'package:charoz/Screen/Home/Model/maintenance_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:http/http.dart' as http;

class HomeApi {
  Future getMaintenance({required String status}) async {
    MaintenanceModel? result;
    final url = Uri.parse(
        '${RouteApi.domainApi}getMaintainWhereStatus.php?status=$status');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        result = MaintenanceModel.fromMap(item);
      }
      return result;
    } else {
      return null;
    }
  }

  Future getAllBanner() async {
    List<BannerModel> result = [];
    final url = Uri.parse('${RouteApi.domainApi}getAllBanner.php');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        BannerModel model = BannerModel.fromMap(item);
        result.add(model);
      }
      return result;
    } else {
      return null;
    }
  }

  Future editCountWhereDevice({
    required String id,
    required int count,
    required String date,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApi}editCountWhereDevice.php?id=$id&count=$count&date=$date');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future getStatusWhereMaintain({required int shopid}) async {
    final url = Uri.parse(
        '${RouteApi.domainApi}getStatusWhereMaintain.php?shopid=$shopid');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      for (var item in json.decode(response.body)) {
        return item["statusCode"];
      }
    } else {
      return null;
    }
  }
}
