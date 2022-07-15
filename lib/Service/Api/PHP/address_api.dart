import 'dart:convert';

import 'package:charoz/Model/address_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:http/http.dart' as http;

class AddressApi {
  Future getAllAddressWhereUser() async {
    List<AddressModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiAddress}getAllAddressWhereUser.php?id=${GlobalVariable.userTokenId}');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(convertAddress(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future insertAddress({
    required int userid,
    required String name,
    required String desc,
    required double lat,
    required double lng,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiAddress}insertAddress.php?userid=$userid&name=$name&desc=$desc&lat=$lat&lng=$lng&time=$time');
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

  Future editAddressWhereId({
    required int id,
    required String name,
    required String desc,
    required double lat,
    required double lng,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiAddress}editAddressWhereId.php?id=$id&name=$name&desc=$desc&lat=$lat&lng=$lng&time=$time');
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

  Future deleteAddressWhereId({required int id}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiAddress}deleteAddressWhereId.php?id=$id');
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
