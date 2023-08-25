import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyDialog {
  final BuildContext context;
  MyDialog(this.context);

  void confirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'XXX',
          style: MyStyle().boldPrimary14(),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'ยืนยัน',
                  style: MyStyle().boldGreen14(),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'ยกเลิก',
                  style: MyStyle().boldRed14(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void singleDialog(String title) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: ListTile(
          leading: Icon(Icons.info_outlined,
              color: MyStyle.orangePrimary, size: 30.sp),
          title: Text(
            title,
            style: MyStyle().boldPrimary16(),
            textAlign: TextAlign.center,
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void doubleDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: ListTile(
          leading: Icon(Icons.info_outlined,
              color: MyStyle.orangePrimary, size: 30.sp),
          title: Text(
            title,
            style: MyStyle().boldPrimary16(),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            message,
            style: MyStyle().normalBlack14(),
            textAlign: TextAlign.center,
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void successDialog(String title) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: ListTile(
          leading: Icon(Icons.check_circle_outlined,
              color: Colors.green, size: 30.sp),
          title: Text(
            title,
            style: MyStyle().boldGreen16(),
            textAlign: TextAlign.center,
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void failedDialog(String title) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: ListTile(
            leading:
                Icon(Icons.dangerous_outlined, color: Colors.red, size: 30.sp),
            title: Text(
              title,
              style: MyStyle().boldRed16(),
              textAlign: TextAlign.center,
            )),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void addFailedDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: ListTile(
          leading:
              Icon(Icons.dangerous_outlined, color: Colors.red, size: 30.sp),
          title: Text(
            'เพิ่มข้อมูลล้มเหลว',
            style: MyStyle().boldRed16(),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            'กรุณาลองใหม่อีกครั้งในภายหลัง',
            style: MyStyle().normalBlack14(),
            textAlign: TextAlign.center,
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void editFailedDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: ListTile(
          leading:
              Icon(Icons.dangerous_outlined, color: Colors.red, size: 30.sp),
          title: Text(
            'แก้ไขข้อมูลล้มเหลว',
            style: MyStyle().boldRed16(),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            'กรุณาลองใหม่อีกครั้งในภายหลัง',
            style: MyStyle().normalBlack14(),
            textAlign: TextAlign.center,
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void deleteFailedDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: ListTile(
          leading:
              Icon(Icons.dangerous_outlined, color: Colors.red, size: 30.sp),
          title: Text(
            'ลบข้อมูลล้มเหลว',
            style: MyStyle().boldRed16(),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            'กรุณาลองใหม่อีกครั้งในภายหลัง',
            style: MyStyle().normalBlack14(),
            textAlign: TextAlign.center,
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }
}
