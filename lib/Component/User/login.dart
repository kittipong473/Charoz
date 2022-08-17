import 'package:charoz/Model_Main/user_model.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

bool statusPassword = true;
final formKey = GlobalKey<FormState>();
TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();
MaskTextInputFormatter phoneFormat = MaskTextInputFormatter(mask: '##########');

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
                top: 3.h,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildImage(),
                          SizedBox(height: 3.h),
                          ScreenWidget().buildTitle('ข้อมุลทั่วไป'),
                          SizedBox(height: 3.h),
                          buildUser(),
                          SizedBox(height: 3.h),
                          buildPassword(),
                          SizedBox(height: 5.h),
                          buildButton(context),
                        ],
                      ),
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

  Widget buildImage() {
    return Image.asset(
      MyImage.logo3,
      width: 40.w,
      height: 40.w,
    );
  }

  Widget buildUser() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 80.w,
      child: TextFormField(
        inputFormatters: [phoneFormat],
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
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'เบอร์โทรศัพท์ :',
          errorStyle: MyStyle().normalRed14(),
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

  Widget buildPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 80.w,
      child: StatefulBuilder(
        builder: (context, setState) => TextFormField(
          style: MyStyle().normalBlack16(),
          obscureText: statusPassword,
          enableSuggestions: false,
          autocorrect: false,
          controller: passwordController,
          toolbarOptions: const ToolbarOptions(
              copy: false, paste: false, cut: false, selectAll: false),
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก Password';
            } else if (value.length < 6 || value.length > 20) {
              return 'Password ต้องมีตัวอักษร 6-20 ตัว';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            labelStyle: MyStyle().normalBlack16(),
            labelText: 'รหัสผ่าน :',
            errorStyle: MyStyle().normalRed14(),
            prefixIcon: const Icon(
              Icons.lock_open_rounded,
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
            suffixIcon: IconButton(
              onPressed: () => setState(() => statusPassword = !statusPassword),
              icon: statusPassword
                  ? Icon(Icons.visibility_rounded,
                      size: 20.sp, color: MyStyle.primary)
                  : Icon(Icons.visibility_off_rounded,
                      size: 20.sp, color: MyStyle.primary),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: Consumer<UserProvider>(
        builder: (_, provider, __) => ElevatedButton(
          style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              EasyLoading.show(status: 'loading...');
              checkUser(context, provider.user);
            }
          },
          child: Text('เข้าสู่ระบบ', style: MyStyle().normalWhite16()),
        ),
      ),
    );
  }

  Future checkUser(BuildContext context, UserModel user) async {
    bool status = await Provider.of<UserProvider>(context, listen: false)
        .checkPhoneAndGetUser(phoneController.text);
    if (status) {
      processLogin(context, user);
    } else {
      EasyLoading.dismiss();
      DialogAlert().doubleDialog(context, 'เบอร์โทรศัพท์นี้ไม่มีอยู่ในระบบ',
          'กรุณาสมัครสมาชิกก่อนจึงเข้าใช้งาน');
    }
  }

  Future processLogin(BuildContext context, UserModel user) async {
    if (user.status == 1) {
      await MyVariable.auth
          .signInWithEmailAndPassword(
              email: user.email, password: passwordController.text)
          .then((value) async {
        phoneController.clear();
        passwordController.clear();
        EasyLoading.dismiss();
        if (user.pincode == '') {
          alertPinCode(context, user.id);
        } else {
          Provider.of<UserProvider>(context, listen: false)
              .setLoginVariable(context);
        }
      }).catchError((e) {
        EasyLoading.dismiss();
        DialogAlert().singleDialog(context, MyFunction().authenAlert(e.code));
      });
    } else {
      EasyLoading.dismiss();
      DialogAlert().doubleDialog(context, 'คุณถูกระงับการใช้งาน',
          'โปรดติดต่อสอบถามผู้ดูแลระบบเมื่อมีข้อสงสัย');
    }
  }

  void alertPinCode(BuildContext context, String id) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: ListTile(
          leading:
              Icon(Icons.info_outlined, color: MyStyle.primary, size: 30.sp),
          title: Text(
            'กำหนดรหัส Pin Code เพื่อความปลอดภัย',
            style: MyStyle().boldPrimary16(),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            'คุณต้องการตั้งรหัส pin code เมื่อเข้าใช้งาน application หรือไม่ ?',
            style: MyStyle().normalBlack14(),
            textAlign: TextAlign.center,
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Navigator.pushNamed(context, RoutePage.routeCodeSetting);
                },
                child: Text('ตั้งรหัส pin', style: MyStyle().boldGreen16()),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Provider.of<UserProvider>(context, listen: false)
                      .setLoginVariable(context);
                },
                child: Text('ไม่ตั้งรหัส', style: MyStyle().boldRed16()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
