import 'package:charoz/Component/Notification/manage_noti.dart';
import 'package:charoz/Config/page_navigation.dart';
import 'package:charoz/Config/splash_page.dart';
import 'package:charoz/Component/Order/order_cart.dart';
import 'package:charoz/Component/Product/add_product.dart';
import 'package:charoz/Component/Shop/shop_detail.dart';
import 'package:charoz/Component/Address/add_location.dart';
import 'package:charoz/Component/User/login_token.dart';
import 'package:charoz/Component/Address/location_list.dart';
import 'package:flutter/material.dart';

class RoutePage {
  static String routeSplashPage = '/splashpage';
  static String routePageNavigation = '/pagenavigation';
  static String routeShopDetail = '/shopdetail';
  static String routeAddProduct = '/addproduct';
  static String routeManageNoti = '/managenoti';
  static String routeLoginToken = '/logintoken';
  static String routeOrderCart = '/ordercart';
  static String routeLocationList = '/locationlist';
  static String routeAddLocation = '/addlocation';
}

final Map<String, WidgetBuilder> routes = {
  '/splashpage': (BuildContext context) => const SplashPage(),
  '/pagenavigation': (BuildContext context) => const PageNavigation(),
  '/shopdetail': (BuildContext context) => const ShopDetail(),
  '/addproduct': (BuildContext context) => const AddProduct(),
  '/managenoti': (BuildContext context) => const ManageNoti(),
  '/logintoken': (BuildContext context) => const LoginToken(),
  '/ordercart': (BuildContext context) => const OrderCart(),
  '/locationlist': (BuildContext context) => const LocationList(),
  '/addlocation': (BuildContext context) => const AddLocation(),
};
