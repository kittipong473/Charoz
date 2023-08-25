import 'package:charoz/Utility/Constant/my_image.dart';
import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DialogConfirm {
  final BuildContext context;
  DialogConfirm(this.context);

  void dialogInputConfirm(String title, String? body, Function submit) {
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
              Lottie.asset(MyImage.gifWarning, width: 15.w, height: 15.w),
              SizedBox(height: 2.h),
              Text(title, style: MyStyle().normalPrimary16()),
              if (body != null) ...[
                SizedBox(height: 1.h),
                Text(body,
                    style: MyStyle().normalGrey16(),
                    textAlign: TextAlign.center),
              ],
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 20.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyStyle.greenLight),
                      onPressed: () {
                        Get.back();
                        submit();
                      },
                      child: Text('ยืนยัน', style: MyStyle().normalGreen16()),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyStyle.greyLight),
                      onPressed: () => Get.back(),
                      child: Text('ยกเลิก', style: MyStyle().normalGrey16()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogCRUDConfirm(int type, Function submit) {
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
                type == 0
                    ? 'ยืนยันการ เพิ่มข้อมูล \nหรือไม่ ?'
                    : type == 1
                        ? 'ยืนยันการ แก้ไขข้อมูล \nหรือไม่ ?'
                        : 'ยืนยันการ ลบข้อมูล \nหรือไม่ ?',
                style: MyStyle().normalBlack18(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 20.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: type == 0
                              ? MyStyle.greenLight
                              : type == 1
                                  ? MyStyle.yellowLight
                                  : MyStyle.redLight),
                      onPressed: () {
                        Get.back();
                        submit();
                      },
                      child: Text(
                        'ยืนยัน',
                        style: type == 0
                            ? MyStyle().normalGreen16()
                            : type == 1
                                ? MyStyle().normalPrimary16()
                                : MyStyle().normalRed16(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyStyle.greyLight),
                      onPressed: () => Get.back(),
                      child: Text('ยกเลิก', style: MyStyle().normalGrey16()),
                    ),
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
