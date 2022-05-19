import 'package:charoz/Service/Api/user_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_dialog.dart';
import 'package:charoz/Utilty/Constant/my_function.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterPhone extends StatefulWidget {
  final String phone;
  final String tokenP;
  const RegisterPhone({Key? key, required this.phone, required this.tokenP})
      : super(key: key);

  @override
  State<RegisterPhone> createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  bool statusPassword1 = true;
  bool statusPassword2 = true;
  bool allow = false;
  DateTime? birth;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  bool duplicate = false;
  bool load = false;

  @override
  void initState() {
    super.initState();
    signOutPhone();
  }

  Future signOutPhone() async {
    await MyVariable.auth.signOut();
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
              MyWidget().backgroundTitle(),
              MyWidget().title('ข้อมูลผู้ใช้งาน'),
              backPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Positioned backPage(BuildContext context) {
    return Positioned(
      top: MyVariable.largeDevice ? 30 : 20,
      left: MyVariable.largeDevice ? 30 : 10,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
          size: 20.sp,
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
              if (load) return;
              setState(() => load = true);
              if (formKey.currentState!.validate()) {
                buildCheckRegister();
              } else {
                setState(() => load = false);
              }
            },
            child: load
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(color: Colors.white),
                      SizedBox(width: 2.w),
                      Text(
                        'Please Wait...',
                        style: MyStyle().boldWhite18(),
                      ),
                    ],
                  )
                : Text(
                    'สมัครสมาชิก',
                    style: MyStyle().boldWhite18(),
                  ),
          ),
        ),
      ],
    );
  }

  Future buildCheckRegister() async {
    bool status =
        await UserApi().checkUserWhereEmail(email: emailController.text);
    if (password1Controller.text != password2Controller.text) {
      setState(() => load = false);
      MyDialog().doubleDialog(
          context, 'รหัสผ่านไม่ตรงกัน', 'กรุณาใส่รหัสผ่านทั้ง 2 ช่องให้ตรงกัน');
    } else if (allow == false) {
      setState(() => load = false);
      MyDialog().doubleDialog(context, 'ยังไม่ได้ยอมรับข้อกำหนด',
          'กรุณายอมรับเงื่อนไขการให้บริการ');
    } else if (status == false) {
      setState(() => load = false);
      MyDialog().doubleDialog(
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
    String birth = birthController.text;
    String phone = widget.phone;
    String role = 'customer';
    String tokenP = widget.tokenP;
    await MyVariable.auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      String tokenE = value.user!.uid;
      bool status = await UserApi().register(
          firstname: firstname,
          lastname: lastname,
          birth: birth,
          email: email,
          phone: phone,
          role: role,
          tokenE: tokenE,
          tokenP: tokenP);
      if (status) {
        MyVariable.login = true;
        MyVariable.indexPage = 0;
        MyVariable.role = role;
        MyWidget().toast('ยินดีต้อนรับสู่ Application');
        load = false;
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routePageNavigation, (route) => false);
      }
    }).catchError((e) {
      setState(() => load = false);
      MyDialog().singleDialog(context, MyFunction().authenAlert(e.code));
    });
  }
}
