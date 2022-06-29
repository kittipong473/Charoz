import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Model/time_model.dart';
import 'package:charoz/Service/Api/shop_api.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ShopProvider with ChangeNotifier {
  String? _shopStatus;
  ShopModel? _shop;
  TimeModel? _time;

  List<String>? _shopImageList;
  List<ShopModel>? _shopList;

  get shopStatus => _shopStatus;
  get shop => _shop;
  get time => _time;
  get shopImageList => _shopImageList;
  get shopList => _shopList;

  void getShopDetailImage() {
    _shopImageList = [MyImage.showshop2, MyImage.showshop3, MyImage.showshop4];
  }

  Future getShopWhereId() async {
    _shop = await ShopApi().getShopWhereId();
    notifyListeners();
  }

  Future getAllShop() async {
    _shopList = await ShopApi().getAllShop();
    notifyListeners();
  }

  Future getTimeWhereId() async {
    _time = await ShopApi().getTimeWhereId();
    _shopStatus = getCurrentTime(_time!.timeStatus);
    notifyListeners();
  }

  String getCurrentTime(String value) {
    List<String> times = MyFunction().convertToList(value);
    var now = DateTime.now();
    var timenow = DateFormat('HH.mm').format(DateTime.now());
    double cal = double.parse(timenow);
    if (_time!.timeChoose == 'เปิดตามเวลาปกติ') {
      if (now.weekday >= 1 && now.weekday <= 5) {
        if (cal >= convertTime(_time!.timeWeekdayOpen) &&
            cal <= convertTime(_time!.timeWeekdayClose)) {
          return times[0];
        } else {
          return times[1];
        }
      } else {
        if (cal >= convertTime(_time!.timeWeekendOpen) &&
            cal <= convertTime(_time!.timeWeekendClose)) {
          return times[0];
        } else {
          return times[1];
        }
      }
    } else if (_time!.timeChoose == 'ปิดชั่วคราว') {
      return times[2];
    } else {
      return times[3];
    }
  }

  double convertTime(String value) {
    var init = DateTime.parse("2022-05-01T$value.000Z");
    var time = DateFormat('HH.mm').format(init);
    double result = double.parse(time);
    return result;
  }
}
