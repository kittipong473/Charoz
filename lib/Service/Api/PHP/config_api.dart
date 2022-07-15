import 'dart:convert';

import 'package:charoz/Model/banner_model.dart';
import 'package:charoz/Model/maintain_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:http/http.dart' as http;

class ConfigApi {
  Future getAllBanner() async {
    List<BannerModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiConfig}getAllBanner.php');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(convertBanner(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getMaintainWhereStatus({required int status}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiConfig}getMaintainWhereStatus.php?status=$status');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return convertMaintain(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getOnlyStatusWhereShop({required int shopid}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiConfig}getOnlyStatusWhereShop.php?shopid=$shopid');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return int.parse(json.decode(response.body)["statusCode"]);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
