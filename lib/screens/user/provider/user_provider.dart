import 'package:charoz/screens/user/model/user_model.dart';
import 'package:charoz/services/api/user_api.dart';
import 'package:charoz/services/route/route_page.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  String? _userFavorite;
  UserModel? _user;

  List<String> _favorites = [];
  List<UserModel> _users = [];

  get userFavorite => _userFavorite;

  get user => _user;

  get favorites => _favorites;
  get favoritesLength => _favorites.length;

  get users => _users;
  get usersLength => _users.length;

  Future getAllUser() async {
    _users = await UserApi().getAllUser();
    notifyListeners();
  }

  Future getUserWhereToken() async {
    _user = await UserApi().getUserWhereToken(token: MyVariable.accountUid);
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
            context, RoutePage.routeHomeService, (route) => false);
        notifyListeners();
      });
    });
  }

  // Future convertFavorite() async {
  //   if (_user!.userFavourite != 'null') {
  //     String string = _user!.userFavourite;
  //     _userFavorite = string.substring(1, string.length - 1);
  //     _favorites = _userFavorite!.split(',');
  //     ProductProvider().getProductWhereFavorite(_userFavorite!);
  //     return _userFavorite;
  //   } else {
  //     return 'null';
  //   }
  // }

  void addFavorite(String id) {
    _favorites.add(id);
    editFavoriteWhereUser();
  }

  void removeFavorite(String id) {
    _favorites.remove(id);
    editFavoriteWhereUser();
  }

  Future editFavoriteWhereUser() async {
    bool status =
        await UserApi().editFavoriteWhereUser(favorites: _favorites.toString());
    if (status) {
      MyWidget().toast('แก้ไขรายการโปรดแล้ว');
      return true;
    } else {
      return false;
    }
  }
}
