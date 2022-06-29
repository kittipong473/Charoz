import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Service/Api/product_api.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier {
  ProductModel? _product;
  List<ProductModel>? _productAlls;
  List<ProductModel>? _productLists;
  List<ProductModel>? _productsSuggest;

  get product => _product;
  get productAlls => _productAlls;
  get productLists => _productLists;
  get productsSuggest => _productsSuggest;

  Future getAllProduct() async {
    _productAlls = await ProductApi().getAllProduct();
    notifyListeners();
  }

  Future getProductSuggest() async {
    _productsSuggest = await ProductApi().getAllProductWhereSuggest();
    notifyListeners();
  }

  Future getAllProductWhereType(String type) async {
    _productLists = await ProductApi().getAllProductWhereType(type);
    notifyListeners();
  }

  Future getProductWhereId(int id) async {
    _product = await ProductApi().getProductWhereId(id: id);
    notifyListeners();
  }
}
