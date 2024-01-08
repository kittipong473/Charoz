import 'dart:io';

import 'package:charoz/Model/Api/Modify/noti_modify.dart';
import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Firebase/noti_crud.dart';
import 'package:charoz/Service/Library/console_log.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/noti_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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

  final NotiViewModel notiVM = Get.find<NotiViewModel>();

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
              MyWidget().buildModalHeader(title: 'เพิ่มการแจ้งเตือน'),
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
        Text('ประเภท : ',
            style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
        Container(
          width: 50.w,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.orangePrimary),
          ),
          child: DropdownButton(
            iconSize: 24.sp,
            icon: const Icon(Icons.arrow_drop_down_outlined,
                color: MyStyle.orangePrimary),
            isExpanded: true,
            value: chooseType,
            items:
                notiVM.datatypeNotiType.map(MyWidget().dropdownItem).toList(),
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
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: nameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก หัวข้อ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'หัวข้อ :',
          prefixIcon: const Icon(
            Icons.description_rounded,
            color: MyStyle.orangeDark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangePrimary),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangePrimary),
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
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: detailController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก รายละเอียด';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'รายละเอียด :',
          prefixIcon: const Icon(
            Icons.details_rounded,
            color: MyStyle.orangeDark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangePrimary),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangePrimary),
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
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: startController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก เวลาเริ่ม';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'เวลาเริ่ม :',
          prefixIcon: const Icon(
            Icons.calendar_today_rounded,
            color: MyStyle.orangeDark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangePrimary),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangePrimary),
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
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: endController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก เวลาสิ้นสุด';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'เวลาสิ้นสุด :',
          prefixIcon: const Icon(
            Icons.calendar_today_rounded,
            color: MyStyle.orangeDark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangePrimary),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.orangePrimary),
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
              color: MyStyle.orangePrimary,
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
        Text('กลุ่มเป้าหมาย : ',
            style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
        Container(
          width: 50.w,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.orangePrimary),
          ),
          child: DropdownButton(
            iconSize: 24.sp,
            icon: const Icon(Icons.arrow_drop_down_outlined,
                color: MyStyle.orangePrimary),
            isExpanded: true,
            value: chooseRole,
            items:
                notiVM.notiRoleTargetList.map(MyWidget().dropdownItem).toList(),
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
            file = await MyFunction().chooseImage(source: ImageSource.camera);
            setState(() {});
          },
          icon: Icon(Icons.add_a_photo, size: 24.sp, color: MyStyle.orangeDark),
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
            file = await MyFunction().chooseImage(source: ImageSource.gallery);
            setState(() {});
          },
          icon: Icon(Icons.add_photo_alternate,
              size: 24.sp, color: MyStyle.orangeDark),
        ),
      ],
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      width: 90.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: MyStyle.bluePrimary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            EasyLoading.show(status: 'loading...');
            processInsert(context);
          } else if (chooseType == null) {
            DialogAlert(context)
                .dialogStatus(type: 1, title: 'กรุณาเลือก หัวข้อ');
          } else if (chooseRole == null) {
            DialogAlert(context)
                .dialogStatus(type: 1, title: 'กรุณาเลือก กลุ่มเป้าหมาย');
          }
        },
        child: Text('เพิ่มการแจ้งเตือน',
            style: MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)),
      ),
    );
  }

  Future processInsert(BuildContext context) async {
    bool status = await NotiCRUD().createNoti(
      model: NotiModify(
        type: notiVM.notiRoleTargetList.indexOf(chooseType!),
        name: nameController.text,
        detail: detailController.text,
        receive: notiVM.notiRoleTargetList.indexOf(chooseRole!),
        status: true,
        time: Timestamp.fromDate(DateTime.now()),
      ),
    );

    if (status) {
      notiVM.readNotiList();
      EasyLoading.dismiss();
      ConsoleLog.toast(text: 'เพิ่มการแจ้งเตือนเรียบร้อย');
      Get.back();
    } else {
      EasyLoading.dismiss();
      DialogAlert(context).dialogApi();
    }
  }
}
