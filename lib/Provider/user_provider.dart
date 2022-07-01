import 'package:charoz/Component/User/register_phone.dart';
import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Service/Api/user_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Function/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  List<UserModel>? _userList;

  get user => _user;
  get userList => _userList;

  Future getAllUser() async {
    _userList = await UserApi().getAllUser();
    notifyListeners();
  }

  Future<bool> checkPhoneAndGetUser(String phone) async {
    bool status = await UserApi().checkUserWherePhone(phone: phone);
    if (!status) {
      _user = await UserApi().getUserWherePhone(phone: phone);
      return true;
    } else {
      return false;
    }
  }

  Future getUserWhereToken() async {
    _user = await UserApi().getUserWhereToken();
    MyVariable.login = true;
    MyVariable.role = _user!.userRole;
    MyVariable.userTokenId = _user!.userId;
    notifyListeners();
  }

  Future authenTokenFirebase(BuildContext context, String verificationID,
      String smsCode, String phone) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: smsCode);
    await MyVariable.auth.signInWithCredential(credential).then((value) async {
      bool status = await checkPhoneAndGetUser(phone);
      if (!status) {
        setLoginVariable(context);
      } else {
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterPhone(
              phone: phone,
              tokenP: value.user!.uid,
            ),
          ),
        );
      }
    });
  }

  Future authenEmailFirebase(
      BuildContext context, String phone, String password) async {
    bool status = await checkPhoneAndGetUser(phone);
    if (status) {
      await MyVariable.auth
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
    MyVariable.login = true;
    MyVariable.indexPageNavigation = 0;
    MyVariable.role = _user!.userRole;
    MyVariable.userTokenId = _user!.userId;
    MyVariable.indexNotiChip = 0;
    EasyLoading.dismiss();
    ShowToast().toast('ยินดีต้อนรับสู่ Application');
    Navigator.pushNamedAndRemoveUntil(
        context, RoutePage.routePageNavigation, (route) => false);
  }

  void setLogoutVariable(BuildContext context) {
    MyVariable.login = false;
    MyVariable.indexPageNavigation = 0;
    MyVariable.role = '';
    MyVariable.userTokenId = 0;
    MyVariable.indexNotiChip = 0;
    EasyLoading.dismiss();
    ShowToast().toast('ลงชื่อออก สำเร็จ');
    Navigator.pushNamedAndRemoveUntil(
        context, RoutePage.routePageNavigation, (route) => false);
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
}
