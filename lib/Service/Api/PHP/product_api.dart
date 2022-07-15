import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  Future getAllProduct() async {
    List<ProductModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiProduct}getAllProduct.php');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result.add(convertProduct(item));
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
          result.add(convertProduct(item));
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
          result.add(convertProduct(item));
        }
        return result;
      } else {
        return null;
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

  Future editStatusWhereProduct({required int status, required int id}) async {
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

  Future<String> saveProductImage(String image, File? file) async {
    if (file != null) {
      String url = '${RouteApi.domainApiProduct}saveImageProduct.php';
      int i = Random().nextInt(100000);
      String nameImage = 'product$i.png';
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);
      FormData data = FormData.fromMap(map);
      await Dio().post(url, data: data).then((value) => image = nameImage);
    }
    return image;
  }
}
