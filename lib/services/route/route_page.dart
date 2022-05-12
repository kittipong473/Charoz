import 'package:charoz/screens/home/component/section/about.dart';
import 'package:charoz/screens/maintenance.dart';
import 'package:charoz/screens/noti/component/noti_create.dart';
import 'package:charoz/screens/product/component/add_product.dart';
import 'package:charoz/screens/shop/component/shop_detail.dart';
import 'package:charoz/screens/user/component/phone_login.dart';
import 'package:charoz/screens/home/component/home_service.dart';
import 'package:charoz/screens/home/component/section/success.dart';
import 'package:charoz/screens/splash_page.dart';
import 'package:flutter/material.dart';

class RoutePage {
  static String routeSplashPage = '/splashpage';
  static String routeMaintenance = '/maintenance';
  static String routeHomeService = '/homeservice';
  static String routeShopDetail = '/shopdetail';
  static String routeSuccess = '/success';
  static String routeAddProduct = '/addproduct';
  static String routeNotiCreate = '/noticreate';
  static String routeAbout = '/about';
  static String routePhoneLogin = '/phonelogin';
}

final Map<String, WidgetBuilder> routes = {
  '/splashpage': (BuildContext context) => const SplashPage(),
  '/maintenance': (BuildContext context) => const MaintenancePage(),
  '/homeservice': (BuildContext context) => const HomeService(),
  '/shopdetail': (BuildContext context) => const ShopDetail(),
  '/success': (BuildContext context) => const Success(),
  '/addproduct': (BuildContext context) => const AddProduct(),
  '/noticreate': (BuildContext context) => const NotiCreate(),
  '/about': (BuildContext context) => const About(),
  '/phonelogin': (BuildContext context) => const PhoneLogin(),
};