import 'dart:convert';

import 'package:charoz/Screen/Shop/Model/shop_model.dart';
import 'package:charoz/Screen/Shop/Model/time_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:http/http.dart' as http;

class ShopApi {
  Future getAllShop() async {
    List<ShopModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiShop}getAllShop.php');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          ShopModel model = ShopModel.fromMap(item);
          result.add(model);
        }
      }
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future getShopWhereId() async {
    ShopModel? result;
    final url = Uri.parse('${RouteApi.domainApiShop}getShopWhereId.php?id=1');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result = ShopModel.fromMap(item);
        }
      }
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future getTimeWhereId() async {
    TimeModel? result;
    final url = Uri.parse('${RouteApi.domainApiShop}getTimeWhereId.php?id=1');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result = TimeModel.fromMap(item);
        }
      }
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future editShopWhereId(
      {required String id,
      required String name,
      required String announce,
      required String detail,
      required String video,
      required String time}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiShop}editShopWhereId.php?id=$id&name=$name&announce=$announce&detail=$detail&video=$video&updated=$time');
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

  Future editTimeWhereId(
      {required String id,
      required String type,
      required String weekdayOpen,
      required String weekdayClose,
      required String weekendOpen,
      required String weekendClose}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiShop}editTimeWhereId.php?id=$id&type=$type&weekdayOpen=$weekdayOpen&weekdayClose=$weekdayClose&weekendOpen=$weekendOpen&weekendClose=$weekendClose');
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

  Future editAddressWhereId({
    required String id,
    required String address,
    required String lat,
    required String lng,
    required String time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiShop}editAddressWhereShop.php?id=$id&address=$address&lat=$lat&lng=$lng&updated=$time');
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
}
