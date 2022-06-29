import 'dart:convert';

import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Service/Api/Convert_Model_Type/convert_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  Future getProductWhereId({required int id}) async {
    final url =
        Uri.parse('${RouteApi.domainApiProduct}getProductWhereId.php?id=$id');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        return ConvertModel().product(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getAllProduct() async {
    List<ProductModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiProduct}getAllProduct.php');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(ConvertModel().product(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getAllProductWhereType(String type) async {
    List<ProductModel> result = [];
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}getAllProductWhereType.php?type=$type');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(ConvertModel().product(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getAllProductWhereSuggest() async {
    List<ProductModel> result = [];
    final url =
        Uri.parse('${RouteApi.domainApiProduct}getAllProductWhereSuggest.php');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(ConvertModel().product(item));
        }
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future editStatusWhereProduct(int status, int id) async {
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}editStatusWhereProduct.php?id=$id&status=$status');
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

  Future insertProduct({
    required String name,
    required String type,
    required double price,
    required double score,
    required String detail,
    required String image,
    required int suggest,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}insertProduct.php?name=$name&type=$type&price=$price&score=$score&detail=$detail&image=$image&suggest=$suggest&created=$time&updated=$time');
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

  Future editProductWhereId({
    required int id,
    required String name,
    required String type,
    required double price,
    required double score,
    required String detail,
    required String image,
    required int suggest,
    required DateTime time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}editProductWhereId.php?id=$id&name=$name&type=$type&price=$price&score=$score&detail=$detail&image=$image&suggest=$suggest&updated=$time');
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

  Future editProductStatusWhereId(
      {required int id, required int status}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}editProductStatusWhereId.php?id=$id&status=$status');
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

  Future deleteProductWhereId({required int id}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiProduct}deleteProductWhereId.php?id=$id');
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
