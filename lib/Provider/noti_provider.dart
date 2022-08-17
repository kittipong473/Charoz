import 'package:charoz/Model_Main/noti_model.dart';
import 'package:charoz/Service/Database/Firebase/noti_crud.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/cupertino.dart';

class NotiProvider with ChangeNotifier {
  NotiModel? _noti;
  List<NotiModel>? _notiList;

  get noti => _noti;
  get notiList => _notiList;

  Future readNotiTypeList(String type) async {
    if (MyVariable.role == 'customer') {
      _notiList = await NotiCRUD().readNotiByCustomer(type);
    } else if (MyVariable.role == 'rider') {
      _notiList = await NotiCRUD().readNotiByRider(type);
    } else {
      _notiList = await NotiCRUD().readAllNoti(type);
    }
    notifyListeners();
  }

  void selectAddressWhereId(String id) {
    _noti = _notiList!.firstWhere((element) => element.id == id);
  }

  void clearNotiData() {
    _noti = null;
    _notiList = null;
  }
}
