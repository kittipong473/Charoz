import 'package:charoz/Model/Service/Route/route_page.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

TextEditingController phoneController = TextEditingController();
MaskTextInputFormatter phoneFormat = MaskTextInputFormatter(mask: '##########');

final UserViewModel userVM = Get.find<UserViewModel>();

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        appBar: ScreenWidget().appBarTheme('เข้าสู่ระบบ'),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Positioned.fill(
                top: 5.h,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ScreenWidget().buildLogoImage(),
                        SizedBox(height: 5.h),
                        buildTitle(),
                        SizedBox(height: 5.h),
                        buildPhone(),
                        SizedBox(height: 5.h),
                        buildButton(context),
                      ],
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

  Widget buildTitle() {
    return Text(
      'กรอกเบอร์โทรศัพท์\nเพื่อใช้สำหรับการส่งรหัสยืนยัน otp',
      style: MyStyle().normalBlack16(),
      textAlign: TextAlign.center,
    );
  }

  Widget buildPhone() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 80.w,
      child: TextFormField(
        inputFormatters: [phoneFormat],
        style: MyStyle().normalBlack16(),
        keyboardType: TextInputType.phone,
        controller: phoneController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก เบอร์โทรศัพท์';
          } else if (value.length != 10) {
            return 'กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'เบอร์โทรศัพท์ :',
          labelStyle: MyStyle().normalBlack16(),
          hintText: '0123456789',
          hintStyle: MyStyle().normalGrey16(),
          prefixIcon: const Icon(
            Icons.phone_rounded,
            color: MyStyle.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.dark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.light),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: MyStyle.bluePrimary),
        onPressed: () async {
          if (phoneController.text.length != 10) {
            MyDialog(context).singleDialog('กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง');
          } else {
            processLogin(context);
          }
        },
        child: Text('ขอรหัสยืนยัน OTP', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Future processLogin(BuildContext context) async {
    userVM.setPhoneVerify(phoneController.text);
    // bool status = await puser.requestOTP();
    // if (status) {
    Navigator.pushNamed(context, RoutePage.routeVerifyToken);
    // } else {
    //   DialogAlert(context).doubleDialog('ไม่สามารถส่งรหัส OTP ได้',
    //       'กรุณาเช็ค การอนุญาต หรือ อินเตอร์เน็ต ของคุณ');
    // }
  }
}
