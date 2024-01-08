import 'package:charoz/View/Screen/Config/question_answer.dart';
import 'package:charoz/View/Screen/Order/confirm_order.dart';
import 'package:charoz/View/Screen/Order/order_detail.dart';
import 'package:charoz/View/Screen/Config/privacy_policy.dart';
import 'package:charoz/View/Screen/Shop/shop_detail.dart';
import 'package:charoz/View/Screen/Shop/shop_map.dart';
import 'package:charoz/View/Screen/Rider/add_rider.dart';
import 'package:charoz/View/Screen/User/login.dart';
import 'package:charoz/View/Screen/User/register.dart';
import 'package:charoz/View/Screen/Config/maintenance.dart';
import 'package:charoz/View/Screen/Config/page_navigation.dart';
import 'package:charoz/View/Screen/Config/splash_page.dart';
import 'package:charoz/View/Screen/Order/order_cart.dart';
import 'package:charoz/View/Screen/Address/address_list.dart';
import 'package:charoz/View/Screen/User/user_profile.dart';
import 'package:charoz/View/Screen/User/verify_token.dart';
import 'package:get/get.dart';

class RoutePage {
  static String routeSplashPage = '/splashpage';
  static String routeMaintenancePage = '/maintenancepage';
  static String routePageNavigation = '/pagenavigation';
  static String routeRegisterToken = '/registertoken';
  static String routeOrderCart = '/ordercart';
  static String routeLocationList = '/locationlist';
  static String routeConfirmOrder = '/confirmorder';
  static String routeLogin = '/login';
  static String routeRegister = '/register';
  static String routePrivacyPolicy = '/privacypolicy';
  static String routeQuestionAnswer = '/questionanswer';
  static String routeOrderDetail = '/orderdetail';
  static String routeShopMap = '/shopmap';
  static String routeShopDetail = '/shopdetail';
  static String routeAddRider = '/addrider';
  static String routeVerifyToken = '/verifytoken';
  static String routeUserProfile = '/userprofile';

  static List<GetPage> getPages = [
    GetPage(name: routeSplashPage, page: () => const SplashPage()),
    GetPage(name: routeMaintenancePage, page: () => const MaintenancePage()),
    GetPage(name: routePageNavigation, page: () => const PageNavigation()),
    GetPage(name: routeOrderCart, page: () => const OrderCart()),
    GetPage(name: routeLocationList, page: () => const AddressList()),
    GetPage(name: routeConfirmOrder, page: () => const ConfirmOrder()),
    GetPage(name: routeLogin, page: () => const Login()),
    GetPage(name: routeRegister, page: () => const Register()),
    GetPage(name: routePrivacyPolicy, page: () => const PrivacyPolicy()),
    GetPage(name: routeQuestionAnswer, page: () => const QuestionAnswer()),
    GetPage(name: routeOrderDetail, page: () => const OrderDetail()),
    GetPage(name: routeShopMap, page: () => const ShopMap()),
    GetPage(name: routeShopDetail, page: () => const ShopDetail()),
    GetPage(name: routeAddRider, page: () => const AddRider()),
    GetPage(name: routeVerifyToken, page: () => const VerifyToken()),
    GetPage(name: routeUserProfile, page: () => const UserProfile()),
  ];
}
