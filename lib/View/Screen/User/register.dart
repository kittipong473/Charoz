import 'package:charoz/Model/Api/Modify/user_modify.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Firebase/user_crud.dart';
import 'package:charoz/Service/Routes/route_page.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
bool allow = false;

final UserViewModel userVM = Get.find<UserViewModel>();

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        appBar: MyWidget().appBarTheme(title: 'สมัครสมาชิก'),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyWidget().buildLogoImage(),
                    SizedBox(height: 5.h),
                    buildPhone(),
                    SizedBox(height: 3.h),
                    buildEmail(),
                    SizedBox(height: 3.h),
                    buildFirstName(),
                    SizedBox(height: 3.h),
                    buildLastName(),
                    SizedBox(height: 1.h),
                    buildPolicy(context),
                    buildCheck(context),
                    SizedBox(height: 3.h),
                    MyWidget().buttonWidget(
                      title: 'สมัครสมาชิก',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          validateInformation(context);
                        }
                      },
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
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
        readOnly: true,
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        initialValue: userVM.phoneNumber,
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'เบอร์โทร :',
          prefixIcon:
              const Icon(Icons.phone_rounded, color: MyStyle.orangeDark),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeDark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeLight),
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
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: firstNameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ชื่อจริง';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'ชื่อจริง :',
          prefixIcon:
              const Icon(Icons.description_rounded, color: MyStyle.orangeDark),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeDark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeLight),
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
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: lastNameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก นามสกุล';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'นามสกุล :',
          prefixIcon:
              const Icon(Icons.description_rounded, color: MyStyle.orangeDark),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeDark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeLight),
            borderRadius: BorderRadius.circular(10),
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
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: emailController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก อีเมลล์';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'อีเมลล์ :',
          prefixIcon: const Icon(
            Icons.email_rounded,
            color: MyStyle.orangeDark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeDark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangeLight),
            borderRadius: BorderRadius.circular(10),
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
          onPressed: () => Get.toNamed(RoutePage.routePrivacyPolicy),
          child: Text(
            'ข้อกำหนดเงื่อนไขการใช้บริการ',
            style: MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary),
          ),
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
            activeColor: MyStyle.orangePrimary,
            onChanged: (check) => setState(() => allow = check!),
          ),
          Text(
            'ฉันยอมรับข้อกำหนด',
            style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          )
        ],
      ),
    );
  }

  Future validateInformation(BuildContext context) async {
    bool status1 = allow;
    bool? status2 =
        await UserCRUD().checkDuplicateEmail(email: emailController.text);
    if (!status1) {
      DialogAlert(context).dialogStatus(
          type: 1, title: 'กรุณายอมรับข้อกำหนด เมื่อทำการสมัครเป็นสมาชิก');
    } else if (status2 != null && status2) {
      DialogAlert(context).dialogStatus(type: 1, title: 'อีเมลล์ถูกใช้งานแล้ว');
    } else {
      processRegister(context);
    }
  }

  Future processRegister(BuildContext context) async {
    bool status = await UserCRUD().createUser(
      model: UserModify(
        firstname: firstNameController.text,
        lastname: lastNameController.text,
        email: emailController.text,
        phone: userVM.phoneNumber,
        role: 1,
        status: true,
        token: null,
        create: Timestamp.fromDate(DateTime.now()),
        update: Timestamp.fromDate(DateTime.now()),
      ),
    );
    if (status) {
      bool statusUser = await userVM.checkPhoneAndGetUser();
      if (statusUser) {
        userVM.setLoginVariable();
      } else {
        DialogAlert(context).dialogStatus(
          type: 2,
          title: 'ไม่สามารถ เรียกข้อมูล ผู้ใช้งานได้',
          body: 'กรุณาลองใหม่อีกครั้งในภายหลัง',
        );
      }
    } else {
      DialogAlert(context).dialogStatus(
        type: 2,
        title: 'ไม่สามารถ เพิ่มข้อมูล ผู้ใช้งานได้',
        body: 'กรุณาลองใหม่อีกครั้งในภายหลัง',
      );
    }
  }

  // Future processRegister(BuildContext context) async {
  //   await VariableGeneral.auth
  //       .createUserWithEmailAndPassword(
  //           email: emailController.text,
  //           password: MyFunction().encryption(userVM.phoneNumber))
  //       .then((value) async {
  //     FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  //     String? token = await firebaseMessaging.getToken();
  //     bool status = await UserCRUD().createUser(
  //       UserRequest(
  //         firstname: firstNameController.text,
  //         lastname: lastNameController.text,
  //         email: emailController.text,
  //         phone: userVM.phoneNumber,
  //         role: 1,
  //         status: true,
  //         tokenE: value.user!.uid,
  //         tokenP: '',
  //         tokenDevice: token ?? '',
  //         time: Timestamp.fromDate(DateTime.now()),
  //       ),
  //     );
  //     if (status) {
  //       bool statusUser = await userVM.checkPhoneAndGetUser();
  //       if (statusUser) {
  //         userVM.setLoginVariable();
  //       } else {
  //         MyDialog(context).doubleDialog('ไม่สามารถดึงข้อมูลผู้ใช้งานได้',
  //             'กรุณาลองใหม่อีกครั้งในภายหลัง');
  //       }
  //     } else {
  //       EasyLoading.dismiss();
  //       MyDialog(context).addFailedDialog();
  //     }
  //   }).catchError((e) {
  //     EasyLoading.dismiss();
  //     MyDialog(context).singleDialog(MyFunction().authenAlert(e.code));
  //   });
  //   capi.loadingPage(false);
  // }
}
