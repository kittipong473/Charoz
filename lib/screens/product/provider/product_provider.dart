import 'package:charoz/screens/product/model/product_model.dart';
import 'package:charoz/services/api/product_api.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? _product;

  List<ProductModel> _productsFood = [];
  List<ProductModel> _productsSnack = [];
  List<ProductModel> _productsDrink = [];
  List<ProductModel> _productsSweet = [];
  List<ProductModel> _productsSuggest = [];
  List<ProductModel> _productsFavorite = [];

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

  get productsFavorite => _productsFavorite;
  get productsFavoriteLength => _productsFavorite.length;

  Future initial() async {
    _productsFood = await ProductApi().getProductWhereType('อาหาร');
    _productsSnack = await ProductApi().getProductWhereType('ออร์เดิฟ');
    _productsDrink = await ProductApi().getProductWhereType('เครื่องดื่ม');
    _productsSweet = await ProductApi().getProductWhereType('ของหวาน');
    return true;
  }

  Future getProductSuggest() async {
    _productsSuggest = await ProductApi().getProductWhereSuggest();
    notifyListeners();
  }

  Future getProductWhereType(String type) async {
    if (type == 'อาหาร') {
      _productsFood = await ProductApi().getProductWhereType('อาหาร');
    } else if (type == 'ออร์เดิฟ') {
      _productsSnack = await ProductApi().getProductWhereType('ออร์เดิฟ');
    } else if (type == 'เครื่องดื่ม') {
      _productsDrink = await ProductApi().getProductWhereType('เครื่องดื่ม');
    } else if (type == 'ของหวาน') {
      _productsSweet = await ProductApi().getProductWhereType('ของหวาน');
    }
    notifyListeners();
  }

  Future getProductWhereId(String id) async {
    _product = await ProductApi().getProductWhereId(id: id);
    notifyListeners();
  }

  Future getProductWhereFavorite(String id) async {
    _productsFavorite = await ProductApi().getProductWhereFavorite(id);
    return _productsFavorite;
  }

  void insertFavorite(ProductModel product) {
    _productsFavorite.add(product);
    notifyListeners();
  }

  void removeFavorite(ProductModel product) {
    _productsFavorite.remove(product);
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

  Future changeStatus(String status, String type, String id) async {
    bool change = await ProductApi().editStatusWhereProduct(status, id);
    if (change) {
      getProductWhereType(type);
    }
    if (status == 'ขาย') {
      return true;
    } else {
      return false;
    }
  }
}
