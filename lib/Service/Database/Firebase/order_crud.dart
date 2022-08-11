import 'package:charoz/Model_Sub/order_sub.dart';
import 'package:charoz/Model_Main/order_model.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCRUD {
  final orderlist = FirebaseFirestore.instance.collection('orderlist');

  Stream<List<OrderModel>> readOrderCustomerListByProcess() {
    final reference = orderlist
        .where('track', isLessThanOrEqualTo: 1)
        .where('customerid', isEqualTo: MyVariable.userTokenId)
        .snapshots();
    return reference.map((snapshot) =>
        snapshot.docs.map((doc) => convertOrder(doc.data(), doc.id)).toList());
  }

  Stream<List<OrderModel>> readOrderManagerListByProcess() {
    final reference = orderlist
        .where('track', isLessThanOrEqualTo: 1)
        .where('shopid', isEqualTo: 'EbeQ5r39Cy6460XEWlYf')
        .snapshots();
    return reference.map((snapshot) =>
        snapshot.docs.map((doc) => convertOrder(doc.data(), doc.id)).toList());
  }

  Stream<List<OrderModel>> readOrderRiderListByNotAccept() {
    final reference = orderlist
        .where('type', isEqualTo: 1)
        .where('riderid', isEqualTo: '')
        .where('status', isEqualTo: 1)
        .snapshots();
    return reference.map((snapshot) =>
        snapshot.docs.map((doc) => convertOrder(doc.data(), doc.id)).toList());
  }

  Stream<List<OrderModel>> readOrderRiderListByAccept() {
    final reference = orderlist
        .where('track', isEqualTo: 1)
        .where('riderid', isEqualTo: MyVariable.userTokenId)
        .snapshots();
    return reference.map((snapshot) =>
        snapshot.docs.map((doc) => convertOrder(doc.data(), doc.id)).toList());
  }

  Future readOrderCustomerListByFinish() async {
    List<OrderModel> result = [];
    try {
      final snapshot = await orderlist
          .where('track', isGreaterThanOrEqualTo: 2)
          .where('customerid', isEqualTo: MyVariable.userTokenId)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertOrder(item, null));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future readOrderManagerListByFinish() async {
    List<OrderModel> result = [];
    try {
      final snapshot = await orderlist
          .where('track', isGreaterThanOrEqualTo: 2)
          .where('shopid', isEqualTo: 'EbeQ5r39Cy6460XEWlYf')
          .get();
      for (var item in snapshot.docs) {
        result.add(convertOrder(item, null));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future readOrderRiderListByFinish() async {
    List<OrderModel> result = [];
    try {
      final snapshot = await orderlist
          .where('track', isGreaterThanOrEqualTo: 2)
          .where('riderid', isEqualTo: MyVariable.userTokenId)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertOrder(item, null));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createOrder(OrderModify model) async {
    try {
      await orderlist.doc().set(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateOrderStatus(String id, int status, int track) async {
    try {
      await orderlist.doc(id).update({'status': status, 'track': track});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateOrderRiderId(String id) async {
    try {
      await orderlist.doc(id).update({'riderid': MyVariable.userTokenId});
      return true;
    } catch (e) {
      return false;
    }
  }
}
