import 'dart:io';

import 'package:charoz/Model/Service/CRUD/Firebase/config_crud.dart';
import 'package:charoz/Model/Service/Route/route_page.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/Util/Constant/my_image.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View_Model/config_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final ConfigViewModel confVM = Get.find<ConfigViewModel>();
  final UserViewModel userVM = Get.find<UserViewModel>();

  @override
  void initState() {
    super.initState();
    checkMaintenance();
  }

  Future checkMaintenance() async {
    // int maintenance = 1;
    int? maintenance = await ConfigCRUD().readStatusFromAS();
    if (maintenance == 0 || maintenance == 1) {
      appMaintenance(maintenance!);
    } else if (maintenance == 2) {
      checkLogin();
    } else {
      MyDialog(context).doubleDialog(
          'แอพพลิเคชั่นเกิดความผิดพลาด', 'กรุณาเข้าใช้งานในภายหลัง');
      exit(0);
    }
  }

  void appMaintenance(int maintenance) async {
    await confVM.readMaintenanceFromStatus(maintenance);
    Get.offNamed(RoutePage.routeMaintenancePage);
  }

  Future checkLogin() async {
    VariableGeneral.auth.authStateChanges().listen((event) {
      if (event != null) {
        userVM.getUserPreference(context, event.uid);
      } else {
        VariableGeneral.isLogin = false;
        Get.offNamed(RoutePage.routePageNavigation);
      }
    });
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
              Text(
                'Charoz Application\nยินดีต้อนรับ',
                style: MyStyle().boldPrimary20(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              Image.asset(MyImage.logo3, width: 50.w, height: 50.w),
              SizedBox(height: 5.h),
              Lottie.asset(MyImage.gifSplash, width: 40.w, height: 40.w),
            ],
          ),
        ),
      ),
    );
  }
}
