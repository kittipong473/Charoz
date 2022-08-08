import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Service/Database/Firebase/product_crud.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? _product;
  List<ProductModel>? _productAlls;
  List<ProductModel>? _productList;

  get product => _product;
  get productAlls => _productAlls;
  get productList => _productList;

  Future readProductAllList() async {
    _productAlls = await ProductCRUD().readProductAllList();
    notifyListeners();
  }

  Future readProductSuggestList() async {
    if (_productList != null) {
      if (_productList!.isNotEmpty) {
        _productList!.clear();
      }
    }
    _productList = await ProductCRUD().readProductSuggestList();
    notifyListeners();
  }

  Future readProductTypeList(String type) async {
    if (_productList != null) {
      if (_productList!.isNotEmpty) {
        _productList!.clear();
      }
    }
    _productList = await ProductCRUD().readProductTypeList(type);
    notifyListeners();
  }

  void selectProductWhereId(String id) {
    _product = _productAlls!.firstWhere((element) => element.id == id);
  }

  void deleteProductWhereId(String id) {
    _productList!.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearProductData() {
    _product = null;
    _productList = null;
    _productAlls = null;
  }
}
