import 'package:charoz/Model/SubModel/sub_order_model.dart';
import 'package:charoz/Model/order_model.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCRUD {
  final orderlist = FirebaseFirestore.instance.collection('orderlist');

  Future readOrderCustomerList() async {
    List<OrderModel> result = [];
    try {
      final snapshot = await orderlist
          .where('customerid', isEqualTo: MyVariable.userTokenId)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertOrder(item));
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
        result.add(convertOrder(item));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future readOrderManagerListByProcess() async {
    List<OrderModel> result = [];
    try {
      final snapshot = await orderlist
          .where('track', isLessThanOrEqualTo: 1)
          .where('shopid', isEqualTo: 'EbeQ5r39Cy6460XEWlYf')
          .get();
      for (var item in snapshot.docs) {
        result.add(convertOrder(item));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future readOrderRiderListByNotAccept() async {
    List<OrderModel> result = [];
    try {
      final snapshot = await orderlist
          .where('type', isEqualTo: 1)
          .where('track', isEqualTo: 0)
          .where('riderid', isEqualTo: '')
          .get();
      for (var item in snapshot.docs) {
        result.add(convertOrder(item));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future readOrderRiderListByAccept() async {
    List<OrderModel> result = [];
    try {
      final snapshot = await orderlist
          .where('track', isEqualTo: 1)
          .where('riderid', isEqualTo: MyVariable.userTokenId)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertOrder(item));
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
          .where('shopid', isEqualTo: MyVariable.userTokenId)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertOrder(item));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<OrderModel>> readStatusOrderListStream() {
    final reference =
        orderlist.snapshots();
    return reference.map((snapshot) =>
        snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList());
  }

  Future<bool> createOrder(SubOrderModel model) async {
    try {
      await orderlist.doc().set(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateStatusOrder(String id, int status, int track) async {
    try {
      await orderlist.doc(id).update({'status': status, 'track': track});
      return true;
    } catch (e) {
      return false;
    }
  }
}
