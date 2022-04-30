import 'package:charoz/screens/user/provider/user_provider.dart';
import 'package:charoz/services/api/user_api.dart';
import 'package:charoz/utils/constant/my_dialog.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool statusPassword1 = true;
  bool statusPassword2 = true;
  bool allow = false;
  DateTime? birth;
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  bool duplicate = false;

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
                          MyWidget().buildTitle(title: 'ข้อมูลทั่วไป'),
                          SizedBox(height: 3.h),
                          buildFirstName(),
                          SizedBox(height: 3.h),
                          buildLastName(),
                          SizedBox(height: 3.h),
                          // buildEmail(),
                          // SizedBox(height: 2.h),
                          buildPhone(),
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
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              MyWidget().backgroundTitle(),
              MyWidget().title('สมัครสมาชิก'),
              MyWidget().backPage(context),
            ],
          ),
        ),
      ),
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
                      birth = value;
                      birthController.text =
                          DateFormat('dd-MM-yyyy').format(birth!);
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
                return 'กรุณากรอก หมายเลขโทรศัพท์';
              } else if (value.length != 10) {
                return 'กรุณากรอกหมายเลขโทรศัพท์ให้ถูกต้อง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'หมายเลขโทรศัพท์ :',
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
              } else if (value.length < 5 || value.length > 20) {
                return 'Password ต้องมีตัวอักษร 5-20 ตัว';
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

  Row buildPassword2() {
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
              } else if (value.length < 5 || value.length > 20) {
                return 'Password ต้องมีตัวอักษร 5-20 ตัว';
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
          height: MyVariable.largeDevice ? 60 : 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.blue),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                buildCheckRegister();
              }
            },
            child: Text(
              'สมัครสมาชิก',
              style: MyStyle().boldWhite18(),
            ),
          ),
        ),
      ],
    );
  }

  Future buildCheckRegister() async {
    bool status = await Provider.of<UserProvider>(context, listen: false)
        .checkUserWherePhone(phoneController.text);
    if (password1Controller.text != password2Controller.text) {
      MyDialog().doubleDialog(
          context, 'รหัสผ่านไม่ตรงกัน', 'กรุณาใส่รหัสผ่านทั้ง 2 ช่องให้ตรงกัน');
    } else if (allow == false) {
      MyDialog().doubleDialog(context, 'ยังไม่ได้ยอมรับข้อกำหนด',
          'กรุณายอมรับเงื่อนไขการให้บริการ');
    } else if (status == false) {
      MyDialog().doubleDialog(context, 'หมายเลขโทรศัพท์ถูกใช้งานแล้ว',
          'กรุณาเปลี่ยนหมายเลขโทรศัพท์อื่น');
    } else {
      processRegister();
    }
  }

  Future processRegister() async {
    String firstname = firstNameController.text;
    String lastname = lastNameController.text;
    String birth = birthController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String password = Provider.of<UserProvider>(context, listen: false)
        .encryption(text: password1Controller.text);
    String time = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    bool status = await UserApi().registerUser(
        firstname: firstname,
        lastname: lastname,
        birth: birth,
        email: email,
        phone: phone,
        password: password,
        create: time,
        update: time);

    if (status == true) {
      Navigator.pop(context);
      MyWidget().toast('สมัครสมาชิกสำเร็จ\nกรุณาเข้าสู่ระบบเพื่อเข้าใช้งาน');
    } else {
      MyDialog()
          .doubleDialog(context, 'สมัครสมาชิกล้มเหลว', 'กรูณาลองใหม่อีกครั้ง');
    }
  }
}
