import 'package:charoz/Model/Data/order_model.dart';
import 'package:charoz/Model/Api/Request/order_request.dart';
import 'package:charoz/Model/Util/Variable/var_general.dart';
import 'package:charoz/Service/Restful/api_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderCRUD {
  final ApiController capi = Get.find<ApiController>();
  final orderlist = FirebaseFirestore.instance.collection('orderlist');

  Stream<List<OrderModel>> readOrderCustomerListByProcess() {
    try {
      final reference = orderlist
          .where('track', isLessThanOrEqualTo: 1)
          .where('customerid', isEqualTo: VariableGeneral.userTokenId)
          .snapshots();
      return reference.map((snapshot) => snapshot.docs
          .map((doc) => convertOrder(doc.data(), doc.id))
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
          .map((doc) => convertOrder(doc.data(), doc.id))
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
          .map((doc) => convertOrder(doc.data(), doc.id))
          .toList());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<OrderModel>> readOrderRiderListByAccept() {
    try {
      final reference = orderlist
          .where('track', isEqualTo: 1)
          .where('riderid', isEqualTo: VariableGeneral.userTokenId)
          .snapshots();
      return reference.map((snapshot) => snapshot.docs
          .map((doc) => convertOrder(doc.data(), doc.id))
          .toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> readOrderCustomerListByFinish() async {
    List<OrderModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await orderlist
          .where('track', isGreaterThanOrEqualTo: 2)
          .where('customerid', isEqualTo: VariableGeneral.userTokenId)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertOrder(item, null));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<List<OrderModel>> readOrderManagerListByFinish() async {
    List<OrderModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await orderlist
          .where('track', isGreaterThanOrEqualTo: 2)
          .where('shopid', isEqualTo: 'EbeQ5r39Cy6460XEWlYf')
          .get();
      for (var item in snapshot.docs) {
        result.add(convertOrder(item, null));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<List<OrderModel>> readOrderRiderListByFinish() async {
    List<OrderModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await orderlist
          .where('track', isGreaterThanOrEqualTo: 2)
          .where('riderid', isEqualTo: VariableGeneral.userTokenId)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertOrder(item, null));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<List<OrderModel>> readOrderAdminListByFinish() async {
    List<OrderModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot =
          await orderlist.where('track', isGreaterThanOrEqualTo: 2).get();
      for (var item in snapshot.docs) {
        result.add(convertOrder(item, null));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<bool?> checkRiderIdById(String id) async {
    try {
      capi.loadingPage(true);
      final snapshot = await orderlist.doc(id).get();
      if (snapshot.exists && snapshot.data()!['riderid'] == "") {
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

  Future<bool> createOrder(OrderRequest model) async {
    try {
      capi.loadingPage(true);
      await orderlist.doc().set(model.toMap());
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateOrderStatus(String id, int status, int track) async {
    try {
      capi.loadingPage(true);
      await orderlist.doc(id).update({'status': status, 'track': track});
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateOrderRiderId(String id) async {
    try {
      capi.loadingPage(true);
      await orderlist.doc(id).update({'riderid': VariableGeneral.userTokenId});
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }
}
