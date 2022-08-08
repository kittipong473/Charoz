import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Model/time_model.dart';
import 'package:charoz/Service/Database/Firebase/shop_crud.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ShopProvider with ChangeNotifier {
  String? _shopStatus;
  ShopModel? _shop;
  TimeModel? _time;
  List<ShopModel>? _shopList;

  get shopStatus => _shopStatus;
  get shop => _shop;
  get time => _time;
  get shopList => _shopList;

  Future readShopModel() async {
    _shop = await ShopCRUD().readShopModel();
    notifyListeners();
  }

  Future readTimeModel() async {
    _time = await ShopCRUD().readTimeModel();
    getTimeStatus();
    notifyListeners();
  }

  void getTimeStatus() {
    List<String> times = MyFunction().convertToList(_time!.status);
    var now = DateTime.now();
    var timenow = DateFormat('HH.mm').format(DateTime.now());
    double cal = double.parse(timenow);
    if (_time!.choose == 'เปิดตามเวลาปกติ') {
      if (now.weekday >= 1 && now.weekday <= 6) {
        if (cal >= convertTime(_time!.open) &&
            cal <= convertTime(_time!.close)) {
          _shopStatus = times[0];
        } else {
          _shopStatus = times[1];
        }
      } else {
        _shopStatus = times[1];
      }
    } else if (_time!.choose == 'ปิดชั่วคราว') {
      _shopStatus = times[2];
    } else {
      _shopStatus = times[3];
    }
  }

  double convertTime(String value) {
    var init = DateTime.parse("2022-05-01T$value.000Z");
    var time = DateFormat('HH.mm').format(init);
    double result = double.parse(time);
    return result;
  }

  void clearShopData() {
    _shopStatus = null;
    _shop = null;
    _time = null;
    _shopList = null;
  }
}
