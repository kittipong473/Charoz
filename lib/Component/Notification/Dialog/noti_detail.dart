import 'package:animations/animations.dart';
import 'package:charoz/Model/noti_model.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotiDetail {
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  void dialogNoti(BuildContext context, NotiModel noti) {
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                noti.notiName,
                style: MyStyle().boldPrimary20(),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 50.w,
                height: 50.w,
                child: Image.asset(MyImage.welcome),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 60.w,
                child: Text(
                  noti.notiDetail,
                  style: MyStyle().normalBlack16(),
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'เริ่มต้น : ${MyFunction().convertToDate(noti.notiStart)}',
                style: MyStyle().boldBlue16(),
              ),
              SizedBox(height: 1.h),
              Text(
                'สิ้นสุด : ${MyFunction().convertToDate(noti.notiEnd)}',
                style: MyStyle().boldBlue16(),
              ),
              SizedBox(height: 1.h),
            ],
          ),
          // children: [
          //   if (MyVariable.role == 'admin') ...[
          //     TextButton(
          //       onPressed: () async {
          //         bool result =
          //             await NotiApi().deleteNotiWhereId(id: noti.notiId);
          //         if (result) {
          //           ShowToast().toast('ลบรายการแจ้งเตือนสำเร็จ');
          //           Provider.of<NotiProvider>(context, listen: false)
          //               .getAllNoti();
          //         } else {
          //           ShowToast()
          //               .toast('ลบรายการแจ้งเตือนล้มเหลว ลองใหม่อีกครั้ง');
          //         }
          //         Navigator.pop(context);
          //       },
          //       child: Text(
          //         'ลบรายการ',
          //         style: MyStyle().boldPrimary18(),
          //       ),
          //     ),
          //   ] else ...[
          //     TextButton(
          //       onPressed: () => Navigator.pop(context),
          //       child: Text(
          //         'ตกลง',
          //         style: MyStyle().boldBlue18(),
          //       ),
          //     ),
          //   ],
          // ],
        ),
      ),
    );
  }
}