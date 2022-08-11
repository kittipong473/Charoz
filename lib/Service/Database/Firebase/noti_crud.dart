import 'dart:io';
import 'dart:math';

import 'package:charoz/Model_Sub/noti_add.dart';
import 'package:charoz/Model_Main/noti_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NotiCRUD {
  final notificate = FirebaseFirestore.instance.collection('notificate');

  Future readNotiTypeList(String type) async {
    List<NotiModel> result = [];
    try {
      final snapshot = await notificate
          .where('type', isEqualTo: type)
          .orderBy('start', descending: true)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertNoti(item));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createNoti(NotiModify model) async {
    try {
      await notificate.doc().set(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateNoti(String id, NotiModify model) async {
    try {
      await notificate.doc(id).update(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> uploadImageNoti(File file) async {
    int name = Random().nextInt(100000);
    try {
      final reference =
          FirebaseStorage.instance.ref().child('noti/noti$name.png');
      final task = reference.putFile(file);
      return await task.storage.ref().getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }
}
