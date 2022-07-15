import 'package:charoz/Component/Security/code_setting.dart';
import 'package:charoz/Component/Security/code_verify.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DialogAlert {
  void confirmDialog(BuildContext context) {
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

  void singleDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading:
              Icon(Icons.info_outlined, color: MyStyle.primary, size: 30.sp),
          title: Text(
            title,
            style: MyStyle().boldPrimary16(),
            textAlign: TextAlign.center,
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void doubleDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading:
              Icon(Icons.info_outlined, color: MyStyle.primary, size: 30.sp),
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
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void successDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
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
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void failedDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
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
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void addFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
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
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void editFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
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
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void deleteFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
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
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void checkLogin(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading:
              Icon(Icons.info_outlined, color: MyStyle.primary, size: 30.sp),
          title: Text(
            'คุณยังไม่ได้เข้าสู่ระบบ',
            style: MyStyle().boldPrimary16(),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            'กรุณาเข้าสู่ระบบเพื่อใช้งาน',
            style: MyStyle().normalBlack14(),
            textAlign: TextAlign.center,
          ),
        ),
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutePage.routePageNavigation, (route) => false);
              GlobalVariable.indexPageNavigation = 4;
            },
            child: Text('เข้าสู่ระบบ', style: MyStyle().boldBlue18()),
          ),
        ],
      ),
    );
  }

  void alertPinCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading:
              Icon(Icons.info_outlined, color: MyStyle.primary, size: 30.sp),
          title: Text(
            'กำหนดรหัส Pin Code เพื่อความปลอดภัย',
            style: MyStyle().boldPrimary16(),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            'คุณต้องการตั้งรหัส pin code เมื่อเข้าใช้งาน application หรือไม่ ?',
            style: MyStyle().normalBlack14(),
            textAlign: TextAlign.center,
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CodeSetting()),
                    );
                  });
                },
                child: Text('ตั้งรหัส pin', style: MyStyle().boldGreen16()),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ไว้คราวหลัง', style: MyStyle().boldBlue16()),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ไม่ตั้งรหัส', style: MyStyle().boldRed16()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
