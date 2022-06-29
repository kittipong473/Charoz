import 'package:charoz/Component/Notification/manage_noti.dart';
import 'package:charoz/Component/Notification/noti_admin.dart';
import 'package:charoz/Component/Order/rider_order_detail.dart';
import 'package:charoz/Config/home.dart';
import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Component/Notification/noti_customer.dart';
import 'package:charoz/Component/Notification/noti_rider.dart';
import 'package:charoz/Component/Notification/noti_manager.dart';
import 'package:charoz/Component/Order/manager_order_list.dart';
import 'package:charoz/Component/Order/order_cart.dart';
import 'package:charoz/Component/Order/rider_order_list.dart';
import 'package:charoz/Component/Product/product_list.dart';
import 'package:charoz/Component/Shop/shop_list.dart';
import 'package:charoz/Component/User/login_phone.dart';
import 'package:charoz/Component/User/user_detail.dart';
import 'package:charoz/Component/User/user_list.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
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
    getBottomNavigationBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Consumer<ConfigProvider>(
        builder: (context, hprovider, child) => Scaffold(
          extendBody: true,
          body: screens![MyVariable.indexPageNavigation],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            child: CurvedNavigationBar(
              key: navigationKey,
              color: MyStyle.primary,
              buttonBackgroundColor: MyStyle.bluePrimary,
              backgroundColor: MyStyle.colorBackGround,
              height: MyVariable.largeDevice ? 75 : 50,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),
              index: MyVariable.indexPageNavigation,
              onTap: (index) =>
                  setState(() => MyVariable.indexPageNavigation = index),
              items: icons!,
            ),
          ),
        ),
      ),
    );
  }

  void getBottomNavigationBar() {
    if (MyVariable.role == 'admin') {
      screens = [
        const NotiAdmin(),
        const UserList(),
        const ManagerOrderList(),
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
    } else if (MyVariable.role == 'manager') {
      screens = [
        const NotiManager(),
        const ProductList(),
        const ManagerOrderList(),
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
    } else if (MyVariable.role == 'rider') {
      screens = [
        const NotiRider(),
        const RiderOrderDetail(),
        const RiderOrderList(),
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
    } else if (MyVariable.role == 'customer') {
      screens = [
        const Home(),
        const ProductList(),
        const OrderCart(),
        const NotiCustomer(),
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
        const NotiCustomer(),
        const LoginPhone(),
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
