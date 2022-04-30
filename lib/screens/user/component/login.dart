import 'package:charoz/screens/user/provider/user_provider.dart';
import 'package:charoz/services/route/route_page.dart';
import 'package:charoz/utils/constant/my_dialog.dart';
import 'package:charoz/utils/constant/my_image.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                          MyWidget().buildTitle(title: 'เข้าสู่ระบบ'),
                          SizedBox(height: 3.h),
                          buildPhone(),
                          SizedBox(height: 3.h),
                          buildPassword(),
                          SizedBox(height: 5.h),
                          // buildDetail(),
                          buildButton(context),
                          SizedBox(height: 3.h),
                          buildRegister(),
                          SizedBox(height: 1.h),
                          buildAbout(),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              MyWidget().backgroundTitle(),
              MyWidget().title('บัญชีผู้ใช้งาน'),
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

  Row buildPhone() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
          child: TextFormField(
            style: MyStyle().normalBlack16(),
            keyboardType: TextInputType.phone,
            controller: phoneController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Phone Number';
              } else if (value.length != 10) {
                return 'กรุณากรอกหมายเลขโทรศัพท์ให้ถูกต้อง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().normalBlack16(),
              labelText: 'หมายเลขโทรศัพท์ :',
              errorStyle: MyStyle().normalRed14(),
              prefixIcon: const Icon(
                Icons.phone,
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
              } else if (value.length < 5 || value.length > 20) {
                return 'Password ต้องมีตัวอักษร 5-20 ตัว';
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

  Row buildDetail() {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: rememberPassword,
              activeColor: MyStyle.primary,
              onChanged: (check) {
                setState(() {
                  rememberPassword = check!;
                });
              },
            ),
            Row(
              children: [
                Text(
                  'จำรหัสผ่าน',
                  style: MyStyle().normalBlack16(),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                //Navigator.pushNamed(context, RoutePage.routeForgetPassword);
              },
              child: Text(
                'ลืมรหัสผ่าน',
                style: MyStyle().boldPrimary16(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row buildRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ยังไม่เป็นสมาชิก ? ',
          style: MyStyle().normalBlack16(),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutePage.routeRegister);
          },
          child: Text(
            'สมัครสมาชิก',
            style: MyStyle().boldPrimary16(),
          ),
        )
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
                processLogin();
              } else {
                setState(() => load = false);
              }
            },
            child: load
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(color: Colors.white),
                      const SizedBox(width: 20),
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

  Widget buildAbout() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RoutePage.routeAbout),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(MyImage.gifTap, width: 50, height: 50),
          Text(
            'คำถามที่เกี่ยวข้อง ?',
            style: MyStyle().boldPrimary18(),
          ),
          Lottie.asset(MyImage.gifTap, width: 50, height: 50),
        ],
      ),
    );
  }

  Future processLogin() async {
    String phone = phoneController.text;
    String password = Provider.of<UserProvider>(context, listen: false)
        .encryption(text: passwordController.text);
    bool status1 = await Provider.of<UserProvider>(context, listen: false)
        .loginUser(phone: phone, password: password);
    if (status1) {
      bool status2 =
          await Provider.of<UserProvider>(context, listen: false).checkStatus();
      if (status2) {
        Provider.of<UserProvider>(context, listen: false)
            .getUserWhereIdPreference();
        MyVariable.login = true;
        MyVariable.indexPage = 0;
        MyWidget().toast('ยินดีต้อนรับสู่ Application');
        load = false;
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routeHomeService, (route) => false);
      } else {
        MyDialog().doubleDialog(context, 'บัญชีนี้ถูกระงับการใช้งาน',
            'โปรดติดต่อ Admin เพื่อสอบถามเพิ่มเติม');
        setState(() => load = false);
      }
    } else {
      MyDialog().doubleDialog(context, 'เบอร์โทรศัพท์หรือรหัสผ่านไม่ถูกต้อง',
          'กรุณาลองใหม่อีกครั้ง');
      setState(() => load = false);
    }
  }
}
