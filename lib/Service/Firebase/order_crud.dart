import 'package:charoz/Model/Api/FireStore/order_model.dart';
import 'package:charoz/Model/Api/Modify/order_modify.dart';
import 'package:charoz/Model/Utility/my_variable.dart';
import 'package:charoz/Service/Restful/api_crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCRUD {
  final orderlist = FirebaseFirestore.instance.collection('orderlist');

  Stream<List<OrderModel>> readOrderCustomerListByProcess() {
    try {
      final reference = orderlist
          .where('track', isLessThanOrEqualTo: 1)
          .where('customerid', isEqualTo: MyVariable.userTokenID)
          .snapshots();
      return reference.map((snapshot) => snapshot.docs
          .map((doc) => OrderModel().convert(item: doc.data(), id: doc.id))
          .toList());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<OrderModel>> readOrderManagerListByProcess() {
    try {
      final reference = orderlist
          .where('track', isLessThanOrEqualTo: 1)
          .where('shopid', isEqualTo: 'EbeQ5r39Cy6460XEWlYf')
          .snapshots();
      return reference.map((snapshot) => snapshot.docs
          .map((doc) => OrderModel().convert(item: doc.data(), id: doc.id))
          .toList());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<OrderModel>> readOrderRiderListByNotAccept() {
    try {
      final reference = orderlist
          .where('type', isEqualTo: 1)
          .where('riderid', isEqualTo: '')
          .where('status', isEqualTo: 1)
          .snapshots();
      return reference.map((snapshot) => snapshot.docs
          .map((doc) => OrderModel().convert(item: doc.data(), id: doc.id))
          .toList());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<OrderModel>> readOrderRiderListByAccept() {
    try {
      final reference = orderlist
          .where('track', isEqualTo: 1)
          .where('riderid', isEqualTo: MyVariable.userTokenID)
          .snapshots();
      return reference.map((snapshot) => snapshot.docs
          .map((doc) => OrderModel().convert(item: doc.data(), id: doc.id))
          .toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> readOrderCustomerListByFinish() async {
    List<OrderModel> result = [];
    try {
      ApiCRUD.loadingPage(true);
      final snapshot = await orderlist
          .where('track', isGreaterThanOrEqualTo: 2)
          .where('customerid', isEqualTo: MyVariable.userTokenID)
          .get();
      for (var item in snapshot.docs) {
        result.add(OrderModel().convert(item: item));
      }
      ApiCRUD.loadingPage(false);
      return result;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return [];
    }
  }

  Future<List<OrderModel>> readOrderManagerListByFinish() async {
    List<OrderModel> result = [];
    try {
      ApiCRUD.loadingPage(true);
      final snapshot = await orderlist
          .where('track', isGreaterThanOrEqualTo: 2)
          .where('shopid', isEqualTo: 'EbeQ5r39Cy6460XEWlYf')
          .get();
      for (var item in snapshot.docs) {
        result.add(OrderModel().convert(item: item));
      }
      ApiCRUD.loadingPage(false);
      return result;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return [];
    }
  }

  Future<List<OrderModel>> readOrderRiderListByFinish() async {
    List<OrderModel> result = [];
    try {
      ApiCRUD.loadingPage(true);
      final snapshot = await orderlist
          .where('track', isGreaterThanOrEqualTo: 2)
          .where('riderid', isEqualTo: MyVariable.userTokenID)
          .get();
      for (var item in snapshot.docs) {
        result.add(OrderModel().convert(item: item));
      }
      ApiCRUD.loadingPage(false);
      return result;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return [];
    }
  }

  Future<List<OrderModel>> readOrderAdminListByFinish() async {
    List<OrderModel> result = [];
    try {
      ApiCRUD.loadingPage(true);
      final snapshot =
          await orderlist.where('track', isGreaterThanOrEqualTo: 2).get();
      for (var item in snapshot.docs) {
        result.add(OrderModel().convert(item: item));
      }
      ApiCRUD.loadingPage(false);
      return result;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return [];
    }
  }

  Future<bool?> checkRiderIdById({required String id}) async {
    try {
      ApiCRUD.loadingPage(true);
      final snapshot = await orderlist.doc(id).get();
      if (snapshot.exists && snapshot.data()!['riderid'] == "") {
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

  Future<bool> createOrder({required OrderModify model}) async {
    try {
      ApiCRUD.loadingPage(true);
      await orderlist.doc().set(model.toMap());
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateOrderStatus(
      {required String id, required int status, required int track}) async {
    try {
      ApiCRUD.loadingPage(true);
      await orderlist.doc(id).update({'status': status, 'track': track});
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateOrderRiderId({required String id}) async {
    try {
      ApiCRUD.loadingPage(true);
      await orderlist.doc(id).update({'riderid': MyVariable.userTokenID});
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }
}
