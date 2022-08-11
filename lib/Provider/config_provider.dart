import 'package:charoz/Model_Main/banner_model.dart';
import 'package:charoz/Model_Main/maintenance_model.dart';
import 'package:charoz/Model_Main/privacy_model.dart';
import 'package:charoz/Model_Main/test_model.dart';
import 'package:charoz/Service/Database/Firebase/config_crud.dart';
import 'package:flutter/foundation.dart';

class ConfigProvider with ChangeNotifier {
  MaintenanceModel? _maintenance;
  List<BannerModel>? _bannerList;
  List<PrivacyModel>? _privacyList;
  List<TestModel>? _testList;

  get maintenance => _maintenance;
  get bannerList => _bannerList;
  get privacyList => _privacyList;
  get testList => _testList;

  Future readBannerList() async {
    if (_bannerList == null) {
      _bannerList = await ConfigCRUD().readBannerList();
      notifyListeners();
    }
  }

  Future readPrivacyList() async {
    if (_privacyList == null) {
      _privacyList = await ConfigCRUD().readPrivacyList();
      notifyListeners();
    }
  }

  Future readMaintenanceFromStatus(int status) async {
    _maintenance = await ConfigCRUD().readMaintenanceFromStatus(status);
    notifyListeners();
  }

  void clearConfigData() {
    _maintenance = null;
    _bannerList = null;
    _privacyList = null;
  }
}
