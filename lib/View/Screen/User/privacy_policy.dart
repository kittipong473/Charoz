import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View_Model/config_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final ConfigViewModel confVM = Get.find<ConfigViewModel>();

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  void getData() {
    confVM.readPrivacyList();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        appBar: ScreenWidget().appBarTheme('ข้อกำหนดเงื่อนไขการให้บริการ'),
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var item in confVM.privacyList) ...[
                        buildName(item.number, item.name),
                        SizedBox(height: 2.h),
                        buildDetail(item.detail),
                        SizedBox(height: 2.h),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text buildName(int id, String name) {
    return Text('$id. $name', style: MyStyle().boldPrimary16());
  }

  Text buildDetail(String detail) {
    return Text(detail, style: MyStyle().normalBlack14());
  }
}
