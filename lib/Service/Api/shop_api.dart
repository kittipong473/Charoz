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

  Future getShopWhereId({required int id}) async {
    final url = Uri.parse('${RouteApi.domainApiShop}getShopWhereId.php?id=$id');
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

  Future getTimeWhereId({required int id}) async {
    final url = Uri.parse('${RouteApi.domainApiShop}getTimeWhereId.php?id=$id');
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

  Future editShopByManager({
    required int id,
    required String name,
    required String announce,
    required String detail,
    required String image,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiShop}editShopByManager.php?id=$id&name=$name&announce=$announce&detail=$detail&image=$image&updated=$time');
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

  Future editShopByAdmin({
    required int id,
    required String name,
    required String announce,
    required String detail,
    required String address,
    required double lat,
    required double lng,
    required String image,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiShop}editShopByAdmin.php?id=$id&name=$name&announce=$announce&detail=$detail&address=$address&lat=$lat&lng=$lng&image=$image&updated=$time');
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

  Future editTimeWhereShop({
    required int id,
    required String type,
    required String timeOpen,
    required String timeClose,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiShop}editTimeWhereShop.php?id=$id&type=$type&timeOpen=$timeOpen&timeClose=$timeClose');
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
