import 'package:charoz/Component/Order/confirm_order.dart';
import 'package:charoz/Component/Security/privacy_policy.dart';
import 'package:charoz/Component/Security/term_of_service.dart';
import 'package:charoz/Component/User/register.dart';
import 'package:charoz/Component/User/register_token.dart';
import 'package:charoz/Component/Security/code_verify.dart';
import 'package:charoz/Config/maintenance.dart';
import 'package:charoz/Config/page_navigation.dart';
import 'package:charoz/Config/splash_page.dart';
import 'package:charoz/Component/Order/order_cart.dart';
import 'package:charoz/Component/Address/location_list.dart';
import 'package:flutter/material.dart';

class RoutePage {
  static String routeCodeVerify = '/codeverify';
  static String routeSplashPage = '/splashpage';
  static String routeMaintenancePage = '/maintenancepage';
  static String routePageNavigation = '/pagenavigation';
  static String routeRegisterToken = '/registertoken';
  static String routeOrderCart = '/ordercart';
  static String routeLocationList = '/locationlist';
  static String routeConfirmOrder = '/confirmorder';
  static String routeRegister = '/register';
  static String routePrivacyPolicy = '/privacypolicy';
  static String routeTermOfService = '/termofservice';
}

final Map<String, WidgetBuilder> routes = {
  '/codeverify': (BuildContext context) => const CodeVerify(),
  '/splashpage': (BuildContext context) => const SplashPage(),
  '/maintenancepage': (BuildContext context) => const MaintenancePage(),
  '/pagenavigation': (BuildContext context) => const PageNavigation(),
  '/registertoken': (BuildContext context) => const RegisterToken(),
  '/ordercart': (BuildContext context) => const OrderCart(),
  '/locationlist': (BuildContext context) => const LocationList(),
  '/confirmorder': (BuildContext context) => const ConfirmOrder(),
  '/register': (BuildContext context) => const Register(),
  '/privacypolicy': (BuildContext context) => const PrivacyPolicy(),
  '/termofservice': (BuildContext context) => const TermOfService(),
};
