import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/noti_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ModalNoti {
  Future<void> dialogNoti(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        color: MyStyle.backgroundColor,
        width: 100.w,
        height: 85.h,
        child: GetBuilder<NotiViewModel>(
          builder: (vm) => vm.noti == null
              ? MyWidget().showProgress()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyWidget().buildModalHeader(title: 'รายละเอียดอาหาร'),
                    Text(
                      vm.noti!.name ?? '',
                      style: MyStyle.textStyle(
                          size: 18, color: MyStyle.orangePrimary),
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
                    // Text(
                    //   'เริ่มต้น : ${MyFunction().convertToDate(noti.start)}',
                    //   style: MyStyle().boldBlue16(),
                    // ),
                    // SizedBox(height: 1.h),
                    // Text(
                    //   'สิ้นสุด : ${MyFunction().convertToDate(noti.end)}',
                    //   style: MyStyle().boldBlue16(),
                    // ),
                    SizedBox(height: 1.h),
                  ],
                ),
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
    );
  }
}
