import 'package:charoz/View/Function/my_function.dart';
import 'package:flutter/material.dart';
import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/noti_vm.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotiDetail {
  final BuildContext context;
  NotiDetail(this.context);

  void dialogNoti() {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        backgroundColor: MyStyle.backgroundColor,
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: GetBuilder<NotiViewModel>(
          builder: (vm) => vm.noti == null
              ? MyWidget().showProgress()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      vm.noti!.name ?? '',
                      style: MyStyle.textStyle(
                          size: 18, color: MyStyle.orangePrimary, bold: true),
                    ),
                    Text(
                      MyFunction().convertToDate(time: vm.noti!.time!),
                      style: MyStyle.textStyle(
                          size: 14, color: MyStyle.bluePrimary),
                    ),
                    SizedBox(height: 3.h),
                    SizedBox(
                      width: 50.w,
                      height: 50.w,
                      child: MyWidget().showImage(path: MyImage.imgWelcome),
                    ),
                    SizedBox(height: 3.h),
                    SizedBox(
                      width: 60.w,
                      child: Text(
                        vm.noti!.detail ?? '',
                        style: MyStyle.textStyle(
                            size: 16, color: MyStyle.blackPrimary),
                      ),
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
        ),
      ),
    );
  }
}
