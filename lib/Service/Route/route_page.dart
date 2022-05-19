import 'package:charoz/Screen/Home/Component/page_navigation.dart';
import 'package:charoz/Screen/Home/Component/splash_page.dart';
import 'package:charoz/Screen/Notification/Component/noti_create.dart';
import 'package:charoz/Screen/Product/Component/add_product.dart';
import 'package:charoz/Screen/Shop/Component/shop_detail.dart';
import 'package:charoz/Screen/Suggestion/Component/question_answer.dart';
import 'package:charoz/Screen/Suggestion/Component/suggest_complete.dart';
import 'package:charoz/Screen/User/Component/login_token.dart';
import 'package:flutter/material.dart';

class RoutePage {
  static String routeSplashPage = '/splashpage';
  static String routePageNavigation = '/pagenavigation';
  static String routeShopDetail = '/shopdetail';
  static String routeSuggestComplete = '/suggestcomplete';
  static String routeAddProduct = '/addproduct';
  static String routeNotiCreate = '/noticreate';
  static String routeQuestionAnswer = '/questionanswer';
  static String routeLoginToken = '/logintoken';
}

final Map<String, WidgetBuilder> routes = {
  '/splashpage': (BuildContext context) => const SplashPage(),
  '/pagenavigation': (BuildContext context) => const PageNavigation(),
  '/shopdetail': (BuildContext context) => const ShopDetail(),
  '/suggestcomplete': (BuildContext context) => const SuggestComplete(),
  '/addproduct': (BuildContext context) => const AddProduct(),
  '/noticreate': (BuildContext context) => const NotiCreate(),
  '/questionanswer': (BuildContext context) => const QuestionAnswer(),
  '/logintoken': (BuildContext context) => const LoginToken(),
};
