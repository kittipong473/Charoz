import 'package:charoz/Model/order_model.dart';
import 'package:charoz/Service/Api/PHP/order_api.dart';
import 'package:flutter/foundation.dart';

class OrderProvider with ChangeNotifier {
  String? _detailShop;
  String? _detailRider;
  String? _receiveType;
  double? _orderTotal;
  OrderModel? _order;
  List<OrderModel>? _orderList;
  final List<int> _orderProductIds = [];
  final List<int> _orderProductAmounts = [];

  get detailShop => _detailShop;
  get detailRider => _detailRider;
  get receiveType => _receiveType;
  get orderTotal => _orderTotal;
  get order => _order;
  get orderList => _orderList;
  get orderProductIds => _orderProductIds;
  get orderProductAmounts => _orderProductAmounts;

  Future getAllOrderWhereCustomer() async {
    _orderList = await OrderApi().getAllOrderWhereCustomer();
    notifyListeners();
  }

  Future getAllOrderWhereManager() async {
    _orderList = await OrderApi().getAllOrderWhereManager();
    notifyListeners();
  }

  Future getAllOrderWhereManagerDone() async {
    _orderList = await OrderApi().getAllOrderWhereManagerDone();
    notifyListeners();
  }

  Future getAllOrderWhereNoRider() async {
    _orderList = await OrderApi().getAllOrderWhereNoRider();
    notifyListeners();
  }

  Future getAllOrderWhereYesRider() async {
    _orderList = await OrderApi().getAllOrderWhereYesRider();
    notifyListeners();
  }

  Future getAllOrderWhereRiderDone() async {
    _orderList = await OrderApi().getAllOrderWhereRiderDone();
    notifyListeners();
  }

  void addOrderToCart(int id, int amount) {
    _orderProductIds.add(id);
    _orderProductAmounts.add(amount);
    notifyListeners();
  }

  void addDetailOrder(String shop, String rider, String type, double total) {
    _detailShop = shop;
    _detailRider = rider;
    _receiveType = type;
    _orderTotal = type == 'มารับที่ร้านค้า' ? total : total + 10;
    notifyListeners();
  }

  void removeOrderWhereId(int id, int amount) {
    _orderProductIds.remove(id);
    _orderProductAmounts.remove(amount);
    notifyListeners();
  }

  void clearOrder() {
    _orderProductIds.clear();
    _orderProductAmounts.clear();
    _detailRider = null;
    _detailShop = null;
    _receiveType = null;
    _orderTotal = null;
    notifyListeners();
  }

  void selectOrderWhereId(int id) {
    _order = _orderList!.firstWhere((element) => element.orderId == id);
  }
}
