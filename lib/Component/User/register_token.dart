import 'package:charoz/Component/User/register_phone.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterToken extends StatefulWidget {
  const RegisterToken({Key? key}) : super(key: key);

  @override
  State<RegisterToken> createState() => _RegisterTokenState();
}

class _RegisterTokenState extends State<RegisterToken> {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  MaskTextInputFormatter phoneFormat =
      MaskTextInputFormatter(mask: '##########');
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h),
                        buildImage(),
                        SizedBox(height: 5.h),
                        ScreenWidget()
                            .buildTitle('??????????????????????????????????????????????????????????????????????????? otp'),
                        SizedBox(height: 3.h),
                        buildPhone(),
                        SizedBox(height: 3.h),
                        buildOtpField(),
                      ],
                    ),
                  ),
                ),
              ),
              ScreenWidget().appBarTitle('????????????????????????????????????????????????????????????????????????????????????'),
              ScreenWidget().backPage(context),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Image.asset(
      MyImage.logo3,
      width: 40.w,
      height: 40.w,
    );
  }

  Widget buildPhone() {
    return Container(
      width: 80.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: MyStyle.dark),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(
            MyImage.thai,
            width: 5.w,
            height: 5.w,
          ),
          SizedBox(width: 2.w),
          Text('+66', style: MyStyle().normalBlack16()),
          SizedBox(width: 3.w),
          SizedBox(
            width: 50.w,
            child: TextFormField(
              style: MyStyle().normalBlack16(),
              keyboardType: TextInputType.phone,
              controller: phoneController,
              inputFormatters: [phoneFormat],
              validator: (value) {
                if (value!.isEmpty) {
                  return '??????????????????????????? ???????????????????????????????????????';
                }
                if (value.length != 10) {
                  return '??????????????????????????? ??????????????????????????????????????? ??????????????????????????????';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  labelStyle: MyStyle().normalBlack16(),
                  labelText: '??????????????????????????????????????? :',
                  hintText: '0123456789',
                  hintStyle: MyStyle().normalGrey16(),
                  errorStyle: MyStyle().normalRed14(),
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOtpField() {
    return Visibility(
      visible: otpVisible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '???????????? OTP :',
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
                    authenTokenFirebase();
                  } else {
                    EasyLoading.show(status: 'loading...');
                    requestOTP();
                    // otpVisible = true;
                    // EasyLoading.dismiss();
                    // setState(() {
                      
                    // });
                  }
                }
              },
              child: otpVisible
                  ? Text('?????????????????????????????? OTP', style: MyStyle().normalWhite16())
                  : Text('????????????????????????????????? OTP', style: MyStyle().normalWhite16()),
            ),
          ),
        ],
      ),
    );
  }

  Future requestOTP() async {
    await GlobalVariable.auth.verifyPhoneNumber(
      phoneNumber: "+66" + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await GlobalVariable.auth
            .signInWithCredential(credential)
            .then((value) {
          MyFunction().toast('?????????????????? OTP ??????????????????');
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        EasyLoading.dismiss();
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

  Future authenTokenFirebase() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID!, smsCode: otpController.text);
    await GlobalVariable.auth
        .signInWithCredential(credential)
        .then((value) async {
      bool status = await Provider.of<UserProvider>(context, listen: false)
          .checkPhoneAndGetUser(phoneController.text);
      if (status) {
        EasyLoading.dismiss();
        DialogAlert().doubleDialog(context, '?????????????????????????????????????????????????????????????????????????????????',
            '?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????');
      } else {
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterPhone(
              phone: phoneController.text,
              token: value.user!.uid,
            ),
          ),
        );
      }
    });
  }
}
