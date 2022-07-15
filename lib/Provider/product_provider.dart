import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Service/Api/PHP/product_api.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? _product;
  List<ProductModel>? _productAlls;
  List<ProductModel>? _productList;

  get product => _product;
  get productAlls => _productAlls;
  get productList => _productList;

  Future getAllProduct() async {
    _productAlls = await ProductApi().getAllProduct();
    notifyListeners();
  }

  Future getProductSuggest() async {
    if (_productList != null) {
      _productList!.clear();
    }
    _productList = await ProductApi().getAllProductWhereSuggest();
    notifyListeners();
  }

  Future getAllProductWhereType(String type) async {
    if (_productList != null) {
      _productList!.clear();
    }
    _productList = await ProductApi().getAllProductWhereType(type);
    notifyListeners();
  }

  void selectProductWhereId(int id) {
    _product = _productAlls!.firstWhere((element) => element.productId == id);
  }

  void deleteProductWhereId(int id) {
    _productList!.removeWhere((item) => item.productId == id);
    notifyListeners();
  }
}
