import 'dart:convert';

import 'package:charoz/Model/order_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:http/http.dart' as http;

class OrderApi {
  Future getAllOrderWhereCustomer() async {
    List<OrderModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiOrder}getAllOrderWhereCustomer.php?id=${GlobalVariable.userTokenId}');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(convertOrder(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getAllOrderWhereManager() async {
    List<OrderModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiOrder}getAllOrderWhereManager.php?id=${GlobalVariable.userTokenId}');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(convertOrder(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getAllOrderWhereManagerDone() async {
    List<OrderModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiOrder}getAllOrderWhereManagerDone.php?id=${GlobalVariable.userTokenId}');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(convertOrder(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getAllOrderWhereNoRider() async {
    List<OrderModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiOrder}getAllOrderWhereNoRider.php');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(convertOrder(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getAllOrderWhereYesRider() async {
    List<OrderModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiOrder}getAllOrderWhereYesRider.php?id=${GlobalVariable.userTokenId}');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(convertOrder(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getAllOrderWhereRiderDone() async {
    List<OrderModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiOrder}getAllOrderWhereRiderDone.php?id=${GlobalVariable.userTokenId}');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(convertOrder(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future insertOrder({
    required int shopid,
    required int customerid,
    required int addressid,
    required String productids,
    required String amounts,
    required double total,
    required String receive,
    required String commentS,
    required String commentR,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiOrder}insertOrder.php?shopid=$shopid&customerid=$customerid&addressid=$addressid&productids=$productids&amounts=$amounts&total=$total&receive=$receive&commentS=$commentS&commentR=$commentR&time=$time');
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

  Future editStatusWhereOrder({required int id, required String status}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}editStatusWhereOrder.php?id=$id&status=$status');
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
