import 'package:charoz/Model/noti_model.dart';
import 'package:charoz/Service/Database/Firebase/noti_crud.dart';
import 'package:flutter/cupertino.dart';

class NotiProvider with ChangeNotifier {
  NotiModel? _noti;
  List<NotiModel>? _notiList;

  get noti => _noti;
  get notiList => _notiList;

  Future readNotiTypeList(String type) async {
    _notiList = await NotiCRUD().readNotiTypeList(type);
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
