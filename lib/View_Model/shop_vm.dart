import 'package:charoz/Model/Api/FireStore/shop_model.dart';
import 'package:charoz/Service/Firebase/shop_crud.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShopViewModel extends GetxController {
  final RxList<ShopModel> _shopList = <ShopModel>[].obs;
  final RxBool _allowLocation = false.obs;
  final RxString _shopStatus = ''.obs;
  ShopModel? _shop;

  get allowLocation => _allowLocation.value;
  get shopStatus => _shopStatus.value;
  get shop => _shop;
  get shopList => _shopList;

  List<String> timeType = [
    'เปิดบริการ',
    'ปิดบริการ',
    'ปิดชั่วคราว',
    'ปิดกรณีพิเศษ'
  ];

  List<String> dayType = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];

  Future<void> readShopModel() async {
    _shop = await ShopCRUD().readShopModel();
    update();
  }

  Future<void> checkLocation() async {
    _allowLocation.value = await MyFunction().checkPermission();
    // if (_allowLocation.value) ;
    update();
  }

  // Future readTimeModel() async {
  //   _time = await TimeCRUD().readTimeModel();
  //   getTimeStatus();
  // }

  // void getTimeStatus() {
  //   String? dayNow = getIndexOfDay();
  //   if (dayNow == null) {
  //     _shopStatus.value = timeType[1];
  //   } else if (_time!.choose == 1) {
  //     _shopStatus.value = timeType[2];
  //   } else if (_time!.choose == 2) {
  //     _shopStatus.value = timeType[3];
  //   } else {
  //     double timeNow = double.parse(
  //         DateFormat('HH.mm').format(MyFunction().getDateTimeNow()));
  //     List<String> timePeriod = MyFunction().convertToList(dayNow);
  //     if (timeNow >= convertCalculateTime(timePeriod[0]) &&
  //         timeNow <= convertCalculateTime(timePeriod[1])) {
  //       _shopStatus.value = timeType[0];
  //     } else {
  //       _shopStatus.value = timeType[1];
  //     }
  //   }
  //   update();
  // }

  // String? getIndexOfDay() {
  //   var now = DateTime.now();
  //   switch (now.weekday) {
  //     case 1:
  //       return _time?.mon;
  //     case 2:
  //       return _time?.tue;
  //     case 3:
  //       return _time?.wed;
  //     case 4:
  //       return _time?.thu;
  //     case 5:
  //       return _time?.fri;
  //     case 6:
  //       return _time?.sat;
  //     case 7:
  //       return _time?.sun;
  //     default:
  //       return null;
  //   }
  // }

  double convertCalculateTime(String value) {
    var init = DateTime.parse("2023-01-01T$value.000Z");
    var time = DateFormat('HH.mm').format(init);
    return double.parse(time);
  }
}
