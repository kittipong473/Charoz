import 'package:charoz/Model/order_model.dart';
import 'package:charoz/Service/Database/Firebase/order_crud.dart';
import 'package:flutter/foundation.dart';

class OrderProvider with ChangeNotifier {
  String? _commentshop;
  String? _commentrider;
  String? _type;
  double? _totalPay;
  OrderModel? _order;
  List<OrderModel>? _orderList;
  List<String>? _statusList;
  final List<String> _productidList = [];
  final List<int> _productamountList = [];
  final List<String> _orderStatusList = [];

  get commentshop => _commentshop;
  get commentrider => _commentrider;
  get type => _type;
  get totalPay => _totalPay;
  get order => _order;
  get orderList => _orderList;
  get statusList => _statusList;
  get productidList => _productidList;
  get productamountList => _productamountList;
  get orderStatusList => _orderStatusList;

  Future readOrderCustomerList() async {
    _orderList = await OrderCRUD().readOrderCustomerList();
    _orderList!.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  Future readOrderManagerListByProcess() async {
    _orderList = await OrderCRUD().readOrderManagerListByProcess();
    _orderList!.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  Future readOrderManagerListByFinish() async {
    _orderList = await OrderCRUD().readOrderManagerListByFinish();
    _orderList!.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  Future readOrderRiderListByNotAccept() async {
    _orderList = await OrderCRUD().readOrderRiderListByNotAccept();
    _orderList!.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  Future readOrderRiderListByAccept() async {
    _orderList = await OrderCRUD().readOrderRiderListByAccept();
    _orderList!.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  Future readOrderRiderListByFinish() async {
    _orderList = await await OrderCRUD().readOrderRiderListByFinish();
    _orderList!.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  void addOrderToCart(String id, int amount) {
    _productidList.add(id);
    _productamountList.add(amount);
    notifyListeners();
  }

  void addDetailOrder(String shop, String rider, String type, double total) {
    _commentshop = shop;
    _commentrider = rider;
    _type = type;
    _totalPay = type == 'มารับที่ร้านค้า' ? total : total + 10;
    notifyListeners();
  }

  void removeOrderWhereId(String id, int amount) {
    _productidList.remove(id);
    _productamountList.remove(amount);
    notifyListeners();
  }

  void clearOrderData() {
    _productidList.clear();
    _productamountList.clear();
    _commentrider = null;
    _commentshop = null;
    _type = null;
    _totalPay = null;
    _order = null;
    _orderList = null;
  }

  void selectOrderWhereId(String id) {
    _order = _orderList!.firstWhere((element) => element.id == id);
  }
}
