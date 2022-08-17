import 'dart:io';

import 'package:charoz/Model_Sub/noti_modify.dart';
import 'package:charoz/Provider/noti_provider.dart';
import 'package:charoz/Service/Database/Firebase/noti_crud.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Widget/dropdown_menu.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddNoti {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  MaskTextInputFormatter dateFormat =
      MaskTextInputFormatter(mask: '##-##-####');
  DateTime? startValue;
  DateTime? endValue;
  String? image;
  File? file;
  String? chooseType;
  String? chooseRole;

  Future<dynamic> openModalAdNoti(context) {
    startValue = DateTime.now();
    image = '';
    startController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => modalAddNoti());
  }

  Widget modalAddNoti() {
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
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10.h),
                          buildType(setState),
                          SizedBox(height: 3.h),
                          buildName(),
                          SizedBox(height: 3.h),
                          buildDetail(),
                          SizedBox(height: 3.h),
                          buildStart(),
                          SizedBox(height: 3.h),
                          buildEnd(context, setState),
                          SizedBox(height: 3.h),
                          buildUserId(setState),
                          SizedBox(height: 3.h),
                          buildImage(setState),
                          SizedBox(height: 3.h),
                          buildButton(context),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ScreenWidget().modalTitle('เพิ่มการแจ้งเตือน'),
              ScreenWidget().backPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildType(Function setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('ประเภท : ', style: MyStyle().normalBlack16()),
        Container(
          width: 50.w,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.primary),
          ),
          child: DropdownButton(
            iconSize: 24.sp,
            icon: const Icon(Icons.arrow_drop_down_outlined,
                color: MyStyle.primary),
            isExpanded: true,
            value: chooseType,
            items: MyVariable.notiTypeList
                .map(DropDownMenu().dropdownItem)
                .toList(),
            onChanged: (value) => setState(() => chooseType = value as String),
          ),
        ),
      ],
    );
  }

  Widget buildName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        style: MyStyle().normalBlack16(),
        controller: nameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก หัวข้อ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'หัวข้อ :',
          prefixIcon: const Icon(
            Icons.description_rounded,
            color: MyStyle.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.primary),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildDetail() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        maxLines: 5,
        style: MyStyle().normalBlack16(),
        controller: detailController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก รายละเอียด';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'รายละเอียด :',
          prefixIcon: const Icon(
            Icons.details_rounded,
            color: MyStyle.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.primary),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildStart() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [dateFormat],
        style: MyStyle().normalBlack16(),
        controller: startController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก เวลาเริ่ม';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'เวลาเริ่ม :',
          prefixIcon: const Icon(
            Icons.calendar_today_rounded,
            color: MyStyle.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.primary),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildEnd(BuildContext context, Function setState) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [dateFormat],
        style: MyStyle().normalBlack16(),
        controller: endController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก เวลาสิ้นสุด';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'เวลาสิ้นสุด :',
          prefixIcon: const Icon(
            Icons.calendar_today_rounded,
            color: MyStyle.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.primary),
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
                  endValue = value;
                  endController.text =
                      DateFormat('dd-MM-yyyy').format(endValue!);
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

  Widget buildUserId(Function setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('กลุ่มเป้าหมาย : ', style: MyStyle().normalBlack16()),
        Container(
          width: 50.w,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.primary),
          ),
          child: DropdownButton(
            iconSize: 24.sp,
            icon: const Icon(Icons.arrow_drop_down_outlined,
                color: MyStyle.primary),
            isExpanded: true,
            value: chooseRole,
            items: MyVariable.notiRoleTargetList
                .map(DropDownMenu().dropdownItem)
                .toList(),
            onChanged: (value) => setState(() => chooseRole = value as String),
          ),
        ),
      ],
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
          icon: Icon(Icons.add_a_photo, size: 24.sp, color: MyStyle.dark),
        ),
        SizedBox(
          width: 40.w,
          height: 40.w,
          child: file == null
              ? Image.asset(MyImage.image, fit: BoxFit.cover)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () async {
            file = await MyFunction().chooseImage(ImageSource.gallery);
            setState(() {});
          },
          icon:
              Icon(Icons.add_photo_alternate, size: 24.sp, color: MyStyle.dark),
        ),
      ],
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      width: 90.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            EasyLoading.show(status: 'loading...');
            processInsert(context);
          } else if (chooseType == null) {
            DialogAlert().singleDialog(context, 'กรุณาเลือก หัวข้อ');
          } else if (chooseRole == null) {
            DialogAlert().singleDialog(context, 'กรุณาเลือก กลุ่มเป้าหมาย');
          }
        },
        child: Text('เพิ่มการแจ้งเตือน', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Future processInsert(BuildContext context) async {
    String chooseImage =
        file != null ? await NotiCRUD().uploadImageNoti(file!) : '';
    String roleTarget = '';
    if (chooseRole == MyVariable.notiRoleTargetList[0]) {
      roleTarget = 'everyone';
    } else if (chooseRole == MyVariable.notiRoleTargetList[1]) {
      roleTarget = 'rider';
    } else if (chooseRole == MyVariable.notiRoleTargetList[2]) {
      roleTarget = 'customer';
    }
    bool status = await NotiCRUD().createNoti(
      NotiModify(
        userid: roleTarget,
        type: chooseType!,
        name: nameController.text,
        detail: detailController.text,
        image: chooseImage,
        start: Timestamp.fromDate(startValue!),
        end: Timestamp.fromDate(endValue!),
        status: 1,
      ),
    );

    if (status) {
      Provider.of<NotiProvider>(context, listen: false)
          .readNotiTypeList(MyVariable.notiTypeList[MyVariable.indexNotiChip]);
      EasyLoading.dismiss();
      MyFunction().toast('เพิ่มการแจ้งเตือนเรียบร้อย');
      Navigator.pop(context);
    } else {
      EasyLoading.dismiss();
      DialogAlert().addFailedDialog(context);
    }
  }
}
