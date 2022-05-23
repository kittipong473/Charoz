import 'package:charoz/Screen/User/Provider/user_provider.dart';
import 'package:charoz/Service/Api/user_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_dialog.dart';
import 'package:charoz/Utilty/Constant/my_function.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({Key? key}) : super(key: key);

  @override
  _LoginPhoneState createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  bool statusPassword = true;
  bool rememberPassword = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: MyVariable.largeDevice
                        ? const EdgeInsets.symmetric(horizontal: 40)
                        : const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          buildImage(),
                          SizedBox(height: 5.h),
                          buildComment(),
                          SizedBox(height: 3.h),
                          MyWidget().buildTitle(title: 'เข้าสู่ระบบ'),
                          SizedBox(height: 3.h),
                          buildUser(),
                          SizedBox(height: 3.h),
                          buildPassword(),
                          SizedBox(height: 5.h),
                          buildButton(context),
                          // SizedBox(height: 5.h),
                          // MyWidget().buildTitle(
                          //     title: 'เข้าสู่ระบบ หรือ สมัครสมาชิก'),
                          // SizedBox(height: 3.h),
                          // buildPhone(context),
                          // SizedBox(height: 1.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              MyWidget().backgroundTitle(),
              MyWidget().title('บัญชีผู้ใช้งาน'),
              MyWidget().backPage(context),
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

  Widget buildComment() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'สำหรับผู้จัดการร้านเท่านั้น',
              style: MyStyle().boldBlue16(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ยังไม่เปิดให้บริการสำหรับลูกค้า',
              style: MyStyle().boldBlue16(),
            ),
          ],
        ),
      ],
    );
  }

  Row buildUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
          child: TextFormField(
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
        ),
      ],
    );
  }

  Row buildPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
          child: TextFormField(
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
                onPressed: () {
                  setState(() {
                    statusPassword = !statusPassword;
                  });
                },
                icon: statusPassword
                    ? Icon(
                        Icons.visibility_rounded,
                        size: MyVariable.largeDevice ? 35 : 25,
                        color: MyStyle.primary,
                      )
                    : Icon(
                        Icons.visibility_off_rounded,
                        size: MyVariable.largeDevice ? 35 : 25,
                        color: MyStyle.primary,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPhone(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.blue),
            onPressed: () {
              Navigator.pushNamed(context, RoutePage.routeLoginToken);
            },
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
                  'จัดการด้วยเบอร์โทรศัพท์',
                  style: MyStyle().boldWhite16(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.blue),
            onPressed: () {
              if (load) return;
              setState(() => load = true);
              if (formKey.currentState!.validate()) {
                checkPhonetoEmail();
              } else {
                setState(() => load = false);
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
                : Text(
                    'เข้าสู่ระบบ',
                    style: MyStyle().boldWhite16(),
                  ),
          ),
        ),
      ],
    );
  }

  Future checkPhonetoEmail() async {
    String email = "";
    bool status =
        await UserApi().checkUserWherePhone(phone: phoneController.text);
    if (!status) {
      email = await Provider.of<UserProvider>(context, listen: false)
          .getUserEmailWherePhone(phone: phoneController.text);
      authenFirebase(email);
    } else {
      setState(() => load = false);
      MyDialog().doubleDialog(context, 'ไม่พบเบอร์โทรศัพท์ในระบบ',
          'เบอร์โทรศัพท์ไม่ถูกต้องหรือท่านยังไม่ได้สมัครสมาชิก');
    }
  }

  Future authenFirebase(String email) async {
    String password = passwordController.text;
    await MyVariable.auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      MyVariable.login = true;
      MyVariable.indexPage = 0;
      MyVariable.role = await Provider.of<UserProvider>(context, listen: false)
          .getUserRoleWherePhone(phone: phoneController.text);
      MyVariable.userTokenId =
          await Provider.of<UserProvider>(context, listen: false)
              .getUserIdWherePhone(phone: phoneController.text);
      MyWidget().toast('ยินดีต้อนรับสู่ Application');
      load = false;
      Navigator.pushNamedAndRemoveUntil(
          context, RoutePage.routePageNavigation, (route) => false);
    }).catchError((e) {
      setState(() => load = false);
      MyDialog().singleDialog(context, MyFunction().authenAlert(e.code));
    });
  }
}
