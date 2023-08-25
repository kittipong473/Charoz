import 'package:charoz/Utility/Constant/my_image.dart';
import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:charoz/Utility/Variable/var_general.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DialogAlert {
  final BuildContext context;
  DialogAlert(this.context);

  void dialogStatus(int type, String title, String? body) {
    List<String> statusDialogImage = [
      MyImage.gifSuccess,
      MyImage.gifWarning,
      MyImage.gifDanger,
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
              Lottie.asset(statusDialogImage[type], width: 15.w, height: 15.w),
              SizedBox(height: 2.h),
              Text(
                title,
                style: MyStyle().normalPrimary16(),
                textAlign: TextAlign.center,
              ),
              if (body != null) ...[
                SizedBox(height: 1.h),
                Text(
                  body,
                  style: MyStyle().normalBlack16(),
                  textAlign: TextAlign.center,
                ),
              ],
              SizedBox(height: 3.h),
              SizedBox(
                width: VariableGeneral.largeDevice ? 20.w : 24.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyStyle.bluePrimary),
                  onPressed: () => Get.back(),
                  child: Text('เข้าใจแล้ว', style: MyStyle().normalWhite16()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogUpgrade(Function function) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        titlePadding: EdgeInsets.all(20.sp),
        title: SizedBox(
          width: 50.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(MyImage.gifUpgrade, width: 15.w, height: 15.w),
              SizedBox(height: 2.h),
              Text(
                'เวอร์ชั่นใหม่พร้อมใช้งาน!',
                style: MyStyle().normalPrimary16(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.h),
              Text(
                'อัพเกรดเวอร์ชั่นของคุณจาก ${VariableGeneral.appVersion ?? 0.0} ไปยัง ${VariableGeneral.baseVersion ?? 0.0} \nคุณสามารถอัพเกรดเวอร์ชั่นได้ภายหลังที่ การแจ้งเตือนอื่นๆ',
                style: MyStyle().normalBlack16(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: VariableGeneral.largeDevice ? 20.w : 24.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyStyle.bluePrimary),
                  onPressed: () {
                    Get.back();
                    function();
                  },
                  child: Text('เข้าใจแล้ว', style: MyStyle().normalWhite16()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
