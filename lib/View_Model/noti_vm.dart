import 'package:charoz/Model/Data/noti_model.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/noti_crud.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NotiViewModel extends GetxController {
  NotiModel? _noti;
  RxList<NotiModel> _notiList = <NotiModel>[].obs;

  get noti => _noti;
  get notiList => _notiList;

  Future readNotiTypeList(String type) async {
    if (VariableGeneral.role == 'customer') {
      _notiList = await NotiCRUD().readNotiByCustomer(type);
    } else if (VariableGeneral.role == 'rider') {
      _notiList = await NotiCRUD().readNotiByRider(type);
    } else {
      _notiList = await NotiCRUD().readAllNoti(type);
    }
    update();
  }

  void selectAddressWhereId(String id) {
    _noti = _notiList.firstWhere((element) => element.id == id);
  }

  void clearNotiData() {
    _noti = null;
    _notiList.clear();
  }
}
