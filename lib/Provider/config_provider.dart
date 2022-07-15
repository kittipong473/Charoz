import 'package:charoz/Model/banner_model.dart';
import 'package:charoz/Model/maintain_model.dart';
import 'package:charoz/Service/Api/PHP/config_api.dart';
import 'package:flutter/foundation.dart';

class ConfigProvider with ChangeNotifier {
  MaintainModel? _maintain;
  List<BannerModel>? _bannerList;

  get maintain => _maintain;
  get bannerList => _bannerList;

  Future getAllBanner() async {
    _bannerList = await ConfigApi().getAllBanner();
    notifyListeners();
  }

  Future getMaintenance(int status) async {
    _maintain = await ConfigApi().getMaintainWhereStatus(status: status);
    notifyListeners();
  }
}
