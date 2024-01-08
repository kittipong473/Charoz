import 'package:charoz/Model/Api/FireStore/order_model.dart';
import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/Service/Firebase/order_crud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderViewModel extends GetxController {
  List<String> datatypeOrderStatus = [
    'รอการยืนยันจากร้านค้า',
    'รอการยืนยันจากคนขับ',
    'กำลังจัดทำอาหาร',
    'ทำอาหารเสร็จสิ้น',
    'คนขับกำลังจัดส่ง',
    'ชำระเงินเรียบร้อย',
    'ถูกยกเลิกจากร้านค้า',
    'ไม่มีคนขับสะดวกรับงาน',
    'ให้คะแนนเรียบร้อย'
  ];
  List<String> datatypeOrderTrack = [
    'sending',
    'accepted',
    'finished',
    'canceled',
  ];
  List<String> orderTypeList = ['กำลังดำเนินการ', 'เสร็จสิ้น/ยกเลิก'];
  List<String> orderReceiveList = [
    'มารับที่ร้านค้า',
    'จัดส่งตามที่อยู่',
  ];
  List<Color> orderTrackingColor = [
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.red.shade100,
    Colors.grey.shade300,
  ];

  final RxString _commentshop = ''.obs;
  final RxString _commentrider = ''.obs;
  final RxInt _type = 0.obs;
  final RxInt _freight = 0.obs;
  final RxInt _totalPay = 0.obs;
  final RxList<int> _amountList = <int>[].obs;
  final RxList<String> _statusList = <String>[].obs;
  final RxList<OrderModel> _orderList = <OrderModel>[].obs;
  final RxList<ProductModel> _basketList = <ProductModel>[].obs;
  OrderModel? _order;

  String get commentshop => _commentshop.value;
  String get commentrider => _commentrider.value;
  int get type => _type.value;
  int get freight => _freight.value;
  int get totalPay => _totalPay.value;
  OrderModel? get order => _order;
  List<int> get amountList => _amountList;
  List<String> get statusList => _statusList;
  List<ProductModel> get basketList => _basketList;
  List<OrderModel> get orderList => _orderList;

  void readOrderCustomerListByFinish() async {
    _orderList.value = await OrderCRUD().readOrderCustomerListByFinish();
    _orderList.sort((a, b) => b.time!.compareTo(a.time!));
    update();
  }

  void readOrderManagerListByFinish() async {
    _orderList.value = await OrderCRUD().readOrderManagerListByFinish();
    _orderList.sort((a, b) => b.time!.compareTo(a.time!));
    update();
  }

  void readOrderRiderListByFinish() async {
    _orderList.value = await OrderCRUD().readOrderRiderListByFinish();
    _orderList.sort((a, b) => b.time!.compareTo(a.time!));
    update();
  }

  void readOrderAdminListByFinish() async {
    _orderList.value = await OrderCRUD().readOrderAdminListByFinish();
    _orderList.sort((a, b) => b.time!.compareTo(a.time!));
    update();
  }

  void calculateTotalPay(int type, int freight) {
    _totalPay.value = 0;
    for (var i = 0; i < _basketList.length; i++) {
      _totalPay.value = totalPay + _basketList[i].price! * _amountList[i];
    }
    if (type == 1) {
      _totalPay.value = _totalPay.value + freight;
    }
    update();
  }

  void addProductToCart(ProductModel product, int amount) {
    _basketList.add(product);
    _amountList.add(amount);
    update();
  }

  void addCartToOrder(String shop, String rider, int type) {
    _commentshop.value = shop;
    _commentrider.value = rider;
    _type.value = type;
    update();
  }

  void removeOrderWhereId(ProductModel product, int amount) {
    _basketList.remove(product);
    _amountList.remove(amount);
    update();
  }

  void clearOrderData() {
    _commentrider.value = '';
    _commentshop.value = '';
    _type.value = 0;
    _freight.value = 0;
    _totalPay.value = 0;
    _amountList.clear();
    _statusList.clear();
    _basketList.clear();
    _order = null;
  }

  void setOrderModel(OrderModel order) {
    _order = order;
    update();
  }
}
