import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View_Model/config_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DialogAlert {
  final BuildContext context;
  DialogAlert(this.context);

  void dialogStatus({required int type, required String title, String? body}) {
    List<String> statusList = [
      MyImage.lotSuccess,
      MyImage.lotWarning,
      MyImage.lotDanger,
    ];
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        titlePadding: EdgeInsets.symmetric(vertical: 3.h),
        title: SizedBox(
          width: 50.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(statusList[type], width: 15.w, height: 15.w),
              SizedBox(height: 2.h),
              Text(
                title,
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary),
                textAlign: TextAlign.center,
              ),
              if (body != null) ...[
                SizedBox(height: 1.h),
                Text(
                  body,
                  style:
                      MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
                  textAlign: TextAlign.center,
                ),
              ],
              SizedBox(height: 3.h),
              SizedBox(
                width: 24.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyStyle.bluePrimary),
                  onPressed: () => Get.back(),
                  child: Text(
                    'ยืนยัน',
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.whitePrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogApi() {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        titlePadding: EdgeInsets.symmetric(vertical: 3.h),
        title: SizedBox(
          width: 50.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(MyImage.lotDanger, width: 15.w, height: 15.w),
              SizedBox(height: 2.h),
              Text(
                'เกิดข้อผิดพลาดทางฝั่งเซิฟเวอร์',
                style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                'กรุณาลองใหม่อีกครั้งในภายหลัง',
                style: MyStyle.textStyle(size: 16, color: MyStyle.greyPrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 24.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyStyle.bluePrimary),
                  onPressed: () => Get.back(),
                  child: Text(
                    'ยืนยัน',
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.whitePrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogUpgrade({required Function() function}) {
    final configVM = Get.find<ConfigViewModel>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        titlePadding: EdgeInsets.symmetric(vertical: 3.h),
        title: SizedBox(
          width: 50.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(MyImage.lotUpgrade, width: 15.w, height: 15.w),
              SizedBox(height: 2.h),
              Text(
                'เวอร์ชั่นใหม่พร้อมใช้งาน!',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.h),
              Text(
                'อัพเกรดเวอร์ชั่นของคุณจาก ${configVM.baseVersion} ไปยัง ${configVM.targetVersion} \nคุณสามารถอัพเกรดเวอร์ชั่นได้ภายหลังที่ การแจ้งเตือนอื่นๆ',
                style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 24.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyStyle.bluePrimary),
                  onPressed: () {
                    Get.back();
                    function;
                  },
                  child: Text(
                    'ยืนยัน',
                    style: MyStyle.textStyle(
                        size: 16, color: MyStyle.whitePrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
