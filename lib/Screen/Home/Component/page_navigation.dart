import 'package:charoz/Screen/Home/Provider/home_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({Key? key}) : super(key: key);

  @override
  _PageNavigationState createState() => _PageNavigationState();
}

class _PageNavigationState extends State<PageNavigation> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  String? role;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    Provider.of<HomeProvider>(context, listen: false).getBottomNavigationBar();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Consumer<HomeProvider>(
        builder: (context, hprovider, child) => Scaffold(
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
        ),
      ),
    );
  }
}
