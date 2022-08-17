import 'package:charoz/Component/Security/Dialog/security_dialog.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_widget/flutter_pin_code_widget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CodeManage extends StatelessWidget {
  const CodeManage({Key? key}) : super(key: key);

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
                child: Consumer<UserProvider>(
                  builder: (_, provider, __) => PinCodeWidget(
                    onFullPin: (code, __) {
                      if (code == provider.user.pincode) {
                        SecurityDialog()
                            .managePinCode(context, provider.user.id);
                      } else {
                        DialogAlert().doubleDialog(context,
                            'รหัส PIN ไม่ถูกต้อง', 'กรุณาลองใหม่อีกครั้ง');
                      }
                    },
                    numbersStyle: MyStyle().normalWhite18(),
                    initialPinLength: 6,
                    onChangedPin: (code) {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
