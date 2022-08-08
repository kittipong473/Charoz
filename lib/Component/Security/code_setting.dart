import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_widget/flutter_pin_code_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

String? codeSet;

class CodeSetting extends StatelessWidget {
  const CodeSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: StatefulBuilder(
          builder: (context, setState) => Stack(
            children: [
              Positioned(
                top: 5.h,
                child: SizedBox(
                  width: 100.w,
                  child: Column(
                    children: [
                      if (codeSet == null) ...[
                        Text(
                          'กำหนดรหัส PIN',
                          style: MyStyle().boldBlue18(),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'ใส่รหัส PIN อย่างน้อย 6 ตัวอักษร',
                          style: MyStyle().normalBlack18(),
                          textAlign: TextAlign.center,
                        ),
                      ] else ...[
                        Text(
                          'ยืนยันรหัส PIN อีกครั้ง',
                          style: MyStyle().boldGreen18(),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'ใส่รหัส PIN อย่างน้อย 6 ตัวอักษร',
                          style: MyStyle().normalBlack18(),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
                    onFullPin: (code, __) async {
                      if (codeSet == null) {
                        setState(() => codeSet = code);
                      } else if (codeSet == code) {
                        // bool status =
                        //     await UserApi().editPinWhereUser(code: code);
                        // if (status) {
                        //   Navigator.pop(context);
                        //   MyFunction().toast('กำหนดรหัส pin เรียบร้อย');
                        // } else {
                        //   DialogAlert().doubleDialog(
                        //     context,
                        //     'กำหนด pin ล้มเหลว',
                        //     'กรุณาลองใหม่อีกครั้งในภายหลัง',
                        //   );
                        // }
                      } else {
                        setState(() => codeSet = null);
                        DialogAlert().doubleDialog(
                          context,
                          'รหัส pin ไม่ตรงกัน',
                          'กำหนดรหัส pin ใหม่อีกครั้งให้ตรงกัน',
                        );
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
      ),
    );
  }
}
