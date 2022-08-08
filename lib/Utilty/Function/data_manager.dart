import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Provider/noti_provider.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DataManager {
  void clearAllData(BuildContext context) {
    Provider.of<AddressProvider>(context, listen: false).clearAddressData();
    Provider.of<ConfigProvider>(context, listen: false).clearConfigData();
    Provider.of<NotiProvider>(context, listen: false).clearNotiData();
    Provider.of<OrderProvider>(context, listen: false).clearOrderData();
    Provider.of<ProductProvider>(context, listen: false).clearProductData();
    Provider.of<ShopProvider>(context, listen: false).clearShopData();
    Provider.of<UserProvider>(context, listen: false).clearUserData();
  }
}