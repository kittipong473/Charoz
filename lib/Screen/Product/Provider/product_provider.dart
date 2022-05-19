import 'package:charoz/Screen/Product/Model/product_model.dart';
import 'package:charoz/Service/Api/product_api.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? _product;

  List<ProductModel> _productsFood = [];
  List<ProductModel> _productsSnack = [];
  List<ProductModel> _productsDrink = [];
  List<ProductModel> _productsSweet = [];
  List<ProductModel> _productsSuggest = [];

  get product => _product;

  get productsFood => _productsFood;
  get productsFoodLength => _productsFood.length;

  get productsSnack => _productsSnack;
  get productsSnackLength => _productsSnack.length;

  get productsDrink => _productsDrink;
  get productsDrinkLength => _productsDrink.length;

  get productsSweet => _productsSweet;
  get productsSweetLength => _productsSweet.length;

  get productsSuggest => _productsSuggest;
  get productsSuggestLength => _productsSuggest.length;

  Future getProductSuggest() async {
    _productsSuggest = await ProductApi().getProductWhereSuggest();
    notifyListeners();
  }

  Future getAllProduct() async {
    _productsFood = await ProductApi().getProductWhereType('อาหาร');
    _productsSnack = await ProductApi().getProductWhereType('ออร์เดิฟ');
    _productsDrink = await ProductApi().getProductWhereType('เครื่องดื่ม');
    _productsSweet = await ProductApi().getProductWhereType('ของหวาน');
    notifyListeners();
  }

  Future getProductWhereId(String id) async {
    _product = await ProductApi().getProductWhereId(id: id);
    notifyListeners();
  }

  bool checkFavorite(String idProduct, List<ProductModel> idFavorite) {
    for (var i = 0; i < idFavorite.length; i++) {
      if (idProduct == idFavorite[i].productId) {
        return true;
      }
    }
    return false;
  }
}
