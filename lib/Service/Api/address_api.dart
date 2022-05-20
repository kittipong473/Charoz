import 'dart:convert';

import 'package:charoz/Screen/User/Model/address_model.dart';
import 'package:charoz/Service/Api/user_api.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:http/http.dart' as http;

class AddressApi {
  Future getAllAddressWhereUserId() async {
    String id = await UserApi().getUserIdWhereToken();
    List<AddressModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiAddress}getAllAddressWhereUserId.php?id=$id');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        AddressModel model = AddressModel.fromMap(item);
        result.add(model);
      }
    }
    return result;
  }

  Future getCurrentAddressWhereId() async {
    String id = await UserApi().getUserLocationWhereToken();
    AddressModel? result;
    final url = Uri.parse(
        '${RouteApi.domainApiAddress}getAddressWhereAddressId.php?id=$id');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        result = AddressModel.fromMap(item);
      }
      return result;
    } else {
      return null;
    }
  }

  Future<bool> insertAddress({
    required String userid,
    required String name,
    required String desc,
    required String lat,
    required String lng,
    required String time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiNoti}addAddress.php?userid=$userid&name=$name&desc=$desc&lat=$lat&lng=$lng&time=$time');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }
}
