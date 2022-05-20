import 'dart:convert';

import 'package:charoz/Screen/Product/Model/product_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  Future getProductWhereId({required String id}) async {
    ProductModel? result;
    final url =
        Uri.parse('${RouteApi.domainApiProduct}getProductWhereId.php?id=$id');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        result = ProductModel.fromMap(item);
      }
      return result;
    } else {
      return null;
    }
  }

  Future getProductWhereType(String type) async {
    List<ProductModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}getProductWhereType.php?type=$type');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        ProductModel model = ProductModel.fromMap(item);
        result.add(model);
      }
      return result;
    } else {
      return null;
    }
  }

  Future getProductWhereSuggest() async {
    List<ProductModel> result = [];
    final url =
        Uri.parse('${RouteApi.domainApiProduct}getProductWhereSuggest.php');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        ProductModel model = ProductModel.fromMap(item);
        result.add(model);
      }
      return result;
    } else {
      return null;
    }
  }

  Future getProductWhereFavorite(String id) async {
    List<ProductModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}getProductWhereFavorite.php?id=$id');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        ProductModel model = ProductModel.fromMap(item);
        result.add(model);
      }
      return result;
    } else {
      return null;
    }
  }

  Future editStatusWhereProduct(String status, String id) async {
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}editStatusWhereProduct.php?id=$id&status=$status');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> insertProduct({
    required String name,
    required String type,
    required String price,
    required String score,
    required String detail,
    required String image,
    required int suggest,
    required String time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}addProduct.php?name=$name&type=$type&price=$price&score=$score&detail=$detail&image=$image&suggest=$suggest&created=$time&updated=$time');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future editProductWhereId({
    required String id,
    required String name,
    required String type,
    required String price,
    required String score,
    required String detail,
    required String image,
    required int suggest,
    required String time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}editProductWhereId.php?id=$id&name=$name&type=$type&price=$price&score=$score&detail=$detail&image=$image&suggest=$suggest&updated=$time');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future changeProductStatusWhereId(
      {required String id, required String status}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}changeProductStatusWhereId.php?id=$id&status=$status');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future deleteProductWhereId({required String id}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}deleteProductWhereId.php?id=$id');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }
}
