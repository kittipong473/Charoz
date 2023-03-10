import 'dart:io';

import 'package:charoz/Service/Firebase/config_crud.dart';
import 'package:charoz/Service/Initial/route_page.dart';
import 'package:charoz/Model/Util/Variable/var_general.dart';
import 'package:charoz/Service/Library/preference.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/Model/Util/Constant/my_image.dart';
import 'package:charoz/Model/Util/Constant/my_style.dart';
import 'package:charoz/View_Model/config_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:charoz/View_Model/time_vm.dart';
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
  final ShopViewModel shopVM = Get.find<ShopViewModel>();
  final TimeViewModel timeVM = Get.find<TimeViewModel>();
  final ProductViewModel prodVM = Get.find<ProductViewModel>();

  @override
  void initState() {
    super.initState();
    checkMaintenance();
  }

  void checkMaintenance() async {
    // int maintenance = 0;
    int? maintenance = await ConfigCRUD().readStatusFromAS();
    if (maintenance == 1 || maintenance == 2) {
      appMaintenance(maintenance!);
    } else if (maintenance == 0) {
      checkLogin();
    } else {
      DialogAlert(context).dialogStatus(
          2, 'แอพพลิเคชั่นเกิดความผิดพลาด', 'กรุณาเข้าใช้งานในภายหลัง');
      exit(0);
    }
  }

  void appMaintenance(int maintenance) async {
    await confVM.readMaintenanceFromStatus(maintenance);
    Get.offNamed(RoutePage.routeMaintenancePage);
  }

  Future checkLogin() async {
    await Preferences().init();
    String? id = Preferences().getString('id');
    if (id != null) {
      bool status = await userVM.getUserPreference(context, id);
      if (status) {
        VariableGeneral.isLogin = true;
        initData();
      } else {
        VariableGeneral.isLogin = false;
        Preferences().clearValue('id');
        initData();
        MyDialog(context).doubleDialog('คุณถูกระงับการใช้งาน',
            'โปรดติดต่อสอบถามผู้ดูแลระบบเมื่อมีข้อสงสัย');
      }
    } else {
      VariableGeneral.isLogin = false;
      initData();
    }
  }

  void initData() async {
    await shopVM.readShopModel();
    await timeVM.readTimeModel();
    await prodVM.readProductAllList();
    Get.offNamed(RoutePage.routePageNavigation);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
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
