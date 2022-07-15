import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Provider/noti_provider.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> routeMultiProvider() {
  return [
    ChangeNotifierProvider(create: (context) => ConfigProvider()),
    ChangeNotifierProvider(create: (context) => ShopProvider()),
    ChangeNotifierProvider(create: (context) => ProductProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => NotiProvider()),
    ChangeNotifierProvider(create: (context) => AddressProvider()),
    ChangeNotifierProvider(create: (context) => OrderProvider()),
  ];
}
