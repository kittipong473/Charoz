import 'package:charoz/Screen/Home/Provider/home_provider.dart';
import 'package:charoz/Screen/Notification/Provider/noti_provider.dart';
import 'package:charoz/Screen/Product/Provider/product_provider.dart';
import 'package:charoz/Screen/Shop/Provider/shop_provider.dart';
import 'package:charoz/Screen/Suggestion/Provider/suggest_provider.dart';
import 'package:charoz/Screen/User/Provider/user_provider.dart';
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
