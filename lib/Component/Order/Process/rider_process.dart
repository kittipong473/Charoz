import 'package:charoz/Service/Database/Firebase/order_crud.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RiderProcess {
  void acceptConfirmYes(BuildContext context, String id) {
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
                  processAcceptOrder(context, id);
                },
                child: Text('ยอมรับ', style: MyStyle().boldGreen18()),
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

  Future processAcceptOrder(BuildContext context, String id) async {
    bool api1 = await OrderCRUD().updateOrderStatus(id, 2, 1);
    bool api2 = await OrderCRUD().updateOrderRiderId(id);
    if (api1 && api2) {
      EasyLoading.dismiss();
      Navigator.pop(context);
      MyVariable.tabController!.animateTo(1);
      MyFunction().toast('ยอมรับออเดอร์ เรียบร้อย');
    } else {
      EasyLoading.dismiss();
      DialogAlert().doubleDialog(
          context, 'มีปัญหาเกิดขึ้นที่ระบบ', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future processReceiveOrder(BuildContext context, String id) async {
    bool api = await OrderCRUD().updateOrderStatus(id, 4, 1);
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

  Future processSendOrder(BuildContext context, String id) async {
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
