import 'package:charoz/Model/Data/banner_model.dart';
import 'package:charoz/Model/Data/maintenance_model.dart';
import 'package:charoz/Model/Data/privacy_model.dart';
import 'package:charoz/Service/Firebase/config_crud.dart';
import 'package:get/get.dart';

class ConfigViewModel extends GetxController {
  final RxList<BannerModel> _bannerList = <BannerModel>[].obs;
  final RxList<PrivacyModel> _privacyList = <PrivacyModel>[].obs;
  MaintenanceModel? _maintenance;

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
    _privacyList.value = await ConfigCRUD().readPrivacyList();
    update();
  }

  Future readMaintenanceFromStatus(int status) async {
    _maintenance = await ConfigCRUD().readMaintenanceFromStatus(status);
    update();
  }

  void clearBannerData() {
    _maintenance = null;
    _bannerList.clear();
    _privacyList.clear();
  }

  void clearPrivacyData() {
    _privacyList.clear();
  }
}
