import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
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

  void doubleDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: const Icon(
            Icons.info_outlined,
            color: MyStyle.primary,
            size: 50,
          ),
          title: Text(title, style: MyStyle().boldPrimary16()),
          subtitle: Text(
            message,
            style: MyStyle().normalPrimary14(),
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: MyStyle().boldBlue18(),
            ),
          ),
        ],
      ),
    );
  }

  void successDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: const Icon(
            Icons.check_circle_outlined,
            color: MyStyle.primary,
            size: 50,
          ),
          title: Text(
            title,
            style: MyStyle().boldPrimary14(),
          ),
          subtitle: Text(
            message,
            style: MyStyle().normalPrimary14(),
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: MyStyle().boldBlue14(),
            ),
          ),
        ],
      ),
    );
  }

  void failedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: const Icon(
            Icons.dangerous_outlined,
            color: Colors.red,
            size: 50,
          ),
          title: Text(
            'ระบบเกิดข้อผิดพลาด',
            style: MyStyle().boldRed14(),
          ),
          subtitle: Text(
            'กรุณาลองใหม่อีกครั้งในภายหลัง',
            style: MyStyle().normalRed14(),
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: MyStyle().boldBlue14(),
            ),
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
          leading: const Icon(
            Icons.info_outlined,
            color: MyStyle.primary,
            size: 50,
          ),
          title: SizedBox(
            width: 30.w,
            child: Text(
              title,
              style: MyStyle().boldPrimary18(),
            ),
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: MyStyle().boldBlue18(),
            ),
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
          leading: const Icon(
            Icons.info_outlined,
            color: MyStyle.primary,
            size: 50,
          ),
          title: Text(
            'คุณยังไม่ได้เข้าสู่ระบบ',
            style: MyStyle().boldPrimary14(),
          ),
          subtitle: Text(
            'กรุณาเข้าสู่ระบบเพื่อใช้งาน',
            style: MyStyle().normalPrimary14(),
          ),
        ),
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutePage.routePageNavigation, (route) => false);
              MyVariable.indexPageNavigation = 4;
            },
            child: Text(
              'เข้าสู่ระบบ',
              style: MyStyle().boldBlue14(),
            ),
          ),
        ],
      ),
    );
  }
}
