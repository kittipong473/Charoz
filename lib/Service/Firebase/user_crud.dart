import 'package:charoz/Model/Api/FireStore/user_model.dart';
import 'package:charoz/Model/Api/Modify/user_modify.dart';
import 'package:charoz/Service/Restful/api_crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserCRUD {
  final user = FirebaseFirestore.instance.collection('user');

  Future<List<UserModel>> readUserList() async {
    List<UserModel> result = [];
    try {
      ApiCRUD.loadingPage(true);
      final snapshot = await user.orderBy('role').get();
      for (var item in snapshot.docs) {
        result.add(UserModel().convert(item: item));
      }
      ApiCRUD.loadingPage(false);
      return result;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return [];
    }
  }

  Future<UserModel?> readUserByPhone({required String phone}) async {
    UserModel? model;
    try {
      ApiCRUD.loadingPage(true);
      final snapshot =
          await user.where('phone', isEqualTo: phone).limit(1).get();
      for (var item in snapshot.docs) {
        model = UserModel().convert(item: item);
      }
      ApiCRUD.loadingPage(false);
      return model;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return null;
    }
  }

  Future<UserModel?> readUserById({required String id}) async {
    try {
      final snapshot = await user.doc(id).get();
      if (snapshot.exists) {
        return UserModel().convert(item: snapshot.data(), id: snapshot.id);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> readTokenById({required String id}) async {
    try {
      ApiCRUD.loadingPage(true);
      final snapshot = await user.doc(id).get();
      if (snapshot.exists) {
        ApiCRUD.loadingPage(false);
        return snapshot.data()!['token'];
      } else {
        ApiCRUD.loadingPage(false);
        return null;
      }
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return null;
    }
  }

  Future<List<String>> readTokenRiderList() async {
    List<String> result = [];
    try {
      ApiCRUD.loadingPage(true);
      final snapshot = await user.where('role', isEqualTo: 'rider').get();
      for (var item in snapshot.docs) {
        result.add(item['token']);
      }
      ApiCRUD.loadingPage(false);
      return result;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return [];
    }
  }

  Future<bool?> checkDuplicatePhone({required String phone}) async {
    try {
      ApiCRUD.loadingPage(true);
      final snapshot =
          await user.where('phone', isEqualTo: phone).limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        ApiCRUD.loadingPage(false);
        return true;
      } else {
        ApiCRUD.loadingPage(false);
        return false;
      }
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return null;
    }
  }

  Future<bool?> checkDuplicateEmail({required String email}) async {
    try {
      ApiCRUD.loadingPage(true);
      final snapshot =
          await user.where('email', isEqualTo: email).limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        ApiCRUD.loadingPage(false);
        return true;
      } else {
        ApiCRUD.loadingPage(false);
        return false;
      }
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return null;
    }
  }

  Future<bool> createUser({required UserModify model}) async {
    try {
      ApiCRUD.loadingPage(true);
      await user.doc().set(model.toMap());
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateUserCode(
      {required String id, required String code}) async {
    try {
      ApiCRUD.loadingPage(true);
      await user.doc(id).update({'pincode': code});
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateUserStatus(
      {required String id, required bool status}) async {
    try {
      ApiCRUD.loadingPage(true);
      await user.doc(id).update({'status': status});
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateUserTokenDevice({required String id}) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    ApiCRUD.loadingPage(true);
    String? token = await firebaseMessaging.getToken();
    if (token != null) {
      try {
        await user.doc(id).update({'token': token});
        ApiCRUD.loadingPage(false);
        return true;
      } catch (e) {
        ApiCRUD.loadingPage(false);
        return false;
      }
    } else {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }
}
