import 'package:charoz/Model/Data/banner_model.dart';
import 'package:charoz/Model/Data/maintenance_model.dart';
import 'package:charoz/Model/Data/privacy_model.dart';
import 'package:charoz/Service/Restful/api_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ConfigCRUD {
  final ApiController capi = Get.find<ApiController>();
  final appstatus = FirebaseFirestore.instance.collection('appstatus');
  final maintenance = FirebaseFirestore.instance.collection('maintenance');
  final banner = FirebaseFirestore.instance.collection('banner');
  final privacy = FirebaseFirestore.instance.collection('privacy');

  Future<int?> readStatusFromAS() async {
    try {
      capi.loadingPage(true);
      final snapshot = await appstatus.doc('bnRgar2MdG3dcS37OYLN').get();
      if (snapshot.exists) {
        capi.loadingPage(false);
        return snapshot.data()!['status'];
      } else {
        capi.loadingPage(false);
        return null;
      }
    } catch (e) {
      capi.loadingPage(false);
      return null;
    }
  }

  Future<MaintenanceModel?> readMaintenanceFromStatus(int status) async {
    MaintenanceModel? model;
    try {
      capi.loadingPage(true);
      final snapshot =
          await maintenance.where('status', isEqualTo: status).limit(1).get();
      for (var item in snapshot.docs) {
        model = convertMaintenance(item, null);
      }
      capi.loadingPage(false);
      return model;
    } catch (e) {
      capi.loadingPage(false);
      return null;
    }
  }

  Future<List<BannerModel>> readBannerList() async {
    List<BannerModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await banner.get();
      for (var item in snapshot.docs) {
        result.add(convertBanner(item, null));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<List<PrivacyModel>> readPrivacyList() async {
    List<PrivacyModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await privacy.orderBy('number').get();
      for (var item in snapshot.docs) {
        result.add(convertPrivacy(item, null));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }
}
