import 'package:charoz/Model/Data/shop_model.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/shop_crud.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShopViewModel extends GetxController {
  RxString _shopStatus = ''.obs;
  RxBool _allowLocation = false.obs;
  ShopModel? _shop;
  RxList<ShopModel> _shopList = <ShopModel>[].obs;

  get shopStatus => _shopStatus.value;
  get allowLocation => _allowLocation.value;
  get shop => _shop;
  get shopList => _shopList;

  Future readShopModel() async {
    _shop = await ShopCRUD().readShopModel();
    update();
    // getTimeStatus();
  }

  Future checkLocation() async {
    _allowLocation.value = await MyFunction().checkPermission();
    if (_allowLocation.value) ;
    update();
  }

  // void getTimeStatus() {
  //   List<String> times = MyFunction().convertToList(_shop!.timetype);
  //   var now = DateTime.now();
  //   var timenow = DateFormat('HH.mm').format(DateTime.now());
  //   double cal = double.parse(timenow);
  //   if (_shop!.choose == 0) {
  //     if (now.weekday >= 1 && now.weekday <= 6) {
  //       if (cal >= convertTime(_shop!.open) &&
  //           cal <= convertTime(_shop!.close)) {
  //         _shopStatus.value = times[0];
  //       } else {
  //         _shopStatus.value = times[1];
  //       }
  //     } else {
  //       _shopStatus.value = times[1];
  //     }
  //   } else if (_shop!.choose == 1) {
  //     _shopStatus.value = times[2];
  //   } else {
  //     _shopStatus.value = times[3];
  //   }
  // }

  double convertTime(String value) {
    var init = DateTime.parse("2022-05-01T$value.000Z");
    var time = DateFormat('HH.mm').format(init);
    double result = double.parse(time);
    return result;
  }

  void clearShopData() {
    _shopStatus.value = '';
    _shop = null;
    _shopList.clear();
  }
}
