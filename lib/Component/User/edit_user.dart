import 'dart:io';

import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Api/user_api.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/save_image_path.dart';
import 'package:charoz/Utilty/Function/show_toast.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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
  MaskTextInputFormatter dateFormat =
      MaskTextInputFormatter(mask: '##-##-####');
  DateTime? birthValue;
  File? file;
  String? image;

  @override
  void initState() {
    super.initState();
    firstnameController.text = widget.user.userFirstName;
    lastnameController.text = widget.user.userLastName;
    birthController.text =
        DateFormat('dd-MM-yyyy').format(widget.user.userBirth);
    image = widget.user.userImage;
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10.h),
                          buildImage(),
                          SizedBox(height: 5.h),
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
              ScreenWidget().appBarTitle('แก้ไขข้อมูลผู้ใช้งาน'),
              ScreenWidget().backPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () async {
            file = await SaveImagePath().chooseImage(ImageSource.camera);
            setState(() {});
          },
          icon: const Icon(Icons.add_a_photo, size: 36, color: MyStyle.dark),
        ),
        SizedBox(
          width: 30.w,
          height: 30.w,
          child: file == null
              ? image == 'null'
                  ? Image.asset(MyImage.person, width: 30.w, height: 30.w)
                  : ShowImage().userImage(image!)
              : Image.file(file!, width: 30.w, height: 30.w),
        ),
        IconButton(
          onPressed: () async {
            file = await SaveImagePath().chooseImage(ImageSource.gallery);
            setState(() {});
          },
          icon: const Icon(Icons.add_photo_alternate,
              size: 36, color: MyStyle.dark),
        ),
      ],
    );
  }

  Widget buildFirstName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
    );
  }

  Widget buildLastName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
    );
  }

  Widget buildBirth() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
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
          labelStyle: MyStyle().normalBlack16(),
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
                      DateFormat('dd-MM-yyyy').format(birthValue!);
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
    );
  }

  Widget buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                processUpdate();
              }
            },
            child: Text('แก้ไขข้อมูล', style: MyStyle().normalWhite16()),
          ),
        ),
      ],
    );
  }

  Future processUpdate() async {
    String chooseImage = await SaveImagePath().saveUserImage(image!, file);

    bool status = await UserApi().editUserWhereId(
      id: widget.user.userId,
      firstname: firstnameController.text,
      lastname: lastnameController.text,
      birth: birthValue!,
      image: chooseImage,
      time: DateTime.now(),
    );

    if (status) {
      Provider.of<UserProvider>(context, listen: false).getUserWhereToken();
      ShowToast().toast('แก้ไขข้อมูลเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      DialogAlert().doubleDialog(
          context, 'แก้ไขข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
