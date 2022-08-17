import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Database/Firebase/user_crud.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pin_code_widget/flutter_pin_code_widget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

String? codeSet;

class CodeSetting extends StatelessWidget {
  const CodeSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    codeSet = null;
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
                  child: Consumer<UserProvider>(
                    builder: (_, provider, __) => PinCodeWidget(
                      onFullPin: (code, __) {
                        if (codeSet == null) {
                          setState(() => codeSet = code);
                        } else if (codeSet == code) {
                          EasyLoading.show(status: 'loading...');
                          processVerify(context, provider.user.id, code);
                        } else {
                          setState(() => codeSet = null);
                          DialogAlert().doubleDialog(
                            context,
                            'รหัส pin ไม่ตรงกัน',
                            'กรุณากำหนดรหัส pin ใหม่อีกครั้ง',
                          );
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
      ),
    );
  }

  Future processVerify(BuildContext context, String id, String code) async {
    bool status = await UserCRUD().updateUserCode(id, code);
    if (status) {
      Navigator.pop(context);
      if (MyVariable.login) {
        Provider.of<UserProvider>(context, listen: false).readUserById(id);
        EasyLoading.dismiss();
        MyFunction().toast('ตั้งรหัส Pin เรียบร้อย');
      } else {
        Provider.of<UserProvider>(context, listen: false).readUserById(id);
        Provider.of<UserProvider>(context, listen: false)
            .setLoginVariable(context);
      }
    } else {
      EasyLoading.dismiss();
      DialogAlert().doubleDialog(
        context,
        'กำหนด pin ล้มเหลว',
        'กรุณาลองใหม่อีกครั้งในภายหลัง',
      );
    }
  }
}
