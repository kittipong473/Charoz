import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Service/Api/user_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Function/show_toast.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  List<UserModel>? _userList;

  get user => _user;
  get userList => _userList;

  Future getAllUser() async {
    _userList = await UserApi().getAllUser();
    notifyListeners();
  }

  Future getUserWhereToken() async {
    _user = await UserApi().getUserWhereToken();
    MyVariable.role = _user!.userRole;
    MyVariable.userTokenId = _user!.userId;
    notifyListeners();
  }

  Future<String> getUserEmailWherePhone({required String phone}) async {
    _user = await UserApi().getUserWherePhone(phone: phone);
    return _user!.userEmail;
  }

  Future<String> getUserRoleWherePhone({required String phone}) async {
    _user = await UserApi().getUserWherePhone(phone: phone);
    return _user!.userRole;
  }

  Future<int> getUserIdWherePhone({required String phone}) async {
    _user = await UserApi().getUserWherePhone(phone: phone);
    return _user!.userId;
  }

  Future<bool> checkPhonetoEmail(String phone) async {
    bool status = await UserApi().checkUserWherePhone(phone: phone);
    if (!status) {
      _user = await UserApi().getUserWherePhone(phone: phone);
      return true;
    } else {
      return false;
    }
  }

  Future authenFirebase(BuildContext context, String password) async {
    await MyVariable.auth
        .signInWithEmailAndPassword(email: _user!.userEmail, password: password)
        .then((value) {
      MyVariable.login = true;
      MyVariable.indexPageNavigation = 0;
      MyVariable.role = _user!.userRole;
      MyVariable.userTokenId = _user!.userId;
      MyVariable.indexNotiChip = 0;
      ShowToast().toast('ยินดีต้อนรับสู่ Application');
      Navigator.pushNamedAndRemoveUntil(
          context, RoutePage.routePageNavigation, (route) => false);
      return true;
    }).catchError((e) {
      DialogAlert().singleDialog(context, MyFunction().authenAlert(e.code));
    });
  }

  Future signOutFirebase(BuildContext context) async {
    await MyVariable.auth.signOut().then((value) async {
      ShowToast().toast('ลงชื่อออก สำเร็จ');
      MyVariable.indexPageNavigation = 0;
      MyVariable.login = false;
      MyVariable.role = '';
      MyVariable.userTokenId = 0;
      MyVariable.indexNotiChip = 0;
      Navigator.pushNamedAndRemoveUntil(
          context, RoutePage.routePageNavigation, (route) => false);
      notifyListeners();
    });
  }
}
