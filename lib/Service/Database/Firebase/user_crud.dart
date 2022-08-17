import 'package:charoz/Model_Sub/user_modify.dart';
import 'package:charoz/Model_Main/user_model.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future readUserByToken() async {
    try {
      final snapshot = await user
          .where('tokenE', isEqualTo: MyVariable.accountUid)
          .limit(1)
          .get();
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

  Future<bool> createUser(UserModify model) async {
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
}
