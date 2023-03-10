import 'dart:io';
import 'dart:math';

import 'package:charoz/Model/Data/noti_model.dart';
import 'package:charoz/Model/Api/Request/noti_request.dart';
import 'package:charoz/Model/Util/Variable/var_data.dart';
import 'package:charoz/Service/Restful/api_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotiCRUD {
  final ApiController capi = Get.find<ApiController>();
  final notificate = FirebaseFirestore.instance.collection('notificate');

  Future<List<NotiModel>> readNotiListAll() async {
    List<NotiModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await notificate.get();
      for (var item in snapshot.docs) {
        result.add(convertNoti(item, null));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<List<NotiModel>> readNotiListByRole(int role) async {
    List<NotiModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await notificate
          .where(VariableData.notiReceiveUser[role], isEqualTo: true)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertNoti(item, null));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<bool> createNoti(NotiRequest model) async {
    try {
      capi.loadingPage(true);
      await notificate.doc().set(model.toMap());
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateNoti(String id, NotiRequest model) async {
    try {
      capi.loadingPage(true);
      await notificate.doc(id).update(model.toMap());
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> deleteNoti(String id) async {
    try {
      capi.loadingPage(true);
      await notificate.doc(id).delete();
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  // Future<String> uploadImageNoti(File file) async {
  //   int name = Random().nextInt(100000);
  //   try {
  //     final reference =
  //         FirebaseStorage.instance.ref().child('noti/noti$name.png');
  //     final task = reference.putFile(file);
  //     return await task.storage.ref().getDownloadURL();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
