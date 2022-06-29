import 'package:charoz/Model/noti_model.dart';
import 'package:charoz/Service/Api/noti_api.dart';
import 'package:flutter/cupertino.dart';

class NotiProvider with ChangeNotifier {
  NotiModel? _noti;
  List<NotiModel>? _notificateList;
  List<NotiModel>? _notiOrderList;

  get noti => _noti;
  get notificateList => _notificateList;
  get notiOrderList => _notiOrderList;

  Future getAllNoti() async {
    notifyListeners();
  }

  Future getAllNotiWhereType(String type) async {
    _notificateList = await NotiApi().getAllNotiWhereType(type: type);
    notifyListeners();
  }

  Future getNotiWhereId(int id) async {
    _noti = await NotiApi().getNotiWhereId(id: id);
    notifyListeners();
  }
}
