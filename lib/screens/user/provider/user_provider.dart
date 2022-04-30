import 'package:charoz/screens/product/provider/product_provider.dart';
import 'package:charoz/screens/user/model/user_model.dart';
import 'package:charoz/services/api/user_api.dart';
import 'package:charoz/services/route/route_page.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

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

  Future<bool> checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('status') == 'avaliable') {
      MyVariable.role = preferences.getString('role')!;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkUserWherePhone(String phone) async {
    bool check = await UserApi().checkUserWherePhone(phone: phone);
    return check;
  }

  String encryption({required String text}) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(text, iv: iv);
    // final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return encrypted.base16.toString();
  }

  Future<bool> loginUser(
      {required String phone, required String password}) async {
    _user = await UserApi().loginUser(phone: phone, password: password);
    if (_user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkStatus() async {
    if (_user!.userStatus == 'avaliable') {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('id', _user!.userId);
      preferences.setString('role', _user!.userRole);
      preferences.setString('status', _user!.userStatus);
      return true;
    } else {
      return false;
    }
  }

  Future getUserWhereIdPreference() async {
    _user = await UserApi().getUserWhereIdPreference();
    notifyListeners();
  }

  Future signOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    MyWidget().toast('ลงชื่อออก สำเร็จ');
    MyVariable.indexPage = 0;
    MyVariable.login = false;
    MyVariable.role = '';
    Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routeHomeService, (route) => false);
    notifyListeners();
  }

  Future convertFavorite() async {
    if (_user!.userFavourite != 'null') {
      String string = _user!.userFavourite;
      _userFavorite = string.substring(1, string.length - 1);
      _favorites = _userFavorite!.split(',');
      ProductProvider().getProductWhereFavorite(_userFavorite!);
      return _userFavorite;
    } else {
      return 'null';
    }
  }

  void addFavorite(String id) {
    _favorites.add(id);
    editFavoriteWhereUser();
  }

  void removeFavorite(String id) {
    _favorites.remove(id);
    editFavoriteWhereUser();
  }

  Future editFavoriteWhereUser() async {
    bool status = await UserApi()
        .editFavoriteWhereUser(favorites: _favorites.toString());
    if (status) {
      MyWidget().toast('แก้ไขรายการโปรดแล้ว');
      return true;
    } else {
      return false;
    }
  }
}
