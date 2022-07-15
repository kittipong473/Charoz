import 'package:charoz/Model/noti_model.dart';
import 'package:charoz/Service/Api/PHP/noti_api.dart';
import 'package:flutter/cupertino.dart';

class NotiProvider with ChangeNotifier {
  NotiModel? _noti;
  List<NotiModel>? _notiList;

  get noti => _noti;
  get notiList => _notiList;

  Future getAllNotiWhereType(String type) async {
    _notiList = await NotiApi().getAllNotiWhereType(type: type);
    notifyListeners();
  }

  void selectAddressWhereId(int id) {
    _noti = _notiList!.firstWhere((element) => element.notiId == id);
  }
}
