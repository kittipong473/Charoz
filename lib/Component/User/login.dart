import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
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
                          ScreenWidget().buildTitle('เข้าสู่ระบบ'),
                          SizedBox(height: 3.h),
                          buildUser(),
                          SizedBox(height: 3.h),
                          buildPassword(),
                          SizedBox(height: 3.h),
                          buildButton(context),
                          SizedBox(height: 5.h),
                          ScreenWidget().buildTitle('กรณียังไม่เป็นสมาชิก'),
                          SizedBox(height: 2.h),
                          // buildPhone(),
                          buildRegister(context),
                          SizedBox(height: 1.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ScreenWidget().appBarTitle('บัญชีผู้ใช้งาน'),
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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            EasyLoading.show(status: 'loading...');
            Provider.of<UserProvider>(context, listen: false)
                .authenEmailFirebase(
                    context, phoneController.text, passwordController.text);
          }
        },
        child: Text('เข้าสู่ระบบ', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Widget buildPhone(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () =>
            Navigator.pushNamed(context, RoutePage.routeRegisterToken),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_rounded,
              size: 18.sp,
              color: Colors.white,
            ),
            SizedBox(width: 2.w),
            Text(
              'สมัครสมาชิกด้วยเบอร์โทรศัพท์',
              style: MyStyle().normalWhite16(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRegister(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () =>
            Navigator.pushNamed(context, RoutePage.routeRegister),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_note_rounded,
              size: 18.sp,
              color: Colors.white,
            ),
            SizedBox(width: 2.w),
            Text('สมัครสมาชิก', style: MyStyle().normalWhite16()),
          ],
        ),
      ),
    );
  }
}
