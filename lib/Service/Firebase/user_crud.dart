import 'package:charoz/Model/Data/user_model.dart';
import 'package:charoz/Model/Api/Request/user_request.dart';
import 'package:charoz/Service/Restful/api_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class UserCRUD {
  final ApiController capi = Get.find<ApiController>();
  final user = FirebaseFirestore.instance.collection('user');

  Future<List<UserModel>> readUserList() async {
    List<UserModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await user.orderBy('time', descending: true).get();
      for (var item in snapshot.docs) {
        result.add(convertUser(item, null));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<UserModel?> readUserByPhone(String phone) async {
    UserModel? model;
    try {
      capi.loadingPage(true);
      final snapshot =
          await user.where('phone', isEqualTo: phone).limit(1).get();
      for (var item in snapshot.docs) {
        model = convertUser(item, null);
      }
      capi.loadingPage(false);
      return model;
    } catch (e) {
      capi.loadingPage(false);
      return null;
    }
  }

  Future<UserModel?> readUserById(String id) async {
    try {
      capi.loadingPage(true);
      final snapshot = await user.doc(id).get();
      if (snapshot.exists) {
        capi.loadingPage(false);
        return convertUser(snapshot.data(), snapshot.id);
      } else {
        capi.loadingPage(false);
        return null;
      }
    } catch (e) {
      capi.loadingPage(false);
      return null;
    }
  }

  Future<String?> readTokenById(String id) async {
    try {
      capi.loadingPage(true);
      final snapshot = await user.doc(id).get();
      if (snapshot.exists) {
        capi.loadingPage(false);
        return snapshot.data()!['token'];
      } else {
        capi.loadingPage(false);
        return null;
      }
    } catch (e) {
      capi.loadingPage(false);
      return null;
    }
  }

  Future<List<String>> readTokenRiderList() async {
    List<String> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await user.where('role', isEqualTo: 'rider').get();
      for (var item in snapshot.docs) {
        result.add(item['token']);
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  // Future<bool?> checkDuplicatePhone(String phone) async {
  //   try {
  //     final snapshot =
  //         await user.where('phone', isEqualTo: phone).limit(1).get();
  //     if (snapshot.docs.isNotEmpty) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Future<bool?> checkDuplicateEmail(String email) async {
    try {
      capi.loadingPage(true);
      final snapshot =
          await user.where('email', isEqualTo: email).limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        capi.loadingPage(false);
        return true;
      } else {
        capi.loadingPage(false);
        return false;
      }
    } catch (e) {
      capi.loadingPage(false);
      return null;
    }
  }

  Future<bool> createUser(UserRequest model) async {
    try {
      capi.loadingPage(true);
      await user.doc().set(model.toMap());
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateUserCode(String id, String code) async {
    try {
      capi.loadingPage(true);
      await user.doc(id).update({'pincode': code});
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateUserStatus(String id, bool status) async {
    try {
      capi.loadingPage(true);
      await user.doc(id).update({'status': status});
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateUserTokenDevice(String id) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    capi.loadingPage(true);
    String? token = await firebaseMessaging.getToken();
    if (token != null) {
      try {
        await user.doc(id).update({'token': token});
        capi.loadingPage(false);
        return true;
      } catch (e) {
        capi.loadingPage(false);
        return false;
      }
    } else {
      capi.loadingPage(false);
      return false;
    }
  }
}
