import 'package:charoz/Screen/Shop/Model/shop_model.dart';
import 'package:charoz/Screen/Shop/Model/time_model.dart';
import 'package:charoz/Service/Api/shop_api.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ShopProvider with ChangeNotifier {
  String? _currentStatus;
  ShopModel? _shop;
  TimeModel? _time;

  List<String> _shopimages = [];
  List<ShopModel> _shops = [];

  get currentStatus => _currentStatus;
  get shop => _shop;
  get time => _time;

  get shopimages => _shopimages;
  get shopimagesLength => _shopimages.length;

  get shops => _shops;
  get shopsLength => _shops.length;

  void getShopDetailImage() {
    _shopimages = [MyImage.showshop2, MyImage.showshop3, MyImage.showshop4];
  }

  Future getShopWhereId() async {
    _shop = await ShopApi().getShopWhereId();
    notifyListeners();
  }

  Future getTimeWhereId() async {
    _time = await ShopApi().getTimeWhereId();
    _currentStatus = getCurrentTime(_time!.timeStatus);
    _currentStatus;
    notifyListeners();
  }

  Future getAllShop() async {
    _shops = await ShopApi().getAllShop();
    notifyListeners();
  }

  String getCurrentTime(String value) {
    List<String> times = [];
    String string = value;
    string = string.substring(1, string.length - 1);
    List<String> strings = string.split(',');
    for (var item in strings) {
      times.add(item.trim());
    }

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
    var init = DateTime.parse("2022-05-01T$value:00.000Z");
    var time = DateFormat('HH.mm').format(init);
    double result = double.parse(time);
    return result;
  }
}
