import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pin_code_widget/flutter_pin_code_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
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
                child: Consumer<UserProvider>(
                  builder: (_, provider, __) => PinCodeWidget(
                    onFullPin: (code, __) =>
                        processVerify(context, provider.user.pincode, code),
                    numbersStyle: MyStyle().normalWhite18(),
                    initialPinLength: 6,
                    onChangedPin: (code) {},
                    leftBottomWidget: IconButton(
                      onPressed: () => confirmLogout(context),
                      icon: Icon(
                        Icons.logout_rounded,
                        size: 30.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void processVerify(BuildContext context, String baseCode, String inputCode) {
    if (baseCode == inputCode) {
      MyFunction().toast('ยินดีต้อนรับสู่ Charoz Application');
      Navigator.pushNamedAndRemoveUntil(
          context, RoutePage.routePageNavigation, (route) => false);
    } else {
      DialogAlert()
          .doubleDialog(context, 'รหัส PIN ไม่ถูกต้อง', 'กรุณาลองใหม่อีกครั้ง');
    }
  }

  void confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(MyImage.svgWarning, width: 15.w, height: 15.w),
            SizedBox(height: 2.h),
            Text(
              "คุณต้องการออกจากระบบหรือไม่ ?",
              style: MyStyle().normalBlue16(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 25.w,
                height: 4.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red.shade100),
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('ยกเลิก', style: MyStyle().boldRed16()),
                ),
              ),
              SizedBox(
                width: 25.w,
                height: 4.h,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.green.shade100),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    EasyLoading.show(status: 'loading...');
                    Provider.of<UserProvider>(context, listen: false)
                        .signOutFirebase(context);
                  },
                  child: Text('ยืนยัน', style: MyStyle().boldGreen16()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
