import 'package:charoz/Utility/Constant/my_image.dart';
import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final formKey = GlobalKey<FormState>();
TextEditingController phoneController = TextEditingController();
TextEditingController firstnameController = TextEditingController();
TextEditingController lastnameController = TextEditingController();
MaskTextInputFormatter phoneFormat = MaskTextInputFormatter(mask: '##########');
String? serial;

class AddRider extends StatelessWidget {
  const AddRider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        appBar: ScreenWidget().appBarTheme('เพิ่มผู้ใช้งาน คนขับ'),
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
                          buildPhone(),
                          SizedBox(height: 3.h),
                          buildFirstName(),
                          SizedBox(height: 3.h),
                          buildLastName(),
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

  Widget buildImage() => Image.asset(MyImage.logo3, width: 40.w, height: 40.w);

  Widget buildPhone() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      width: 80.w,
      child: TextFormField(
        inputFormatters: [phoneFormat],
        style: MyStyle().normalBlack16(),
        keyboardType: TextInputType.phone,
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
        style: MyStyle().normalBlack16(),
        controller: firstnameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ชื่อจริง';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'ชื่อจริง :',
          errorStyle: MyStyle().normalRed14(),
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
        style: MyStyle().normalBlack16(),
        controller: lastnameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก นามสกุล';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'นามสกุล :',
          errorStyle: MyStyle().normalRed14(),
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

  Widget buildButton(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: MyStyle.bluePrimary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            EasyLoading.show(status: 'loading...');
            // processInsert(context);
          }
        },
        child: Text('สร้างบัญชีสำหรับคนขับ', style: MyStyle().normalWhite16()),
      ),
    );
  }

  // Future processInsert(BuildContext context) async {
  //   String email = 'rider-${phoneController.text}@email.com';
  //   String password = 'crzrd${phoneController.text.substring(6)}';
  //   await VariableGeneral.auth
  //       .createUserWithEmailAndPassword(email: email, password: password)
  //       .then((value) async {
  //     bool status = await UserCRUD().createUser(
  //       UserRequest(
  //         firstname: firstnameController.text,
  //         lastname: lastnameController.text,
  //         email: email,
  //         phone: phoneController.text,
  //         role: 2,
  //         status: true,
  //         tokenE: value.user!.uid,
  //         tokenP: '',
  //         tokenDevice: '',
  //         time: Timestamp.fromDate(DateTime.now()),
  //       ),
  //     );
  //     if (status) {
  //       await VariableGeneral.auth.signOut();
  //       EasyLoading.dismiss();
  //       Navigator.pop(context);
  //       MyFunction().toast('เพิ่มบัญชีสำหรับ คนขับ สำเร็จ');
  //     } else {
  //       EasyLoading.dismiss();
  //       MyDialog(context).addFailedDialog();
  //     }
  //   }).catchError((e) {
  //     EasyLoading.dismiss();
  //     MyDialog(context).singleDialog(MyFunction().authenAlert(e.code));
  //   });
  // }
}
