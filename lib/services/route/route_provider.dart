import 'package:charoz/screens/home/provider/suggest_provider.dart';
import 'package:charoz/screens/noti/provider/noti_provider.dart';
import 'package:charoz/screens/user/provider/user_provider.dart';
import 'package:charoz/screens/home/provider/home_provider.dart';
import 'package:charoz/screens/product/provider/product_provider.dart';
import 'package:charoz/screens/shop/provider/shop_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> routeMultiProvider() {
  return [
    ChangeNotifierProvider(create: (context) => HomeProvider()),
    ChangeNotifierProvider(create: (context) => ShopProvider()),
    ChangeNotifierProvider(create: (context) => ProductProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => NotiProvider()),
    ChangeNotifierProvider(create: (context) => SuggestProvider()),
  ];
}