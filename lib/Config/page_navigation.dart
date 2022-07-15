import 'package:charoz/Component/Notification/noti_list.dart';
import 'package:charoz/Component/Order/List/order_list_manager.dart';
import 'package:charoz/Component/Order/List/order_list_rider.dart';
import 'package:charoz/Component/Rider/rider_order_detail.dart';
import 'package:charoz/Config/home.dart';
import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Component/Order/order_cart.dart';
import 'package:charoz/Component/Product/product_list.dart';
import 'package:charoz/Component/Shop/shop_list.dart';
import 'package:charoz/Component/User/login.dart';
import 'package:charoz/Component/User/user_detail.dart';
import 'package:charoz/Component/User/user_list.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({Key? key}) : super(key: key);

  @override
  _PageNavigationState createState() => _PageNavigationState();
}

class _PageNavigationState extends State<PageNavigation> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  List<Widget>? screens;
  List<Widget>? icons;

  @override
  void initState() {
    super.initState();
    getBottomNavigationBar();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Consumer<ConfigProvider>(
        builder: (context, hprovider, child) => Scaffold(
          extendBody: true,
          body: screens![GlobalVariable.indexPageNavigation],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            child: CurvedNavigationBar(
              key: navigationKey,
              color: MyStyle.primary,
              buttonBackgroundColor: MyStyle.bluePrimary,
              backgroundColor: MyStyle.colorBackGround,
              height: 6.h,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),
              index: GlobalVariable.indexPageNavigation,
              onTap: (index) =>
                  setState(() => GlobalVariable.indexPageNavigation = index),
              items: icons!,
            ),
          ),
        ),
      ),
    );
  }

  void getBottomNavigationBar() {
    if (GlobalVariable.role == 'admin') {
      screens = [
        NotiList(notiList: GlobalVariable.notisAdmin),
        const UserList(),
        const OrderListManager(),
        const ShopList(),
        const UserProfile(),
      ];
      icons = [
        getIcon(Icons.notifications_active_rounded),
        getIcon(Icons.account_circle_rounded),
        getIcon(Icons.receipt_rounded),
        getIcon(Icons.store_mall_directory_rounded),
        getIcon(Icons.menu_rounded),
      ];
    } else if (GlobalVariable.role == 'manager') {
      screens = [
        NotiList(notiList: GlobalVariable.notisManager),
        const ProductList(),
        const OrderListManager(),
        const ShopList(),
        const UserProfile(),
      ];
      icons = [
        getIcon(Icons.notifications_active_rounded),
        getIcon(Icons.restaurant_rounded),
        getIcon(Icons.receipt_rounded),
        getIcon(Icons.store_mall_directory_rounded),
        getIcon(Icons.menu_rounded),
      ];
    } else if (GlobalVariable.role == 'rider') {
      screens = [
        NotiList(notiList: GlobalVariable.notisRider),
        const RiderOrderDetail(),
        const OrderListRider(),
        const ShopList(),
        const UserProfile(),
      ];
      icons = [
        getIcon(Icons.notifications_active_rounded),
        getIcon(Icons.delivery_dining_rounded),
        getIcon(Icons.receipt_rounded),
        getIcon(Icons.store_mall_directory_rounded),
        getIcon(Icons.menu_rounded),
      ];
    } else if (GlobalVariable.role == 'customer') {
      screens = [
        const Home(),
        const ProductList(),
        const OrderCart(),
        NotiList(notiList: GlobalVariable.notisCustomer),
        const UserProfile(),
      ];
      icons = [
        getIcon(Icons.home_rounded),
        getIcon(Icons.restaurant_rounded),
        getIcon(Icons.shopping_cart_rounded),
        getIcon(Icons.notifications_active_rounded),
        getIcon(Icons.menu_rounded),
      ];
    } else {
      screens = [
        const Home(),
        const ProductList(),
        const ShopList(),
        NotiList(notiList: GlobalVariable.notisUser),
        const Login(),
      ];
      icons = [
        getIcon(Icons.home_rounded),
        getIcon(Icons.restaurant_rounded),
        getIcon(Icons.store_mall_directory_rounded),
        getIcon(Icons.notifications_active_rounded),
        getIcon(Icons.menu_rounded),
      ];
    }
  }

  Icon getIcon(IconData icon) => Icon(icon, size: 20.sp);
}
