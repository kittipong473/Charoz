import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Service/Api/PHP/user_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/load_data.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/global_variable.dart';
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

  Future getAllUser() async {
    _userList = await UserApi().getAllUser();
    notifyListeners();
  }

  Future getCustomerWhereId(int id) async {
    _customer = await UserApi().getUserWhereId(id: id);
    notifyListeners();
  }

  Future getRiderWhereId(int id) async {
    _rider = await UserApi().getUserWhereId(id: id);
    notifyListeners();
  }

  Future getManagerWhereId(int id) async {
    _manager = await UserApi().getUserWhereId(id: id);
    notifyListeners();
  }

  Future getUserWhereId(int id) async {
    _user = await UserApi().getUserWhereId(id: id);
    notifyListeners();
  }

  Future<bool> checkPhoneAndGetUser(String phone) async {
    bool status = await UserApi().checkUserWherePhone(phone: phone);
    if (status) {
      _user = await UserApi().getUserWherePhone(phone: phone);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkPhone(String phone) async {
    bool status = await UserApi().checkUserWherePhone(phone: phone);
    if (status) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkEmail(String email) async {
    bool status = await UserApi().checkUserWhereEmail(email: email);
    if (status) {
      return true;
    } else {
      return false;
    }
  }

  Future getUserWhereToken() async {
    _user = await UserApi().getUserWhereToken();
    GlobalVariable.login = true;
    GlobalVariable.role = _user!.userRole;
    GlobalVariable.userTokenId = _user!.userId;
    notifyListeners();
  }

  Future authenEmailFirebase(
      BuildContext context, String phone, String password) async {
    bool status = await checkPhoneAndGetUser(phone);
    if (status) {
      await GlobalVariable.auth
          .signInWithEmailAndPassword(
              email: _user!.userEmail, password: password)
          .then((value) => setLoginVariable(context))
          .catchError((e) {
        EasyLoading.dismiss();
        DialogAlert().singleDialog(context, MyFunction().authenAlert(e.code));
      });
    } else {
      EasyLoading.dismiss();
      DialogAlert().doubleDialog(context, 'เบอร์โทรศัพท์นี้ไม่มีอยู่ในระบบ',
          'กรุณาสมัครสมาชิกก่อนจึงเข้าใช้งาน');
    }
  }

  void setLoginVariable(BuildContext context) {
    GlobalVariable.login = true;
    GlobalVariable.indexPageNavigation = 0;
    GlobalVariable.role = _user!.userRole;
    GlobalVariable.userTokenId = _user!.userId;
    GlobalVariable.indexNotiChip = 0;
    EasyLoading.dismiss();
    MyFunction().toast('ยินดีต้อนรับสู่ Application');
    LoadData().getDataByRole(context);
    Navigator.pushNamedAndRemoveUntil(
        context, RoutePage.routePageNavigation, (route) => false);
  }

  void setLogoutVariable(BuildContext context) {
    GlobalVariable.login = false;
    GlobalVariable.indexPageNavigation = 0;
    GlobalVariable.role = '';
    GlobalVariable.userTokenId = 0;
    GlobalVariable.indexNotiChip = 0;
    EasyLoading.dismiss();
    MyFunction().toast('ลงชื่อออก สำเร็จ');
    LoadData().getDataByRole(context);
    Navigator.pushNamedAndRemoveUntil(
        context, RoutePage.routePageNavigation, (route) => false);
  }

  Future signOutFirebase(BuildContext context) async {
    await GlobalVariable.auth
        .signOut()
        .then((value) => setLogoutVariable(context))
        .catchError((e) {
      EasyLoading.dismiss();
      DialogAlert().singleDialog(context, e.code);
    });
  }

  void checkUserPinSetting(BuildContext context) {
    if (_user != null) {
      if (_user!.userPinCode == 'null') {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => DialogAlert().alertPinCode(context));
      }
    }
  }
}
