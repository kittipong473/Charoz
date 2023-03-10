import 'dart:io';

import 'package:charoz/Model/Data/user_model.dart';
import 'package:charoz/Model/Util/Constant/my_image.dart';
import 'package:charoz/Model/Util/Constant/my_style.dart';
import 'package:charoz/Model/Util/Variable/var_general.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditUser {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  MaskTextInputFormatter dateFormat =
      MaskTextInputFormatter(mask: '##-##-####');
  DateTime? birthValue;
  File? file;
  String? image;

  Future<dynamic> openModalEditUser(context, UserModel user) {
    firstnameController.text = user.firstname!;
    lastnameController.text = user.lastname!;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => modalEditUser(user.id!));
  }

  Widget modalEditUser(String id) {
    return SizedBox(
      width: 100.w,
      height: 65.h,
      child: StatefulBuilder(
        builder: (context, setState) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: VariableGeneral.largeDevice
                        ? EdgeInsets.symmetric(horizontal: 10.w)
                        : EdgeInsets.symmetric(horizontal: 5.w),
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
                          SizedBox(height: 5.h),
                          buildButton(context, id),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ScreenWidget().buildModalHeader('แก้ไขข้อมูลผู้ใช้งาน'),
              ScreenWidget().backPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(Function setState) {
    return SizedBox(
      width: 30.w,
      height: 30.w,
      child: Image.asset(MyImage.person),
    );
    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     IconButton(
    //       onPressed: () async {
    //         file = await MyFunction().chooseImage(ImageSource.camera);
    //         setState(() {});
    //       },
    //       icon: const Icon(Icons.add_a_photo, size: 36, color: MyStyle.dark),
    //     ),
    //     SizedBox(
    //       width: 30.w,
    //       height: 30.w,
    //       child: file == null
    //           ? image == ''
    //               ? Image.asset(MyImage.person, width: 30.w, height: 30.w)
    //               : ShowImage().showImage(image!)
    //           : Image.file(file!, width: 30.w, height: 30.w),
    //     ),
    //     IconButton(
    //       onPressed: () async {
    //         file = await MyFunction().chooseImage(ImageSource.gallery);
    //         setState(() {});
    //       },
    //       icon: const Icon(Icons.add_photo_alternate,
    //           size: 36, color: MyStyle.dark),
    //     ),
    //   ],
    // );
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

  Widget buildButton(BuildContext context, String id) {
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

  Future processUpdate(BuildContext context, String id) async {
    // String chooseImage = await UserApi().saveUserImage(image!, file);

    // bool status = await UserApi().editUserWhereId(
    //   id: id,
    //   firstname: firstnameController.text,
    //   lastname: lastnameController.text,
    //   birth: birthValue!,
    //   image: chooseImage,
    //   time: DateTime.now(),
    // );

    // if (status) {
    //   Provider.of<UserProvider>(context, listen: false).getUserWhereToken();
    //   MyFunction().toast('แก้ไขข้อมูลเรียบร้อยแล้ว');
    //   Navigator.pop(context);
    // } else {
    //   DialogAlert().editFailedDialog(context);
    // }
  }
}
