import 'dart:io';

import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Database/Firebase/config_crud.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkMaintenance();
  }

  Future checkMaintenance() async {
    // int maintenance = 0;
    int? maintenance = await ConfigCRUD().readStatusFromAS();
    if (maintenance == 0 || maintenance == 1) {
      appMaintenance(maintenance!);
    } else if (maintenance == 2) {
      checkLogin();
    } else {
      DialogAlert().doubleDialog(
          context, 'เซิฟเวอร์มีปัญหา', 'กรุณาเข้าใช้งานในภายหลัง');
      exit(0);
    }
  }

  void appMaintenance(int maintenance) {
    Provider.of<ConfigProvider>(context, listen: false)
        .readMaintenanceFromStatus(maintenance);
    Future.delayed(Duration.zero, () {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutePage.routeMaintenancePage, (route) => false);
    });
  }

  void checkLogin() {
    if (MyVariable.accountUid != "") {
      Provider.of<UserProvider>(context, listen: false)
          .getUserPreference(context);
    } else {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routeCodeVerify, (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(MyImage.logo3, width: 50.w, height: 50.w),
              SizedBox(height: 3.h),
              Lottie.asset(MyImage.gifSplash, width: 40.w, height: 40.w),
            ],
          ),
        ),
      ),
    );
  }
}
