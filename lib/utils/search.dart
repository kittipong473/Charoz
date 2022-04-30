import 'dart:convert';

import 'package:charoz/screens/product/model/product_model.dart';
import 'package:charoz/services/route/route_api.dart';
import 'package:http/http.dart' as http;

class ProductSearch {
  static Future<List<ProductModel>> getSuggestion (String query) async {
    final path = Uri.parse('${RouteApi.domainApi}getAllProduct.php');
    http.Response response = await http.get(path);

    final List datas = json.decode(response.body);

    return datas.map((json) => ProductModel.fromJson(json)).where((data) {
      final titleLower = data.productName.toLowerCase();
      final authorLower = data.productPrice.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }
}