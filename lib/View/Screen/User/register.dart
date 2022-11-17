import 'package:charoz/Model/Api/Request/user_modify.dart';
import 'package:charoz/Model/Service/CRUD/api_controller.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/user_crud.dart';
import 'package:charoz/Model/Service/Route/route_page.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
bool allow = false;

final ApiController capi = Get.find<ApiController>();
final UserViewModel userVM = Get.find<UserViewModel>();

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        appBar: ScreenWidget().appBarTheme('สมัครสมาชิก'),
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ScreenWidget().buildLogoImage(),
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
                          buildButton(context),
                          SizedBox(height: 2.h),
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

  Widget buildPhone() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 80.w,
      child: TextFormField(
        readOnly: true,
        style: MyStyle().normalBlack16(),
        initialValue: userVM.phoneNumber,
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

  Widget buildPolicy(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, RoutePage.routePrivacyPolicy),
          child: Text('ข้อกำหนดเงื่อนไขการใช้บริการ',
              style: MyStyle().boldPrimary16()),
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
        style: ElevatedButton.styleFrom(backgroundColor: MyStyle.bluePrimary),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            validateInformation(context);
          }
        },
        child: Text('สมัครสมาชิก', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Future validateInformation(BuildContext context) async {
    capi.loadingPage(true);
    bool status1 = allow;
    bool status2 = await UserCRUD().checkUserByEmail(emailController.text);
    if (!status1) {
      capi.loadingPage(false);
      MyDialog(context)
          .singleDialog('กรุณายอมรับข้อกำหนด เมื่อทำการสมัครเป็นสมาชิก');
    } else if (!status2) {
      capi.loadingPage(false);
      MyDialog(context).singleDialog('อีเมลล์ถูกใช้งานแล้ว');
    } else {
      processRegister(context);
    }
  }

  Future processRegister(BuildContext context) async {
    await VariableGeneral.auth
        .createUserWithEmailAndPassword(
            email: emailController.text,
            password: MyFunction().encryption(userVM.phoneNumber))
        .then((value) async {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? token = await firebaseMessaging.getToken();
      bool status = await UserCRUD().createUser(
        UserManage(
          firstname: firstNameController.text,
          lastname: lastNameController.text,
          email: emailController.text,
          phone: userVM.phoneNumber,
          image: '',
          role: 'customer',
          status: 1,
          tokenE: value.user!.uid,
          tokenP: '',
          tokenDevice: token ?? '',
          time: Timestamp.fromDate(DateTime.now()),
        ),
      );
      if (status) {
        bool statusUser = await userVM.checkPhoneAndGetUser();
        if (statusUser) {
          userVM.setLoginVariable();
        } else {
          MyDialog(context).doubleDialog('ไม่สามารถดึงข้อมูลผู้ใช้งานได้',
              'กรุณาลองใหม่อีกครั้งในภายหลัง');
        }
      } else {
        EasyLoading.dismiss();
        MyDialog(context).addFailedDialog();
      }
    }).catchError((e) {
      EasyLoading.dismiss();
      MyDialog(context).singleDialog(MyFunction().authenAlert(e.code));
    });
    capi.loadingPage(false);
  }
}
