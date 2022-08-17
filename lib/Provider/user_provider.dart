import 'package:charoz/Model_Main/user_model.dart';
import 'package:charoz/Service/Database/Firebase/user_crud.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Function/data_manager.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? _customer;
  UserModel? _rider;
  UserModel? _manager;
  List<UserModel>? _userList;

  get user => _user;
  get customer => _customer;
  get rider => _rider;
  get manager => _manager;
  get userList => _userList;

  Future getUserPreference(BuildContext context) async {
    _user = await UserCRUD().readUserByToken();
    MyVariable.login = true;
    MyVariable.userTokenId = _user!.id;
    MyVariable.role = _user!.role;
    if (_user!.status == 0) {
      DialogAlert().doubleDialog(context, 'คุณถูกระงับการใช้งาน',
          'โปรดติดต่อสอบถามผู้ดูแลระบบเมื่อมีข้อสงสัย');
      signOutFirebase(context);
    } else if (_user!.pincode != '') {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routeCodeVerify, (route) => false);
      });
    } else {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routePageNavigation, (route) => false);
      });
    }
  }

  Future<bool> checkPhoneAndGetUser(String phone) async {
    _user = await UserCRUD().readUserByPhone(phone);
    if (_user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future readUserById(String id) async {
    _user = await UserCRUD().readUserById(id);
    notifyListeners();
  }

  Future signOutFirebase(BuildContext context) async {
    await MyVariable.auth
        .signOut()
        .then((value) => setLogoutVariable(context))
        .catchError((e) {
      EasyLoading.dismiss();
      DialogAlert().singleDialog(context, e.code);
    });
  }

  Future readUserList() async {
    _userList = await UserCRUD().readUserList();
    notifyListeners();
  }

  Future readCustomerById(String id) async {
    _customer = await UserCRUD().readUserById(id);
    notifyListeners();
  }

  Future readRiderById(String id) async {
    _rider = await UserCRUD().readUserById(id);
    notifyListeners();
  }

  Future readManagerById(String id) async {
    _manager = await UserCRUD().readUserById(id);
    notifyListeners();
  }

  void setLoginVariable(BuildContext context) {
    MyVariable.login = true;
    MyVariable.role = _user!.role;
    MyVariable.userTokenId = _user!.id;
    MyVariable.indexNotiChip = 0;
    MyVariable.indexOrderChip = 0;
    DataManager().clearAllData(context);
    EasyLoading.dismiss();
    MyFunction().toast('ยินดีต้อนรับสู่ Application');
    Navigator.pushNamedAndRemoveUntil(
        context, RoutePage.routePageNavigation, (route) => false);
  }

  void setLogoutVariable(BuildContext context) {
    _user = null;
    MyVariable.login = false;
    MyVariable.role = '';
    MyVariable.userTokenId = '';
    MyVariable.indexNotiChip = 0;
    DataManager().clearAllData(context);
    EasyLoading.dismiss();
    MyFunction().toast('ลงชื่อออกจากระบบ สำเร็จ');
    Navigator.pushNamedAndRemoveUntil(
        context, RoutePage.routePageNavigation, (route) => false);
  }

  void clearUserData() {
    _customer = null;
    _rider = null;
    _manager = null;
    _userList = null;
  }
}
