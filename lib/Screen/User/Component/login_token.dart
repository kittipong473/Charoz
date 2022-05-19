import 'package:charoz/Screen/User/Component/register_phone.dart';
import 'package:charoz/Screen/User/Provider/user_provider.dart';
import 'package:charoz/Service/Api/user_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_dialog.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  String verificationID = "";
  bool load = false;

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
                  padding: MyVariable.largeDevice
                      ? const EdgeInsets.symmetric(horizontal: 40)
                      : const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 12.h),
                        MyWidget().buildTitle(title: 'เบอร์โทรศัพท์'),
                        SizedBox(height: 3.h),
                        buildPhoneNumber(),
                        SizedBox(height: 3.h),
                        buildOtpField(),
                      ],
                    ),
                  ),
                ),
              ),
              MyWidget().backgroundTitle(),
              MyWidget().title('เข้าสู่ระบบด้วยเบอร์โทรศัพท์'),
              MyWidget().backPage(context),
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
              style: ElevatedButton.styleFrom(primary: MyStyle.blue),
              onPressed: () {
                if (load) return;
                setState(() => load = true);
                if (formKey.currentState!.validate()) {
                  if (otpVisible) {
                    verifyOTP();
                  } else {
                    requestOTP();
                  }
                }
              },
              child: load
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(color: Colors.white),
                        SizedBox(width: 3.w),
                        Text(
                          'Please Wait...',
                          style: MyStyle().normalWhite18(),
                        ),
                      ],
                    )
                  : otpVisible
                      ? Text(
                          'ยืนยันรหัส OTP',
                          style: MyStyle().boldWhite16(),
                        )
                      : Text(
                          'ส่งคำขอรหัส OTP',
                          style: MyStyle().boldWhite16(),
                        ),
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
              style: MyStyle().boldBlack18OTP(),
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
          MyWidget().toast('ยืนยัน OTP สำเร็จ');
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() => load = false);
        MyDialog().singleDialog(context, e.code);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisible = true;
        verificationID = verificationId;
        load = false;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);
    await MyVariable.auth.signInWithCredential(credential).then((value) async {
      bool status =
          await UserApi().checkUserWherePhone(phone: phoneController.text);
      if (!status) {
        MyVariable.login = true;
        MyVariable.indexPage = 0;
        MyVariable.role =
            await Provider.of<UserProvider>(context, listen: false)
                .getUserRoleWherePhone(phone: phoneController.text);
        MyWidget().toast('ยินดีต้อนรับสู่ Application');
        load = false;
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routePageNavigation, (route) => false);
      } else {
        load = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterPhone(
              phone: phoneController.text,
              tokenP: value.user!.uid,
            ),
          ),
        );
      }
    });
  }
}
