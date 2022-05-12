import 'package:charoz/screens/home/provider/home_provider.dart';
import 'package:charoz/screens/shop/provider/shop_provider.dart';
import 'package:charoz/screens/user/provider/user_provider.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/show_progress.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeService extends StatefulWidget {
  const HomeService({Key? key}) : super(key: key);

  @override
  _HomeServiceState createState() => _HomeServiceState();
}

class _HomeServiceState extends State<HomeService> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  String? role;

  @override
  void initState() {
    super.initState();
    getRole();
    Provider.of<ShopProvider>(context, listen: false).getCurrentTimeStatus();
  }

  void getRole() {
    Provider.of<HomeProvider>(context, listen: false).getBottomNavigationBar();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Consumer2<HomeProvider, ShopProvider>(
        builder: (context, hprovider, sprovider, child) {
          if (hprovider.screens.isEmpty || sprovider.currentStatus.isEmpty) {
            return const ShowProgress();
          } else {
            return Scaffold(
              extendBody: true,
              body: hprovider.screens[MyVariable.indexPage],
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
                child: CurvedNavigationBar(
                  key: navigationKey,
                  color: MyStyle.primary,
                  buttonBackgroundColor: MyStyle.blue,
                  backgroundColor: MyStyle.colorBackGround,
                  height: MyVariable.largeDevice ? 75 : 50,
                  animationCurve: Curves.easeInOut,
                  animationDuration: const Duration(milliseconds: 300),
                  index: MyVariable.indexPage,
                  onTap: (index) {
                    setState(() {
                      MyVariable.indexPage = index;
                    });
                  },
                  items: hprovider.icons,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
