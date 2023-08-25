import 'package:charoz/Model/Api/FireStore/noti_model.dart';
import 'package:charoz/Model/Api/Modify/noti_modify.dart';
import 'package:charoz/Utility/Variable/var_data.dart';
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
        result.add(NotiModel().convert(item: item));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<List<NotiModel>> readNotiListByRole({required int role}) async {
    List<NotiModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await notificate
          .where(VariableData.datatypeNotiRole[role], isEqualTo: true)
          .get();
      for (var item in snapshot.docs) {
        result.add(NotiModel().convert(item: item));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<bool> createNoti({required NotiModify model}) async {
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

  Future<bool> updateNoti(
      {required String id, required NotiModify model}) async {
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

  Future<bool> deleteNoti({required String id}) async {
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
