import 'package:charoz/Model/Service/CRUD/api_controller.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/user_crud.dart';
import 'package:charoz/Model/Service/Route/route_page.dart';
import 'package:charoz/Util/Constant/my_image.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerifyToken extends StatefulWidget {
  const VerifyToken({Key? key}) : super(key: key);

  @override
  State<VerifyToken> createState() => _VerifyTokenState();
}

class _VerifyTokenState extends State<VerifyToken> {
  TextEditingController otpController = TextEditingController();

  final ApiController capi = Get.find<ApiController>();
  final UserViewModel userVM = Get.find<UserViewModel>();

  @override
  void initState() {
    super.initState();
    userVM.initOTPTime();
    userVM.startOTPTime();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    capi.loadingPage(false);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        appBar: ScreenWidget().appBarTheme('ยืนยันรหัส OTP'),
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
                        buildOTPField(),
                        SizedBox(height: 3.h),
                        buildResend(context),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'ทางเราได้ส่งรหัส OTP ไปยังเบอร์โทรศัพท์ของท่านแล้ว',
          style: MyStyle().normalBlack16(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(MyImage.gifPhone, width: 8.w, height: 8.w),
            SizedBox(width: 1.w),
            Text(userVM.phoneNumber, style: MyStyle().boldBlue18()),
          ],
        ),
        SizedBox(height: 2.h),
        Text('รหัสอ้างอิง : ${userVM.otpRefNo ?? 'xxx'}',
            style: MyStyle().normalGrey14()),
      ],
    );
  }

  Widget buildOTPField() {
    return SizedBox(
      width: 80.w,
      child: PinFieldAutoFill(
        autoFocus: true,
        controller: otpController,
        onCodeSubmitted: (_) {},
        onCodeChanged: (code) {
          if (code!.length == 6) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
      ),
    );
  }

  Widget buildResend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async {
            // if (userVM.delayedTimer > 10) {
            //   await userVM.requestOTP();
            //   userVM.initOTPTime();
            //   if (provider.otpInTimeVerify == false) {
            //     userVM.startOTPTime();
            //   }
            // } else {
            //   MyDialog(context).doubleDialog(
            //       'คุณขอรหัสถี่เกินไป', 'กรุณารอเวลาเพื่อขอรหัสใหม่อีกครั้ง');
            // }
          },
          child: Text('ส่งรหัสอีกครั้ง', style: MyStyle().boldPrimary16()),
        ),
      ],
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: MyStyle.bluePrimary),
        onPressed: () async {
          // if (otpController.text.length != 6) {
          //   DialogAlert(context).singleDialog('กรุณากรอกรหัส OTP ให้ครบถ้วน');
          // } else if (provider.otpInTimeVerify == false) {
          //   DialogAlert(context)
          //       .singleDialog('รหัส OTP หมดอายุการใช้งานแล้ว');
          // } else {
          // confirmOTP(context);
          // }
          processVerify();
        },
        child: Text('ยืนยันรหัส OTP', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Future confirmOTP(BuildContext context) async {
    capi.loadingPage(true);
    bool status = await capi.confirmOTP(userVM.otpToken, otpController.text);
    if (status) {
      processVerify();
    } else {
      MyDialog(context)
          .doubleDialog('รหัส OTP ของคุณไม่ถูกต้อง', 'กรุณาลองใหม่อีกครั้ง');
    }
  }

  Future processVerify() async {
    capi.loadingPage(true);
    bool status = await userVM.checkPhoneAndGetUser();
    if (status) {
      processAuthen(context);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutePage.routeRegister, (route) => false);
    }
    capi.loadingPage(false);
  }

  Future processAuthen(BuildContext context) async {
    if (userVM.user.status == 1) {
      await VariableGeneral.auth
          .signInWithEmailAndPassword(
              email: userVM.user.email, password: getPasswordSignIn())
          .then((value) async {
        bool status = await UserCRUD().updateUserTokenDevice(userVM.user.id);
        if (status) {
          userVM.setLoginVariable();
        } else {
          EasyLoading.dismiss();
          MyDialog(context).doubleDialog(
              'เกิดข้อผิดพลาดในการเก็บ token', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
        }
      }).catchError((e) {
        EasyLoading.dismiss();
        MyDialog(context).singleDialog(MyFunction().authenAlert(e.code));
      });
    } else {
      EasyLoading.dismiss();
      MyDialog(context).doubleDialog(
          'คุณถูกระงับการใช้งาน', 'โปรดติดต่อสอบถามผู้ดูแลระบบเมื่อมีข้อสงสัย');
    }
  }

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
      return MyFunction().encryption(phone);
    }
  }
}
