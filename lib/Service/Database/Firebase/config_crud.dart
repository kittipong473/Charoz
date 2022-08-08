import 'package:charoz/Model/banner_model.dart';
import 'package:charoz/Model/maintenance_model.dart';
import 'package:charoz/Model/privacy_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfigCRUD {
  final maintenance = FirebaseFirestore.instance.collection('maintenance');
  final appstatus = FirebaseFirestore.instance.collection('appstatus');
  final banner = FirebaseFirestore.instance.collection('banner');
  final privacy = FirebaseFirestore.instance.collection('privacy');

  Future readStatusFromAS() async {
    try {
      final snapshot = await appstatus.doc('bnRgar2MdG3dcS37OYLN').get();
      if (snapshot.exists) {
        return snapshot.data()!['status'];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future readMaintenanceFromStatus(int status) async {
    try {
      final snapshot =
          await maintenance.where('status', isEqualTo: status).limit(1).get();
      for (var item in snapshot.docs) {
        return convertMaintenance(item);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future readBannerList() async {
    List<BannerModel> result = [];
    try {
      final snapshot = await banner.get();
      for (var item in snapshot.docs) {
        result.add(convertBanner(item));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future readPrivacyList() async {
    List<PrivacyModel> result = [];
    try {
      final snapshot = await privacy.orderBy('number').get();
      for (var item in snapshot.docs) {
        result.add(convertPrivacy(item));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
