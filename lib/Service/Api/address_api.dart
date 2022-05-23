import 'dart:convert';

import 'package:charoz/Screen/Address/Model/address_model.dart';
import 'package:charoz/Service/Api/user_api.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:http/http.dart' as http;

class AddressApi {
  Future getAllAddressWhereUserId() async {
    String id = MyVariable.userTokenId;
    List<AddressModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiAddress}getAllAddressWhereUserId.php?id=$id');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          AddressModel model = AddressModel.fromMap(item);
          result.add(model);
        }
      }
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future getCurrentAddressWhereId() async {
    String id = await UserApi().getUserLocationWhereToken();
    AddressModel? result;
    final url = Uri.parse(
        '${RouteApi.domainApiAddress}getAddressWhereAddressId.php?id=$id');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result = AddressModel.fromMap(item);
        }
      }
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future insertAddress({
    required String userid,
    required String name,
    required String desc,
    required String lat,
    required String lng,
    required String time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiAddress}addAddress.php?userid=$userid&name=$name&desc=$desc&lat=$lat&lng=$lng&time=$time');
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

  Future deleteAddressWhereId({required String id}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}deleteAddressWhereId.php?id=$id');
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
