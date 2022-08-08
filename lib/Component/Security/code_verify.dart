import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_widget/flutter_pin_code_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CodeVerify extends StatelessWidget {
  const CodeVerify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 5.h,
              child: SizedBox(
                width: 100.w,
                child: Column(
                  children: [
                    Text(
                      'ใส่รหัส PIN',
                      style: MyStyle().boldBlack18(),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'ใส่รหัส PIN อย่างน้อย 6 ตัวอักษร',
                      style: MyStyle().normalBlack18(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: MyVariable.largeDevice
                    ? EdgeInsets.symmetric(horizontal: 10.w)
                    : const EdgeInsets.symmetric(horizontal: 0),
                width: 100.w,
                height: 80.h,
                child: PinCodeWidget(
                  onFullPin: (code, __) {
                    if (code == '000000') {
                      Navigator.pop(context);
                    } else {
                      DialogAlert().doubleDialog(context, 'รหัส PIN ไม่ถูกต้อง',
                          'กรุณาลองใหม่อีกครั้ง');
                    }
                  },
                  numbersStyle: MyStyle().normalWhite18(),
                  initialPinLength: 6,
                  onChangedPin: (code) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
