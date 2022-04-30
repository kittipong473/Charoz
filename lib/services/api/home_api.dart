import 'dart:convert';

import 'package:charoz/screens/home/model/banner_model.dart';
import 'package:charoz/screens/home/model/device_model.dart';
import 'package:charoz/screens/home/model/maintain_model.dart';
import 'package:charoz/screens/home/model/maintenanceapp_model.dart';
import 'package:charoz/services/route/route_api.dart';
import 'package:http/http.dart' as http;

class HomeApi {
  Future getMaintenance({required String status}) async {
    MaintainModel? result;
    final url = Uri.parse(
        '${RouteApi.domainApi}getMaintainWhereStatus.php?status=$status');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        result = MaintainModel.fromMap(item);
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

  Future getIdentify({required String identify}) async {
    DeviceModel? result;
    final url = Uri.parse(
        '${RouteApi.domainApi}getIdentifyWhereDevice.php?identify=$identify');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        result = DeviceModel.fromMap(item);
      }
    }
    return result;
  }

  Future insertDevice({
    required String identify,
    required String name,
    required String version,
    required String date,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApi}addDevice.php?identify=$identify&name=$name&version=$version&date=$date');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
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

  Future getMaintenanceStatus() async {
    MaintenanceApp? result;
    final url = Uri.parse('${RouteApi.domainApi}getMaintenanceStatus.php');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        result = MaintenanceApp.fromMap(item);
      }
      return result;
    } else {
      return null;
    }
  }
}
