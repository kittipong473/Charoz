import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/Service/Firebase/product_crud.dart';
import 'package:get/get.dart';

class ProductViewModel extends GetxController {
  List<String> datatypeProduct = ['อาหาร', 'ทานเล่น', 'เครื่องดื่ม', 'ของหวาน'];

  final RxList<ProductModel> _productList = <ProductModel>[].obs;
  final RxList<ProductModel> _productTypeList = <ProductModel>[].obs;
  final RxList<ProductModel> _productSuggestList = <ProductModel>[].obs;
  ProductModel? _product;

  ProductModel? get product => _product;
  List<ProductModel> get productList => _productList;
  List<ProductModel> get productTypeList => _productTypeList;
  List<ProductModel> get productSuggestList => _productSuggestList;

  Future readProductAllList() async {
    _productList.value = await ProductCRUD().readProductAllList();
  }

  void getProductSuggestList() {
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
