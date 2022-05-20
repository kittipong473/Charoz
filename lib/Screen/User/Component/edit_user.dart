import 'package:charoz/Screen/User/Model/user_model.dart';
import 'package:charoz/Screen/User/Provider/user_provider.dart';
import 'package:charoz/Service/Api/user_api.dart';
import 'package:charoz/Utilty/Constant/my_dialog.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditUser extends StatefulWidget {
  final UserModel user;
  const EditUser({Key? key, required this.user}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  DateTime? birth;

  @override
  void initState() {
    super.initState();
    firstnameController.text = widget.user.userFirstName;
    lastnameController.text = widget.user.userLastName;
    birthController.text = widget.user.userBirth;
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
                          buildImage(),
                          SizedBox(height: 3.h),
                          buildFirstName(),
                          SizedBox(height: 3.h),
                          buildLastName(),
                          SizedBox(height: 3.h),
                          buildBirth(),
                          SizedBox(height: 5.h),
                          buildButton(context),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              MyWidget().backgroundTitle(),
              MyWidget().title('แก้ไขข้อมูลผู้ใช้งาน'),
              MyWidget().backPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          MyImage.person,
          width: 30.w,
          height: 30.w,
        ),
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
            controller: firstnameController,
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
            controller: lastnameController,
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
              hintText: 'วัน-เดือน-ปี พ.ศ.',
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

  Row buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 85.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.blue),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                processUpdate();
              }
            },
            child: Text(
              'แก้ไขข้อมูล',
              style: MyStyle().boldWhite18(),
            ),
          ),
        ),
      ],
    );
  }

  Future processUpdate() async {
    String id = widget.user.userId;
    String firstname = firstnameController.text;
    String lastname = lastnameController.text;
    String birth = birthController.text;
    String time = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

    bool status = await UserApi().editUserWhereId(
      id: id,
      firstname: firstname,
      lastname: lastname,
      birth: birth,
      time: time,
    );

    if (status) {
      Provider.of<UserProvider>(context, listen: false).getUserWhereToken();
      MyWidget().toast('แก้ไขข้อมูลเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      MyDialog().doubleDialog(
          context, 'แก้ไขข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
