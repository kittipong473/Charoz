import 'package:charoz/Screen/Notification/Model/noti_model.dart';
import 'package:charoz/Service/Api/noti_api.dart';
import 'package:flutter/cupertino.dart';

class NotiProvider with ChangeNotifier {
  NotiModel? _noti;
  List<NotiModel> _notiPromos = [];
  List<NotiModel> _notiNews = [];

  get noti => _noti;

  get notiPromos => _notiPromos;
  get notiPromosLength => _notiPromos.length;

  get notiNews => _notiNews;
  get notiNewsLength => _notiNews.length;

  Future getAllNoti() async {
    _notiPromos = await NotiApi().getNotiWhereType('โปรโมชั่น');
    _notiNews = await NotiApi().getNotiWhereType('ข่าวสาร');
    notifyListeners();
  }

  Future getNotiWhereId(String id) async {
    _noti = await NotiApi().getNotiWhereId(id: id);
    notifyListeners();
  }
}
