import 'package:charoz/Model_Main/shop_model.dart';
import 'package:charoz/Service/Database/Firebase/shop_crud.dart';
import 'package:charoz/Utilty/Function/location_service.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ShopProvider with ChangeNotifier {
  String? _shopStatus;
  bool? _allowLocation;
  ShopModel? _shop;
  List<ShopModel>? _shopList;

  get shopStatus => _shopStatus;
  get allowLocation => _allowLocation;
  get shop => _shop;
  get shopList => _shopList;

  Future readShopModel() async {
    _shop = await ShopCRUD().readShopModel();
    getTimeStatus();
    notifyListeners();
  }

  Future checkLocation() async {
    _allowLocation = await LocationService().checkPermission();
    notifyListeners();
  }

  void getTimeStatus() {
    List<String> times = MyFunction().convertToList(_shop!.timetype);
    var now = DateTime.now();
    var timenow = DateFormat('HH.mm').format(DateTime.now());
    double cal = double.parse(timenow);
    if (_shop!.choose == 0) {
      if (now.weekday >= 1 && now.weekday <= 6) {
        if (cal >= convertTime(_shop!.open) &&
            cal <= convertTime(_shop!.close)) {
          _shopStatus = times[0];
        } else {
          _shopStatus = times[1];
        }
      } else {
        _shopStatus = times[1];
      }
    } else if (_shop!.choose == 1) {
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
    _shopList = null;
  }
}
