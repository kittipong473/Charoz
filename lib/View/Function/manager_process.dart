import 'package:charoz/Service/Firebase/order_crud.dart';
import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ManagerProcess {
  final BuildContext context;
  final String id;
  ManagerProcess(this.context, this.id);

  void acceptConfirmYes(int type) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.receipt_rounded,
              size: 25.sp,
              color: MyStyle.orangePrimary,
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
                      ? processAcceptOrder(2, 1)
                      : processAcceptOrder(1, 0);
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

  void acceptConfirmNo(int type) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.receipt_rounded,
              size: 25.sp,
              color: MyStyle.orangePrimary,
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
                  processAcceptOrder(6, 2);
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

  Future processAcceptOrder(int status, int track) async {
    bool api = await OrderCRUD()
        .updateOrderStatus(id: id, status: status, track: track);
    if (api) {
      EasyLoading.dismiss();
      Navigator.pop(context);
      if (track == 2) {
        MyFunction().toast('ยกเลิกออเดอร์ เรียบร้อย');
      } else {
        MyFunction().toast('ยอมรับออเดอร์ เรียบร้อย');
        // Provider.of<UserProvider>(context, listen: false).readRiderTokenList();
      }
    } else {
      EasyLoading.dismiss();
      MyDialog(context).doubleDialog(
          'มีปัญหาเกิดขึ้นที่ระบบ', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future processFinishOrder() async {
    bool api = await OrderCRUD().updateOrderStatus(id: id, status: 3, track: 1);
    if (api) {
      EasyLoading.dismiss();
      Navigator.pop(context);
      MyFunction().toast('อัพเดทสถานะ เรียบร้อย');
    } else {
      EasyLoading.dismiss();
      MyDialog(context).doubleDialog(
          'มีปัญหาเกิดขึ้นที่ระบบ', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future processCompleteOrder() async {
    bool api = await OrderCRUD().updateOrderStatus(id: id, status: 5, track: 3);
    if (api) {
      EasyLoading.dismiss();
      Navigator.pop(context);
      MyFunction().toast('อัพเดทสถานะ เรียบร้อย');
    } else {
      EasyLoading.dismiss();
      MyDialog(context).doubleDialog(
          'มีปัญหาเกิดขึ้นที่ระบบ', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
