import 'dart:math';

import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Firebase/user_crud.dart';
import 'package:charoz/Service/Library/console_log.dart';
import 'package:charoz/Service/Library/notification_service.dart';
import 'package:charoz/Service/Routes/route_page.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VerifyToken extends StatefulWidget {
  const VerifyToken({Key? key}) : super(key: key);

  @override
  State<VerifyToken> createState() => _VerifyTokenState();
}

class _VerifyTokenState extends State<VerifyToken> {
  final userVM = Get.find<UserViewModel>();
  int otpNumber = 0;

  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userVM.initOTPTime();
    userVM.startOTPTime();
    // userVM.requestOTP();
    sendNoti();
  }

  void sendNoti() {
    otpNumber = Random().nextInt(9000) + 1000; // 1000 - 9999
    ConsoleLog.printGreen(text: otpNumber.toString());
    NotificationService().showNotification(
        title: 'OTP Verification', body: 'Your number is $otpNumber');
  }

  @override
  void dispose() {
    userVM.stopOTPTime();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        appBar: MyWidget().appBarTheme(title: 'ยืนยันรหัส OTP'),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 3.h),
                  MyWidget().buildLogoImage(),
                  SizedBox(height: 5.h),
                  buildTitle(),
                  SizedBox(height: 5.h),
                  buildOTPField(),
                  SizedBox(height: 2.h),
                  buildTimeCount(),
                  SizedBox(height: 1.h),
                  buildResend(context),
                  SizedBox(height: 5.h),
                  MyWidget().buttonWidget(
                    title: 'ยืนยันรหัส OTP',
                    onTap: () {
                      if (otpController.text.length != 4) {
                        DialogAlert(context).dialogStatus(
                            type: 1, title: 'กรุณากรอกรหัส OTP ให้ครบถ้วน');
                      } else if (userVM.otpInTimeVerify == false) {
                        DialogAlert(context).dialogStatus(
                            type: 1, title: 'รหัส OTP หมดอายุการใช้งานแล้ว');
                      } else {
                        confirmOTP(context);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'ทางเราได้ส่งรหัส OTP ไปยังเบอร์โทรศัพท์ของท่านแล้ว',
          style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyWidget()
                .showImage(path: MyImage.lotPhone, width: 8.w, height: 8.w),
            SizedBox(width: 1.w),
            Text(
              userVM.phoneNumber,
              style: MyStyle.textStyle(size: 18, color: MyStyle.bluePrimary),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Text('รหัสอ้างอิง : ${userVM.otpRefNo}',
            style: MyStyle.textStyle(size: 14, color: Colors.black38)),
      ],
    );
  }

  Widget buildOTPField() {
    return SizedBox(
      width: 70.w,
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        obscureText: false,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 7.h,
          fieldWidth: 12.w,
          activeFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          selectedFillColor: Colors.white,
          activeColor: MyStyle.bluePrimary,
          inactiveColor: Colors.transparent,
          selectedColor: MyStyle.bluePrimary,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        controller: otpController,
        onCompleted: (_) {},
        onChanged: (_) {},
        beforeTextPaste: (text) {
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
    );
  }

  Widget buildTimeCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Text(
            'รหัสหมดอายุใน : ${userVM.minutes}:${userVM.seconds}',
            style: MyStyle.textStyle(size: 14, color: MyStyle.blackPrimary),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget buildResend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async {
            if (userVM.delayResend) {
              // await userVM.requestOTP();
              sendNoti();
              otpController.clear();
              userVM.initOTPTime();
              userVM.setDelayResend(false);
              if (userVM.otpInTimeVerify == false) {
                userVM.startOTPTime();
              }
              ConsoleLog.toast(text: 'ส่งรหัสใหม่ สำเร็จ');
            } else {
              ConsoleLog.toast(
                  text: 'คุณขอรหัสบ่อยเกินไป\nรอเวลาเพื่อขอรหัสใหม่อีกครั้ง');
            }
          },
          child: Text('ส่งรหัสอีกครั้ง',
              style: MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary)),
        ),
      ],
    );
  }

  Future confirmOTP(BuildContext context) async {
    // bool status = await capi.confirmOTP(userVM.otpToken, otpController.text);
    bool status = otpController.text == otpNumber.toString();
    if (status) {
      processVerify();
    } else {
      DialogAlert(context).dialogStatus(
        type: 2,
        title: 'รหัส OTP ของคุณไม่ถูกต้อง',
        body: 'กรุณาลองใหม่อีกครั้ง',
      );
    }
  }

  Future processVerify() async {
    bool status = await userVM.checkPhoneAndGetUser();
    if (status) {
      processAuthen(context);
    } else {
      Get.offNamed(RoutePage.routeRegister);
    }
  }

  Future processAuthen(BuildContext context) async {
    if (userVM.user!.status!) {
      await UserCRUD().updateUserTokenDevice(id: userVM.user!.id!);
      userVM.setLoginVariable();
    } else {
      DialogAlert(context).dialogStatus(
        type: 2,
        title: 'คุณถูกระงับการใช้งาน',
        body: 'โปรดติดต่อสอบถามผู้ดูแลระบบเมื่อมีข้อสงสัย',
      );
    }
  }

  // Future processAuthen(BuildContext context) async {
  //   if (userVM.user.status == 1) {
  //     await VariableGeneral.auth
  //         .signInWithEmailAndPassword(
  //             email: userVM.user.email, password: getPasswordSignIn())
  //         .then((value) async {
  //       bool status = await UserCRUD().updateUserTokenDevice(userVM.user.id);
  //       if (status) {
  //         userVM.setLoginVariable();
  //       } else {
  //         EasyLoading.dismiss();
  //         MyDialog(context).doubleDialog(
  //             'เกิดข้อผิดพลาดในการเก็บ token', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
  //       }
  //     }).catchError((e) {
  //       EasyLoading.dismiss();
  //       MyDialog(context).singleDialog(MyFunction().authenAlert(e.code));
  //     });
  //   } else {
  //     EasyLoading.dismiss();
  //     MyDialog(context).doubleDialog(
  //         'คุณถูกระงับการใช้งาน', 'โปรดติดต่อสอบถามผู้ดูแลระบบเมื่อมีข้อสงสัย');
  //   }
  // }

  String getPasswordSignIn() {
    String phone = userVM.phoneNumber;
    if (phone == '0956492669') {
      return 'Kittipong473';
    } else if (phone == '0971596142') {
      return 'AdminCharoz';
    } else if (phone == '0837857555') {
      return 'CharozRider';
    } else if (phone == '0123456789') {
      return 'CharozCustomer';
    } else {
      return MyFunction().encryption(text: phone);
    }
  }
}
