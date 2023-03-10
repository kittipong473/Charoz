import 'package:charoz/Service/Restful/api_controller.dart';
import 'package:charoz/View_Model/address_vm.dart';
import 'package:charoz/View_Model/config_vm.dart';
import 'package:charoz/View_Model/noti_vm.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:charoz/View_Model/time_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:get/get.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ApiController());
    Get.put(AddressViewModel());
    Get.put(ConfigViewModel());
    Get.put(NotiViewModel());
    Get.put(OrderViewModel());
    Get.put(ProductViewModel());
    Get.put(ShopViewModel());
    Get.put(TimeViewModel());
    Get.put(UserViewModel());
  }
}
