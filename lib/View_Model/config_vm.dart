import 'package:charoz/Model/Data/banner_model.dart';
import 'package:charoz/Model/Data/maintenance_model.dart';
import 'package:charoz/Model/Data/privacy_model.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/config_crud.dart';
import 'package:get/get.dart';

class ConfigViewModel extends GetxController {
  MaintenanceModel? _maintenance;
  RxList<BannerModel> _bannerList = <BannerModel>[].obs;
  RxList<PrivacyModel> _privacyList = <PrivacyModel>[].obs;

  get maintenance => _maintenance;
  get bannerList => _bannerList;
  get privacyList => _privacyList;

  Future readBannerList() async {
    if (_bannerList.isEmpty) {
      _bannerList.value = await ConfigCRUD().readBannerList();
      update();
    }
  }

  Future readPrivacyList() async {
    if (_privacyList.isEmpty) {
      _privacyList = await ConfigCRUD().readPrivacyList();
      update();
    }
  }

  Future readMaintenanceFromStatus(int status) async {
    _maintenance = await ConfigCRUD().readMaintenanceFromStatus(status);
    update();
  }

  void clearConfigData() {
    _maintenance = null;
    _bannerList.clear();
    _privacyList.clear();
  }
}
