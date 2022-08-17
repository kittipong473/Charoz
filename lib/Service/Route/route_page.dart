import 'package:charoz/Component/Order/confirm_order.dart';
import 'package:charoz/Component/Order/order_detail.dart';
import 'package:charoz/Component/Rider/rider_working.dart';
import 'package:charoz/Component/Security/code_manage.dart';
import 'package:charoz/Component/Security/code_setting.dart';
import 'package:charoz/Component/Security/privacy_policy.dart';
import 'package:charoz/Component/Shop/shop_detail.dart';
import 'package:charoz/Component/Shop/shop_map.dart';
import 'package:charoz/Component/Rider/add_rider.dart';
import 'package:charoz/Component/User/login.dart';
import 'package:charoz/Component/User/register.dart';
import 'package:charoz/Component/User/register_token.dart';
import 'package:charoz/Component/Security/code_verify.dart';
import 'package:charoz/Config/maintenance.dart';
import 'package:charoz/Config/page_navigation.dart';
import 'package:charoz/Config/splash_page.dart';
import 'package:charoz/Component/Order/order_cart.dart';
import 'package:charoz/Component/Address/location_list.dart';
import 'package:charoz/test.dart';
import 'package:flutter/material.dart';

class RoutePage {
  static String routeCodeVerify = '/codeverify';
  static String routeCodeSetting = '/codesetting';
  static String routeCodeManage = '/codemanage';
  static String routeSplashPage = '/splashpage';
  static String routeMaintenancePage = '/maintenancepage';
  static String routePageNavigation = '/pagenavigation';
  static String routeVerifyToken = '/verifytoken';
  static String routeOrderCart = '/ordercart';
  static String routeLocationList = '/locationlist';
  static String routeConfirmOrder = '/confirmorder';
  static String routeLogin = '/login';
  static String routeRegister = '/register';
  static String routePrivacyPolicy = '/privacypolicy';
  static String routeOrderDetail = '/orderdetail';
  static String routeShopMap = '/shopmap';
  static String routeShopDetail = '/shopdetail';
  static String routeAddRider = '/addrider';
  static String routeTest = '/test';
}

final Map<String, WidgetBuilder> routes = {
  '/codeverify': (BuildContext context) => const CodeVerify(),
  '/codesetting': (BuildContext context) => const CodeSetting(),
  '/codemanage': (BuildContext context) => const CodeManage(),
  '/splashpage': (BuildContext context) => const SplashPage(),
  '/maintenancepage': (BuildContext context) => const MaintenancePage(),
  '/pagenavigation': (BuildContext context) => const PageNavigation(),
  '/verifytoken': (BuildContext context) => const VerifyToken(),
  '/ordercart': (BuildContext context) => const OrderCart(),
  '/locationlist': (BuildContext context) => const LocationList(),
  '/confirmorder': (BuildContext context) => const ConfirmOrder(),
  '/login': (BuildContext context) => const Login(),
  '/register': (BuildContext context) => const Register(),
  '/privacypolicy': (BuildContext context) => const PrivacyPolicy(),
  '/orderdetail': (BuildContext context) => const OrderDetail(),
  '/shopmap': (BuildContext context) => const ShopMap(),
  '/shopdetail': (BuildContext context) => const ShopDetail(),
  '/addrider': (BuildContext context) => const AddRider(),
  '/test': (BuildContext context) => const TestPage(),
};
