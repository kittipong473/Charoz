import 'package:charoz/Model/Data/user_model.dart';
import 'package:charoz/Model/Api/Request/user_modify.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserCRUD {
  final user = FirebaseFirestore.instance.collection('user');

  Future readUserList() async {
    List<UserModel> result = [];
    try {
      final snapshot = await user.orderBy('time', descending: true).get();
      for (var item in snapshot.docs) {
        result.add(convertUser(item, null));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future readUserByToken(String uid) async {
    try {
      final snapshot =
          await user.where('tokenE', isEqualTo: uid).limit(1).get();
      for (var item in snapshot.docs) {
        return convertUser(item, null);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future readUserByPhone(String phone) async {
    try {
      final snapshot =
          await user.where('phone', isEqualTo: phone).limit(1).get();
      for (var item in snapshot.docs) {
        return convertUser(item, null);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future readUserById(String id) async {
    try {
      final snapshot = await user.doc(id).get();
      if (snapshot.exists) {
        return convertUser(snapshot.data(), snapshot.id);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> readTokenById(String id) async {
    try {
      final snapshot = await user.doc(id).get();
      if (snapshot.exists) {
        return snapshot.data()!['tokenDevice'];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> readTokenRiderList() async {
    List<String> result = [];
    try {
      final snapshot = await user.where('role', isEqualTo: 'rider').get();
      for (var item in snapshot.docs) {
        result.add(item['tokenDevice']);
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkUserByPhone(String phone) async {
    try {
      final snapshot =
          await user.where('phone', isEqualTo: phone).limit(1).get();
      if (snapshot.docs.isEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkUserByEmail(String email) async {
    try {
      final snapshot =
          await user.where('email', isEqualTo: email).limit(1).get();
      if (snapshot.docs.isEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createUser(UserManage model) async {
    try {
      await user.doc().set(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserCode(String id, String code) async {
    try {
      await user.doc(id).update({'pincode': code});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserStatus(String id, int status) async {
    try {
      await user.doc(id).update({'status': status});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserTokenDevice(String id) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    if (token != null) {
      try {
        await user.doc(id).update({'tokenDevice': token});
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }
}
