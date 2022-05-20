import 'package:charoz/Screen/User/Model/user_model.dart';
import 'package:charoz/Service/Api/user_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  List<UserModel> _users = [];

  get user => _user;

  get users => _users;
  get usersLength => _users.length;

  Future getAllUser() async {
    _users = await UserApi().getAllUser();
    notifyListeners();
  }

  Future getUserWhereToken() async {
    _user = await UserApi().getUserWhereToken();
    MyVariable.role = _user!.userRole;
    notifyListeners();
  }

  Future<String> getUserEmailWherePhone({required String phone}) async {
    _user = await UserApi().getUserEmailWherePhone(phone: phone);
    return _user!.userEmail;
  }

  Future<String> getUserRoleWherePhone({required String phone}) async {
    _user = await UserApi().getUserEmailWherePhone(phone: phone);
    return _user!.userRole;
  }

  Future signOutFirebase(BuildContext context) async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.signOut().then((value) async {
        MyWidget().toast('ลงชื่อออก สำเร็จ');
        MyVariable.indexPage = 0;
        MyVariable.login = false;
        MyVariable.role = '';
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routePageNavigation, (route) => false);
        notifyListeners();
      });
    });
  }
}
