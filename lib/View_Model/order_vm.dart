import 'package:charoz/Model/Api/FireStore/order_model.dart';
import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/Service/Firebase/order_crud.dart';
import 'package:get/get.dart';

class OrderViewModel extends GetxController {
  final RxString _commentshop = ''.obs;
  final RxString _commentrider = ''.obs;
  final RxInt _type = 0.obs;
  final RxInt _freight = 0.obs;
  final RxInt _totalPay = 0.obs;
  final RxList<int> _amountList = <int>[].obs;
  final RxList<String> _statusList = <String>[].obs;
  final RxList<OrderModel> _orderList = <OrderModel>[].obs;
  final RxList<ProductModel> _productList = <ProductModel>[].obs;
  OrderModel? _order;

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
    _orderList.value = await OrderCRUD().readOrderCustomerListByFinish();
    _orderList.sort((a, b) => b.time!.compareTo(a.time!));
    update();
  }

  Future readOrderManagerListByFinish() async {
    _orderList.value = await OrderCRUD().readOrderManagerListByFinish();
    _orderList.sort((a, b) => b.time!.compareTo(a.time!));
    update();
  }

  Future readOrderRiderListByFinish() async {
    _orderList.value = await OrderCRUD().readOrderRiderListByFinish();
    _orderList.sort((a, b) => b.time!.compareTo(a.time!));
    update();
  }

  Future readOrderAdminListByFinish() async {
    _orderList.value = await OrderCRUD().readOrderAdminListByFinish();
    _orderList.sort((a, b) => b.time!.compareTo(a.time!));
    update();
  }

  void calculateTotalPay(int type, int freight) {
    _totalPay.value = 0;
    for (var i = 0; i < _productList.length; i++) {
      _totalPay.value = totalPay + _productList[i].price! * _amountList[i];
    }
    if (type == 1) {
      _totalPay.value = _totalPay.value + freight;
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
    _commentrider.value = '';
    _commentshop.value = '';
    _type.value = 0;
    _freight.value = 0;
    _totalPay.value = 0;
    _amountList.clear();
    _statusList.clear();
    _productList.clear();
    _order = null;
  }

  void setOrderModel(OrderModel order) {
    _order = order;
    update();
  }
}
