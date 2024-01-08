import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DialogConfirm {
  final BuildContext context;
  DialogConfirm(this.context);

  void dialogInputConfirm(
      {required String title, String? body, required Function() submit}) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        titlePadding: EdgeInsets.all(20.sp),
        title: SizedBox(
          width: 50.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(MyImage.lotWarning, width: 15.w, height: 15.w),
              SizedBox(height: 2.h),
              Text(
                title,
                style: MyStyle.textStyle(size: 18, color: MyStyle.bluePrimary),
                textAlign: TextAlign.center,
              ),
              if (body != null) ...[
                SizedBox(height: 1.h),
                Text(body,
                    style:
                        MyStyle.textStyle(size: 16, color: MyStyle.greyPrimary),
                    textAlign: TextAlign.center),
              ],
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyWidget().buttonWidget(
                    title: 'ยืนยัน',
                    width: 20.w,
                    color: MyStyle.bluePrimary,
                    onTap: () {
                      Get.back();
                      submit();
                    },
                  ),
                  MyWidget().buttonWidget(
                    title: 'ยกเลิก',
                    width: 20.w,
                    color: MyStyle.greyPrimary,
                    onTap: () => Get.back(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogCRUDConfirm({required int type, required Function() submit}) {
    List<String> statusList = [
      'ยืนยันการ เพิ่มข้อมูล \nหรือไม่ ?',
      'ยืนยันการ แก้ไขข้อมูล \nหรือไม่ ?',
      'ยืนยันการ ลบข้อมูล \nหรือไม่ ?'
    ];
    List<Color> colorList = [
      MyStyle.greenPrimary,
      MyStyle.orangePrimary,
      MyStyle.redPrimary
    ];
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        titlePadding: EdgeInsets.all(20.sp),
        title: SizedBox(
          width: 50.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: type == 0
                    ? MyStyle.greenPrimary
                    : type == 1
                        ? MyStyle.orangePrimary
                        : MyStyle.redPrimary,
                radius: 5.w,
                child: Icon(
                  Icons.question_mark_rounded,
                  color: MyStyle.whitePrimary,
                  size: 20.sp,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                statusList[type],
                style: MyStyle.textStyle(size: 18, color: MyStyle.blackPrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyWidget().buttonWidget(
                    title: 'ยืนยัน',
                    width: 20.w,
                    color: colorList[type],
                    onTap: () {
                      Get.back();
                      submit();
                    },
                  ),
                  MyWidget().buttonWidget(
                    title: 'ยกเลิก',
                    width: 20.w,
                    color: MyStyle.greyPrimary,
                    onTap: () => Get.back(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
