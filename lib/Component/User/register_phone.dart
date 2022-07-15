import 'package:charoz/Service/Api/PHP/user_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterPhone extends StatefulWidget {
  final String phone;
  final String token;
  const RegisterPhone({Key? key, required this.phone, required this.token})
      : super(key: key);

  @override
  State<RegisterPhone> createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  bool statusPassword1 = true;
  bool statusPassword2 = true;
  bool allow = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  DateTime? birthValue;
  bool duplicate = false;

  @override
  void initState() {
    super.initState();
    signOutPhone();
  }

  Future signOutPhone() async {
    await GlobalVariable.auth.signOut();
  }

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
                    padding: GlobalVariable.largeDevice
                        ? const EdgeInsets.symmetric(horizontal: 40)
                        : const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          ScreenWidget().buildTitle('ข้อมูลทั่วไป'),
                          SizedBox(height: 3.h),
                          buildPhone(),
                          SizedBox(height: 3.h),
                          buildFirstName(),
                          SizedBox(height: 3.h),
                          buildLastName(),
                          SizedBox(height: 3.h),
                          buildEmail(),
                          SizedBox(height: 2.h),
                          buildBirth(),
                          SizedBox(height: 3.h),
                          buildPassword1(),
                          SizedBox(height: 3.h),
                          buildPassword2(),
                          SizedBox(height: 2.h),
                          buildPolicy(context),
                          buildCheck(context),
                          SizedBox(height: 3.h),
                          buildButton(context),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ScreenWidget().appBarTitle('ข้อมูลผู้ใช้งาน'),
              ScreenWidget().backPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Row buildPhone() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('เบอร์โทรศัพท์ :', style: MyStyle().boldBlack16()),
        SizedBox(width: 5.w),
        Text(widget.phone, style: MyStyle().boldBlack18()),
      ],
    );
  }

  Row buildFirstName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
          child: TextFormField(
            style: MyStyle().normalBlack16(),
            controller: firstNameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ชื่อจริง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'ชื่อ :',
              prefixIcon: const Icon(
                Icons.description_rounded,
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

  Row buildLastName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
          child: TextFormField(
            style: MyStyle().normalBlack16(),
            controller: lastNameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก นามสกุล';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'นามสกุล :',
              prefixIcon: const Icon(
                Icons.description_rounded,
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

  Row buildBirth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
          child: TextFormField(
            style: MyStyle().normalBlack16(),
            controller: birthController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก วันเดือนปีเกิด';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'วันเดือนปีเกิด :',
              hintText: 'วัน-เดือน-ปี ค.ศ.',
              hintStyle: MyStyle().normalGrey14(),
              prefixIcon: const Icon(
                Icons.schedule_rounded,
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
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 100),
                    lastDate: DateTime(DateTime.now().year + 1),
                  ).then((value) {
                    setState(() {
                      birthValue = value;
                      birthController.text =
                          DateFormat('dd MM yy').format(birthValue!);
                    });
                  });
                },
                icon: const Icon(
                  Icons.calendar_today_rounded,
                  color: MyStyle.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildEmail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: MyStyle().normalBlack16(),
            controller: emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก อีเมลล์';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'อีเมลล์ :',
              prefixIcon: const Icon(
                Icons.email_rounded,
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

  Row buildPassword1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
          child: TextFormField(
            style: MyStyle().normalBlack16(),
            obscureText: statusPassword1,
            enableSuggestions: false,
            autocorrect: false,
            controller: password1Controller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก รหัสผ่าน';
              } else if (value.length < 6 || value.length > 20) {
                return 'Password ต้องมีตัวอักษร 6-20 ตัว';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'รหัสผ่าน :',
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
                    statusPassword1 = !statusPassword1;
                  });
                },
                icon: statusPassword1
                    ? Icon(
                        Icons.visibility_rounded,
                        size: GlobalVariable.largeDevice ? 35 : 25,
                        color: MyStyle.primary,
                      )
                    : Icon(
                        Icons.visibility_off_rounded,
                        size: GlobalVariable.largeDevice ? 35 : 25,
                        color: MyStyle.primary,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPassword2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
          child: TextFormField(
            style: MyStyle().normalBlack16(),
            obscureText: statusPassword2,
            enableSuggestions: false,
            autocorrect: false,
            controller: password2Controller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ยืนยันรหัสผ่าน';
              } else if (value.length < 6 || value.length > 20) {
                return 'Password ต้องมีตัวอักษร 6-20 ตัว';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'ยืนยันรหัสผ่าน :',
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
                    statusPassword2 = !statusPassword2;
                  });
                },
                icon: statusPassword2
                    ? Icon(
                        Icons.visibility_rounded,
                        size: 20.sp,
                        color: MyStyle.primary,
                      )
                    : Icon(
                        Icons.visibility_off_rounded,
                        size: 20.sp,
                        color: MyStyle.primary,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPolicy(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            'ข้อกำหนดเงื่อนไข',
            style: MyStyle().boldPrimary16(),
          ),
        ),
        Text(
          ' และ ',
          style: MyStyle().normalBlack16(),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'นโยบายความเป็นส่วนตัว',
            style: MyStyle().boldPrimary16(),
          ),
        ),
      ],
    );
  }

  Row buildCheck(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: allow,
          activeColor: MyStyle.primary,
          onChanged: (check) {
            setState(() {
              allow = check!;
            });
          },
        ),
        Text(
          'ฉันยอมรับข้อกำหนด',
          style: MyStyle().normalBlack16(),
        )
      ],
    );
  }

  Row buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 85.w,
          height: GlobalVariable.largeDevice ? 60 : 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
            onPressed: () {
              EasyLoading.show(status: 'loading...');
              if (formKey.currentState!.validate()) {
                buildCheckRegister();
              }
            },
            child: Text('สมัครสมาชิก', style: MyStyle().boldWhite18()),
          ),
        ),
      ],
    );
  }

  Future buildCheckRegister() async {
    bool status =
        await UserApi().checkUserWhereEmail(email: emailController.text);
    if (password1Controller.text != password2Controller.text) {
      EasyLoading.dismiss();
      DialogAlert().doubleDialog(
          context, 'รหัสผ่านไม่ตรงกัน', 'กรุณาใส่รหัสผ่านทั้ง 2 ช่องให้ตรงกัน');
    } else if (allow == false) {
      EasyLoading.dismiss();
      DialogAlert().doubleDialog(context, 'ยังไม่ได้ยอมรับข้อกำหนด',
          'กรุณายอมรับเงื่อนไขการให้บริการ');
    } else if (status == false) {
      EasyLoading.dismiss();
      DialogAlert().doubleDialog(
          context, 'อีเมลล์ถูกใช้งานแล้ว', 'กรุณาใช้อีเมลล์อื่นในการสมัคร');
    } else {
      registerFirebase();
    }
  }

  Future registerFirebase() async {
    String email = emailController.text;
    String password = password1Controller.text;
    String firstname = firstNameController.text;
    String lastname = lastNameController.text;
    String phone = widget.phone;
    String role = 'customer';
    String tokenP = widget.token;
    await GlobalVariable.auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      String token = value.user!.uid;
      bool status = await UserApi().insertUser(
        firstname: firstname,
        lastname: lastname,
        birth: birthValue!,
        email: email,
        phone: phone,
        role: 'customer',
        token: token,
      );
      if (status) {
        await GlobalVariable.auth.signOut();
        EasyLoading.dismiss();
        MyFunction()
            .toast('สมัครสมาชิกสำเร็จ สามารถ Login เข้าใช้งานระบบได้เลย');
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routePageNavigation, (route) => false);
      } else {
        DialogAlert().addFailedDialog(context);
      }
    }).catchError((e) {
      EasyLoading.dismiss();
      DialogAlert().singleDialog(context, MyFunction().authenAlert(e.code));
    });
  }
}
