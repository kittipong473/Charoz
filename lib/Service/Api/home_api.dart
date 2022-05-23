import 'dart:convert';

import 'package:charoz/Screen/Home/Model/banner_model.dart';
import 'package:charoz/Screen/Home/Model/maintenance_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:http/http.dart' as http;

class HomeApi {
  Future getMaintenance({required String status}) async {
    MaintenanceModel? result;
    final url = Uri.parse(
        '${RouteApi.domainApiHome}getMaintainWhereStatus.php?status=$status');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result = MaintenanceModel.fromMap(item);
        }
      }
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future getAllBanner() async {
    List<BannerModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiHome}getAllBanner.php');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          BannerModel model = BannerModel.fromMap(item);
          result.add(model);
        }
      }
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future editCountWhereDevice(
      {required String id, required int count, required String date}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiHome}editCountWhereDevice.php?id=$id&count=$count&date=$date');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() == 'true') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getStatusWhereMaintain({required int shopid}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiHome}getStatusWhereMaintain.php?shopid=$shopid');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          return item["statusCode"];
        }
      }
      return null;
    } catch (e) {
      print(e);
    }
  }
}
