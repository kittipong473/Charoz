import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Routes/route_page.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

TextEditingController phoneController = TextEditingController();
MaskTextInputFormatter phoneFormat = MaskTextInputFormatter(mask: '##########');

final userVM = Get.find<UserViewModel>();

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyStyle.backgroundColor,
        appBar: MyWidget().appBarTheme(title: 'เข้าสู่ระบบ'),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 3.h),
                  MyWidget().buildLogoImage(),
                  SizedBox(height: 5.h),
                  buildTitle(),
                  SizedBox(height: 8.h),
                  buildPhone(),
                  SizedBox(height: 8.h),
                  MyWidget().buttonWidget(
                    title: 'ขอรหัสยืนยัน OTP',
                    onTap: () => validateInput()
                        ? processLogin()
                        : DialogAlert(context).dialogStatus(
                            type: 1,
                            title: 'กรุณากรอก เบอร์โทรศัพท์ ให้ถูกต้อง'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateInput() => phoneController.text.length == 10;

  Widget buildTitle() {
    return Text(
      'กรอกเบอร์โทรศัพท์\nเพื่อใช้สำหรับการส่งรหัสยืนยัน otp',
      style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
      textAlign: TextAlign.center,
    );
  }

  Widget buildPhone() {
    return SizedBox(
      width: 90.w,
      child: TextFormField(
        inputFormatters: [phoneFormat],
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        keyboardType: TextInputType.phone,
        controller: phoneController,
        decoration: InputDecoration(
          labelText: 'เบอร์โทรศัพท์ :',
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          hintText: '0123456789',
          hintStyle: MyStyle.textStyle(size: 16, color: MyStyle.greyPrimary),
          prefixIcon:
              const Icon(Icons.phone_rounded, color: MyStyle.orangeDark),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeDark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeLight),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void processLogin() {
    userVM.setPhoneVerify(phoneController.text);
    Get.toNamed(RoutePage.routeVerifyToken);
  }
}
