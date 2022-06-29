import 'dart:convert';

import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Service/Api/Convert_Model_Type/convert_model.dart';
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
          result.add(ConvertModel().shop(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getShopWhereId() async {
    final url = Uri.parse('${RouteApi.domainApiShop}getShopWhereId.php?id=1');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return ConvertModel().shop(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getTimeWhereId() async {
    final url = Uri.parse('${RouteApi.domainApiShop}getTimeWhereId.php?id=1');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return ConvertModel().time(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future editInformationShopWhereId({
    required int id,
    required String name,
    required String announce,
    required String detail,
    required String video,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiShop}editInformationShopWhereId.php?id=$id&name=$name&announce=$announce&detail=$detail&video=$video&updated=$time');
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

  Future editAddressShopWhereId({
    required int id,
    required String address,
    required double lat,
    required double lng,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiShop}editAddressShopWhereId.php?id=$id&address=$address&lat=$lat&lng=$lng&updated=$time');
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

  Future editTimeWhereId({
    required int id,
    required String type,
    required String weekdayOpen,
    required String weekdayClose,
    required String weekendOpen,
    required String weekendClose,
  }) async {
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
      rethrow;
    }
  }
}
