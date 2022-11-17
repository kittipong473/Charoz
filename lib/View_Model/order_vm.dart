import 'package:charoz/Model/Data/order_model.dart';
import 'package:charoz/Model/Data/product_model.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/order_crud.dart';
import 'package:get/get.dart';

class OrderViewModel extends GetxController {
  RxString _commentshop = ''.obs;
  RxString _commentrider = ''.obs;
  RxInt _type = 0.obs;
  RxInt _freight = 0.obs;
  RxInt _totalPay = 0.obs;
  OrderModel? _order;
  RxList<int> _amountList = <int>[].obs;
  RxList<String> _statusList = <String>[].obs;
  RxList<OrderModel> _orderList = <OrderModel>[].obs;
  RxList<ProductModel> _productList = <ProductModel>[].obs;

  get commentshop => _commentshop.value;
  get commentrider => _commentrider.value;
  get type => _type.value;
  get freight => _freight.value;
  get totalPay => _totalPay.value;
  get order => _order;
  get orderList => _orderList;
  get statusList => _statusList;
  get productList => _productList;
  get amountList => _amountList;

  Future readOrderCustomerListByFinish() async {
    _orderList = await OrderCRUD().readOrderCustomerListByFinish();
    _orderList.sort((a, b) => b.time.compareTo(a.time));
    update();
  }

  Future readOrderManagerListByFinish() async {
    _orderList = await OrderCRUD().readOrderManagerListByFinish();
    _orderList.sort((a, b) => b.time.compareTo(a.time));
    update();
  }

  Future readOrderRiderListByFinish() async {
    _orderList = await OrderCRUD().readOrderRiderListByFinish();
    _orderList.sort((a, b) => b.time.compareTo(a.time));
    update();
  }

  Future readOrderAdminListByFinish() async {
    _orderList = await OrderCRUD().readOrderAdminListByFinish();
    _orderList.sort((a, b) => b.time.compareTo(a.time));
    update();
  }

  void calculateTotalPay(int type, int freight) {
    _totalPay.value = 0;
    for (var i = 0; i < _productList.length; i++) {
      _totalPay = totalPay + _productList[i].price * _amountList[i];
    }
    if (type == 1) {
      _totalPay = _totalPay + freight;
    }
    update();
  }

  void addProductToCart(ProductModel product, int amount) {
    _productList.add(product);
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
    _productList.remove(product);
    _amountList.remove(amount);
    update();
  }

  void clearOrderData() {
    _productList.clear();
    _amountList.clear();
    _commentrider.value = '';
    _commentshop.value = '';
    _type.value = 0;
    _totalPay.value = 0;
  }

  void setOrderModel(OrderModel order) {
    _order = order;
    update();
  }
}
