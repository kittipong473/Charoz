import 'package:charoz/Model_Main/order_model.dart';
import 'package:charoz/Model_Main/product_model.dart';
import 'package:charoz/Service/Database/Firebase/order_crud.dart';
import 'package:charoz/Service/Database/Firebase/shop_crud.dart';
import 'package:flutter/foundation.dart';

class OrderProvider with ChangeNotifier {
  String? _commentshop;
  String? _commentrider;
  int? _type;
  int? _freight;
  int? _totalPay;
  OrderModel? _order;
  List<OrderModel>? _orderList;
  List<String>? _statusList;
  final List<ProductModel> _productList = [];
  final List<int> _amountList = [];

  get commentshop => _commentshop;
  get commentrider => _commentrider;
  get type => _type;
  get freight => _freight;
  get totalPay => _totalPay;
  get order => _order;
  get orderList => _orderList;
  get statusList => _statusList;
  get productList => _productList;
  get amountList => _amountList;

  Future readOrderCustomerListByFinish() async {
    _orderList = await OrderCRUD().readOrderCustomerListByFinish();
    _orderList!.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  Future readOrderManagerListByFinish() async {
    _orderList = await OrderCRUD().readOrderManagerListByFinish();
    _orderList!.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  Future readOrderRiderListByFinish() async {
    _orderList = await OrderCRUD().readOrderRiderListByFinish();
    _orderList!.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  Future readOrderAdminListByFinish() async {
    _orderList = await OrderCRUD().readOrderAdminListByFinish();
    _orderList!.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  void calculateTotalPay(int type, int freight) {
    _totalPay = 0;
    for (var i = 0; i < _productList.length; i++) {
      _totalPay = totalPay + _productList[i].price * _amountList[i];
    }
    if (type == 1) {
      _totalPay = _totalPay! + freight;
    }
    notifyListeners();
  }

  void addProductToCart(ProductModel product, int amount) {
    _productList.add(product);
    _amountList.add(amount);
    notifyListeners();
  }

  void addCartToOrder(String shop, String rider, int type) {
    _commentshop = shop;
    _commentrider = rider;
    _type = type;
    notifyListeners();
  }

  void removeOrderWhereId(ProductModel product, int amount) {
    _productList.remove(product);
    _amountList.remove(amount);
    notifyListeners();
  }

  void clearOrderData() {
    _productList.clear();
    _amountList.clear();
    _commentrider = null;
    _commentshop = null;
    _type = null;
    _totalPay = null;
  }

  void setOrderModel(OrderModel order) {
    _order = order;
    notifyListeners();
  }
}
