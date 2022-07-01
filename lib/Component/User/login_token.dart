import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/show_toast.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginToken extends StatefulWidget {
  const LoginToken({Key? key}) : super(key: key);

  @override
  State<LoginToken> createState() => _LoginTokenState();
}

class _LoginTokenState extends State<LoginToken> {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool otpVisible = false;
  String? verificationID;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 12.h),
                        ScreenWidget().buildTitle('เบอร์โทรศัพท์'),
                        SizedBox(height: 3.h),
                        buildPhoneNumber(),
                        SizedBox(height: 3.h),
                        buildOtpField(),
                      ],
                    ),
                  ),
                ),
              ),
              ScreenWidget().appBarTitle('เข้าสู่ระบบด้วยเบอร์โทรศัพท์'),
              ScreenWidget().backPage(context),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Positioned buildButton() {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 70.w,
            height: 5.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (otpVisible) {
                    EasyLoading.show(status: 'loading...');
                    Provider.of<UserProvider>(context, listen: false)
                        .authenTokenFirebase(context, verificationID!,
                            otpController.text, phoneController.text);
                  } else {
                    EasyLoading.show(status: 'loading...');
                    requestOTP();
                  }
                }
              },
              child: otpVisible
                  ? Text('ยืนยันรหัส OTP', style: MyStyle().normalWhite16())
                  : Text('ส่งคำขอรหัส OTP', style: MyStyle().normalWhite16()),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPhoneNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration:
              const BoxDecoration(border: Border(right: BorderSide(width: 1))),
          width: 20.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                MyImage.thai,
                width: 8.w,
                height: 8.w,
              ),
              SizedBox(width: 1.w),
              Text(
                '+66 ',
                style: MyStyle().normalBlack16(),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: 65.w,
          child: TextFormField(
            maxLength: 10,
            readOnly: otpVisible,
            autofocus: true,
            style: MyStyle().normalBlack16(),
            keyboardType: TextInputType.number,
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
              hintText: '0XX-XXXXXXX',
              hintStyle: MyStyle().normalGrey16(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOtpField() {
    return Visibility(
      visible: otpVisible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'รหัส OTP :',
            style: MyStyle().boldBlack16(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: 60.w,
            child: TextFormField(
              maxLength: 6,
              autofocus: true,
              style: MyStyle().boldBlack18(),
              keyboardType: TextInputType.number,
              controller: otpController,
            ),
          ),
        ],
      ),
    );
  }

  Future requestOTP() async {
    await MyVariable.auth.verifyPhoneNumber(
      phoneNumber: "+66" + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await MyVariable.auth.signInWithCredential(credential).then((value) {
          ShowToast().toast('ยืนยัน OTP สำเร็จ');
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        DialogAlert().singleDialog(context, e.code);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisible = true;
        verificationID = verificationId;
        EasyLoading.dismiss();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
