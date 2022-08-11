import 'package:charoz/Model_Main/test_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestCRUD {
  Future readData() async {
    final reference = FirebaseFirestore.instance.collection('banner');
    final query = reference.orderBy('name');
    final snapshots = await query.get();
    return snapshots.docs.map((e) => TestModel.fromMap(e.data())).toList();
  }

  Stream<List<TestModel>> readRealData() {
    final reference =
        FirebaseFirestore.instance.collection('banner').snapshots();
    return reference.map((snapshot) =>
        snapshot.docs.map((doc) => TestModel.fromMap(doc.data())).toList());
  }

  Future<TestModel?> readOnlyData() async {
    final reference = FirebaseFirestore.instance.collection('banner');
    final query = reference.doc('ITx1p8szEQLH4h0n7PGm');
    final snapshot = await query.get();
    if (snapshot.exists) {
      return TestModel.fromMap(snapshot.data()!);
    } else {
      return null;
    }
  }

  Future<bool> addData(TestModel model) async {
    final reference = FirebaseFirestore.instance.collection('banner').doc();
    reference.set(model.toMap()).then((value) {
      return true;
    }).catchError((err) {
      return false;
    });
    return false;
  }

  Future<bool> editData(String name) async {
    final reference = FirebaseFirestore.instance
        .collection('banner')
        .doc('ITx1p8szEQLH4h0n7PGm');
    reference.update({'name': name}).then((value) {
      return true;
    }).catchError((err) {
      return false;
    });
    return false;
  }

  Future<bool> deleteData() async {
    final reference = FirebaseFirestore.instance
        .collection('banner')
        .doc('dH3pU1Z070cEU8B4BEVu');
    // reference.update({'name': FieldValue.delete()}).then((value) {
    //   return true;
    // }).catchError((err) {
    //   return false;
    // });
    // return false;
    reference.delete().then((value) {
      return true;
    }).catchError((err) {
      return false;
    });
    return false;
  }
}
