import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final formKey = GlobalKey<FormState>();
TextEditingController phoneController = TextEditingController();
MaskTextInputFormatter phoneFormat = MaskTextInputFormatter(mask: '##########');
String? serial;

class AddRider extends StatelessWidget {
  const AddRider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
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

  Widget buildButton(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () {},
        child: Text('สร้าง Serial Number', style: MyStyle().normalWhite16()),
      ),
    );
  }
}
