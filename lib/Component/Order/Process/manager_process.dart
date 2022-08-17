import 'package:charoz/Service/Database/Firebase/order_crud.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ManagerProcess {
  void acceptConfirmYes(BuildContext context, String id, int type) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.receipt_rounded,
              size: 25.sp,
              color: MyStyle.primary,
            ),
            SizedBox(
              width: 45.w,
              child: Text(
                'ยืนยันการยอมรับออเดอร์นี้หรือไม่ ?',
                style: MyStyle().boldPrimary18(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  EasyLoading.show(status: 'loading...');
                  type == 0
                      ? processAcceptOrder(context, id, 2, 1)
                      : processAcceptOrder(context, id, 1, 0);
                },
                child: Text('ยอมรับ', style: MyStyle().boldGreen18()),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text('ยกเลิก', style: MyStyle().boldGrey18()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void acceptConfirmNo(BuildContext context, String id, int type) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.receipt_rounded,
              size: 25.sp,
              color: MyStyle.primary,
            ),
            SizedBox(
              width: 45.w,
              child: Text(
                'ยืนยันการปฏิเสธออเดอร์นี้หรือไม่ ?',
                style: MyStyle().boldPrimary18(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  EasyLoading.show(status: 'loading...');
                  processAcceptOrder(context, id, 6, 2);
                },
                child: Text('ปฏิเสธ', style: MyStyle().boldRed18()),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ยกเลิก', style: MyStyle().boldGrey18()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future processAcceptOrder(
      BuildContext context, String id, int status, int track) async {
    bool api = await OrderCRUD().updateOrderStatus(id, status, track);
    if (api) {
      EasyLoading.dismiss();
      Navigator.pop(context);
      track == 2
          ? MyFunction().toast('ยกเลิกออเดอร์ เรียบร้อย')
          : MyFunction().toast('ยอมรับออเดอร์ เรียบร้อย');
    } else {
      EasyLoading.dismiss();
      DialogAlert().doubleDialog(
          context, 'มีปัญหาเกิดขึ้นที่ระบบ', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future processFinishOrder(BuildContext context, String id) async {
    bool api = await OrderCRUD().updateOrderStatus(id, 3, 1);
    if (api) {
      EasyLoading.dismiss();
      Navigator.pop(context);
      MyFunction().toast('อัพเดทสถานะ เรียบร้อย');
    } else {
      EasyLoading.dismiss();
      DialogAlert().doubleDialog(
          context, 'มีปัญหาเกิดขึ้นที่ระบบ', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future processCompleteOrder(BuildContext context, String id) async {
    bool api = await OrderCRUD().updateOrderStatus(id, 5, 3);
    if (api) {
      EasyLoading.dismiss();
      Navigator.pop(context);
      MyFunction().toast('อัพเดทสถานะ เรียบร้อย');
    } else {
      EasyLoading.dismiss();
      DialogAlert().doubleDialog(
          context, 'มีปัญหาเกิดขึ้นที่ระบบ', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
