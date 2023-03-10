import 'package:charoz/Model/Data/product_model.dart';
import 'package:charoz/Service/Firebase/product_crud.dart';
import 'package:get/get.dart';

class ProductViewModel extends GetxController {
  final RxList<ProductModel> _productList = <ProductModel>[].obs;
  final RxList<ProductModel> _productTypeList = <ProductModel>[].obs;
  final RxList<ProductModel> _productSuggestList = <ProductModel>[].obs;
  ProductModel? _product;

  get product => _product;
  get productList => _productList;
  get productTypeList => _productTypeList;
  get productSuggestList => _productSuggestList;

  Future readProductAllList() async {
    _productList.value = await ProductCRUD().readProductAllList();
  }

  void getProductSuggestList() {
    print(_productList.length);
    _productSuggestList.value =
        _productList.where((item) => item.suggest == true).toList();
  }

  void getProductTypeList(int type) {
    _productTypeList.value =
        _productList.where((item) => item.type == type).toList();
  }

  void setProductModel(ProductModel model) {
    _product = model;
    update();
  }

  // Future readProductTypeList(String type) async {
  //   if (_productList.isNotEmpty) {
  //     _productList.clear();
  //   }
  //   _productList = await ProductCRUD().readProductTypeList(type);
  // }

  void selectProductWhereId(String id) {
    _product = _productList.firstWhere((element) => element.id == id);
  }

  void deleteProductWhereId(String id) {
    _productList.removeWhere((item) => item.id == id);
  }

  void clearProductData() {
    _productTypeList.clear();
    _product = null;
  }

  void clearSuggestData() {
    _productSuggestList.clear();
    _product = null;
  }
}
