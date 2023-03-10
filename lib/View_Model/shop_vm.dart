import 'package:charoz/Model/Data/shop_model.dart';
import 'package:charoz/Service/Firebase/shop_crud.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:get/get.dart';

class ShopViewModel extends GetxController {
  final RxList<ShopModel> _shopList = <ShopModel>[].obs;
  final RxBool _allowLocation = false.obs;
  ShopModel? _shop;

  get allowLocation => _allowLocation.value;
  get shop => _shop;
  get shopList => _shopList;

  Future readShopModel() async {
    _shop = await ShopCRUD().readShopModel();
    update();
  }

  Future checkLocation() async {
    _allowLocation.value = await MyFunction().checkPermission();
    // if (_allowLocation.value) ;
    update();
  }
}
