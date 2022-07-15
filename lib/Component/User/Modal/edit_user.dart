import 'dart:io';

import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Api/PHP/user_api.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditUser {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  MaskTextInputFormatter dateFormat =
      MaskTextInputFormatter(mask: '##-##-####');
  DateTime? birthValue;
  File? file;
  String? image;

  Future<dynamic> openModalEditUser(context, UserModel user) {
    firstnameController.text = user.userFirstName;
    lastnameController.text = user.userLastName;
    birthController.text = DateFormat('dd-MM-yyyy').format(user.userBirth);
    image = user.userImage;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => modalEditUser(user.userId));
  }

  Widget modalEditUser(int id) {
    return SizedBox(
      width: 100.w,
      height: 90.h,
      child: StatefulBuilder(
        builder: (context, setState) => GestureDetector(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10.h),
                          buildImage(setState),
                          SizedBox(height: 5.h),
                          buildFirstName(),
                          SizedBox(height: 3.h),
                          buildLastName(),
                          SizedBox(height: 3.h),
                          buildBirth(context, setState),
                          SizedBox(height: 5.h),
                          buildButton(context, id),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ScreenWidget().modalTitle('แก้ไขข้อมูลผู้ใช้งาน'),
              ScreenWidget().backPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(Function setState) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () async {
            file = await MyFunction().chooseImage(ImageSource.camera);
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
                  : ShowImage().showUser(image!)
              : Image.file(file!, width: 30.w, height: 30.w),
        ),
        IconButton(
          onPressed: () async {
            file = await MyFunction().chooseImage(ImageSource.gallery);
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

  Widget buildBirth(BuildContext context, Function setState) {
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

  Widget buildButton(BuildContext context, int id) {
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
                processUpdate(context, id);
              }
            },
            child: Text('แก้ไขข้อมูล', style: MyStyle().normalWhite16()),
          ),
        ),
      ],
    );
  }

  Future processUpdate(BuildContext context, int id) async {
    String chooseImage = await UserApi().saveUserImage(image!, file);

    bool status = await UserApi().editUserWhereId(
      id: id,
      firstname: firstnameController.text,
      lastname: lastnameController.text,
      birth: birthValue!,
      image: chooseImage,
      time: DateTime.now(),
    );

    if (status) {
      Provider.of<UserProvider>(context, listen: false).getUserWhereToken();
      MyFunction().toast('แก้ไขข้อมูลเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      DialogAlert().editFailedDialog(context);
    }
  }
}
