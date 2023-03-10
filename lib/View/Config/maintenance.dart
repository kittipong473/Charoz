import 'package:charoz/Model/Util/Constant/my_image.dart';
import 'package:charoz/Model/Util/Constant/my_style.dart';
import 'package:charoz/View_Model/config_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final ConfigViewModel confVM = Get.find<ConfigViewModel>();

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Charoz Application', style: MyStyle().boldPrimary20()),
                SizedBox(height: 5.h),
                Lottie.asset(MyImage.gifMaintenance, width: 250, height: 250),
                SizedBox(height: 5.h),
                Text(
                  confVM.maintenance.name,
                  style: MyStyle().boldPrimary20(),
                ),
                SizedBox(height: 3.h),
                Text(
                  confVM.maintenance.detail,
                  style: MyStyle().normalPrimary18(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
