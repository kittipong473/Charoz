import 'package:charoz/Model/Data/product_model.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/product_crud.dart';
import 'package:get/get.dart';

class ProductViewModel extends GetxController {
  ProductModel? _product;
  RxList<ProductModel> _productAlls = <ProductModel>[].obs;
  RxList<ProductModel> _productList = <ProductModel>[].obs;

  get product => _product;
  get productAlls => _productAlls;
  get productList => _productList;

  Future readProductAllList() async {
    _productAlls = await ProductCRUD().readProductAllList();
  }

  Future readProductSuggestList() async {
    if (_productList.isNotEmpty) {
      _productList.clear();
    }
    _productList.value = await ProductCRUD().readProductSuggestList();
    update();
  }

  Future readProductTypeList(String type) async {
    if (_productList.isNotEmpty) {
      _productList.clear();
    }
    _productList = await ProductCRUD().readProductTypeList(type);
  }

  void selectProductWhereId(String id) {
    _product = _productAlls.firstWhere((element) => element.id == id);
  }

  void deleteProductWhereId(String id) {
    _productList.removeWhere((item) => item.id == id);
  }

  void clearProductData() {
    _product = null;
    _productList.clear();
    _productAlls.clear();
  }
}
