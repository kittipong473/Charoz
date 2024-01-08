import 'package:charoz/Model/Api/FireStore/noti_model.dart';
import 'package:charoz/Model/Api/Modify/noti_modify.dart';
import 'package:charoz/Service/Restful/api_crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotiCRUD {
  final notificate = FirebaseFirestore.instance.collection('notificate');

  Future<List<NotiModel>> readNotiListAll() async {
    List<NotiModel> result = [];
    try {
      ApiCRUD.loadingPage(true);
      final snapshot = await notificate.get();
      for (var item in snapshot.docs) {
        result.add(NotiModel().convert(item: item));
      }
      ApiCRUD.loadingPage(false);
      return result;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return [];
    }
  }

  Future<List<NotiModel>> readNotiListByRole({required String role}) async {
    List<NotiModel> result = [];
    try {
      ApiCRUD.loadingPage(true);
      final snapshot = await notificate.where(role, isEqualTo: true).get();
      for (var item in snapshot.docs) {
        result.add(NotiModel().convert(item: item));
      }
      ApiCRUD.loadingPage(false);
      return result;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return [];
    }
  }

  Future<bool> createNoti({required NotiModify model}) async {
    try {
      ApiCRUD.loadingPage(true);
      await notificate.doc().set(model.toMap());
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateNoti(
      {required String id, required NotiModify model}) async {
    try {
      ApiCRUD.loadingPage(true);
      await notificate.doc(id).update(model.toMap());
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<bool> deleteNoti({required String id}) async {
    try {
      ApiCRUD.loadingPage(true);
      await notificate.doc(id).delete();
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
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
