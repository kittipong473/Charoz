import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Api/PHP/user_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final formKey = GlobalKey<FormState>();
TextEditingController phoneController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController password1Controller = TextEditingController();
TextEditingController password2Controller = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController birthController = TextEditingController();
MaskTextInputFormatter phoneFormat = MaskTextInputFormatter(mask: '##########');
MaskTextInputFormatter dateFormat = MaskTextInputFormatter(mask: '####-##-##');
DateTime? birthValue;
bool statusPassword1 = true;
bool statusPassword2 = true;
bool allow = false;

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

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
                          ScreenWidget().buildTitle('ข้อมูลทั่วไป'),
                          SizedBox(height: 3.h),
                          buildPhone(),
                          SizedBox(height: 3.h),
                          buildFirstName(),
                          SizedBox(height: 3.h),
                          buildLastName(),
                          SizedBox(height: 3.h),
                          buildEmail(),
                          SizedBox(height: 3.h),
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
                          SizedBox(height: 1.h),
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

  Widget buildPhone() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 80.w,
      child: TextFormField(
        keyboardType: TextInputType.phone,
        inputFormatters: [phoneFormat],
        style: MyStyle().normalBlack16(),
        controller: phoneController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก เบอร์โทรศัพท์';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().boldBlack16(),
          labelText: 'เบอร์โทร :',
          prefixIcon: const Icon(Icons.phone_rounded, color: MyStyle.dark),
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

  Widget buildFirstName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 80.w,
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
          labelText: 'ชื่อจริง :',
          prefixIcon:
              const Icon(Icons.description_rounded, color: MyStyle.dark),
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

  Widget buildLastName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 80.w,
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
          prefixIcon:
              const Icon(Icons.description_rounded, color: MyStyle.dark),
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

  Widget buildBirth() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 80.w,
      child: StatefulBuilder(
        builder: (context, setState) => TextFormField(
          style: MyStyle().normalBlack16(),
          inputFormatters: [dateFormat],
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
            hintText: '2022-12-31 (ปี ค.ศ.)',
            hintStyle: MyStyle().normalGrey14(),
            prefixIcon: const Icon(Icons.schedule_rounded, color: MyStyle.dark),
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
                        DateFormat('yyyy-MM-dd').format(birthValue!);
                  });
                });
              },
              icon: Icon(
                Icons.calendar_today_rounded,
                color: MyStyle.primary,
                size: 20.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 80.w,
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
    );
  }

  Widget buildPassword1() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 80.w,
      child: StatefulBuilder(
        builder: (context, setState) => TextFormField(
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
              onPressed: () =>
                  setState(() => statusPassword1 = !statusPassword1),
              icon: statusPassword1
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
    );
  }

  Widget buildPassword2() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 80.w,
      child: StatefulBuilder(
        builder: (context, setState) => TextFormField(
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
              onPressed: () =>
                  setState(() => statusPassword2 = !statusPassword2),
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
    );
  }

  Widget buildPolicy(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, RoutePage.routeTermOfService),
          child: Text('ข้อกำหนดเงื่อนไขการใช้บริการ',
              style: MyStyle().boldPrimary14()),
        ),
        Text(' และ ', style: MyStyle().normalBlack14()),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, RoutePage.routePrivacyPolicy),
          child:
              Text('นโยบายความเป็นส่วนตัว', style: MyStyle().boldPrimary14()),
        ),
      ],
    );
  }

  Widget buildCheck(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: allow,
            activeColor: MyStyle.primary,
            onChanged: (check) => setState(() => allow = check!),
          ),
          Text('ฉันยอมรับข้อกำหนด', style: MyStyle().normalBlack16())
        ],
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
          EasyLoading.show(status: 'loading...');
          if (formKey.currentState!.validate()) {
            validateInformation(context);
          }
        },
        child: Text('สมัครสมาชิก', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Future validateInformation(BuildContext context) async {
    bool status1 =
        password1Controller.text == password2Controller.text ? true : false;
    bool status2 = allow;
    bool status3 = await Provider.of<UserProvider>(context, listen: false)
        .checkPhone(phoneController.text);
    bool status4 = await Provider.of<UserProvider>(context, listen: false)
        .checkEmail(emailController.text);
    if (!status1) {
      EasyLoading.dismiss();
      DialogAlert().singleDialog(context, 'รหัสผ่านไม่ตรงกัน');
    } else if (status2) {
      EasyLoading.dismiss();
      DialogAlert().singleDialog(
          context, 'กรุณายอมรับข้อกำหนด เมื่อทำการสมัครเป็นสมาชิก');
    } else if (status3) {
      EasyLoading.dismiss();
      DialogAlert().singleDialog(context, 'เบอร์โทรศัพท์ถูกใช้งานแล้ว');
    } else if (status4) {
      EasyLoading.dismiss();
      DialogAlert().singleDialog(context, 'อีเมลล์ถูกใช้งานแล้ว');
    } else {
      processRegister(context);
    }
  }

  Future processRegister(BuildContext context) async {
    await GlobalVariable.auth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: password1Controller.text)
        .then((value) async {
      bool status = await UserApi().insertUser(
        firstname: firstNameController.text,
        lastname: lastNameController.text,
        birth: DateTime.parse(birthController.text),
        email: emailController.text,
        phone: phoneController.text,
        role: 'customer',
        token: value.user!.uid,
      );
      if (status) {
        await GlobalVariable.auth.signOut();
        EasyLoading.dismiss();
        Navigator.pop(context);
        MyFunction()
            .toast('สมัครสมาชิกสำเร็จ สามารถ Login เข้าใช้งานระบบได้เลย');
      } else {
        DialogAlert().addFailedDialog(context);
      }
    }).catchError((e) {
      EasyLoading.dismiss();
      DialogAlert().singleDialog(context, MyFunction().authenAlert(e.code));
    });
  }
}
