import 'dart:io';

import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Service/Api/product_api.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/save_image_path.dart';
import 'package:charoz/Utilty/Function/show_toast.dart';
import 'package:charoz/Utilty/Widget/dropdown_menu.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductModal {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController scoreController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  MaskTextInputFormatter scoreFormat = MaskTextInputFormatter(mask: '#.#');
  bool suggest = false;
  String? image;
  File? file;
  String? chooseType;

  Future<dynamic> openModalAddProduct(context) => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => modalAddProduct(context));

  Widget modalAddProduct(BuildContext context) {
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
                top: 7.h,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildType(setState),
                          SizedBox(height: 3.h),
                          buildName(),
                          SizedBox(height: 3.h),
                          buildPrice(),
                          SizedBox(height: 3.h),
                          buildScore(),
                          SizedBox(height: 3.h),
                          buildDetail(),
                          SizedBox(height: 1.h),
                          buildImage(setState),
                          SizedBox(height: 1.h),
                          buildCheck(setState),
                          SizedBox(height: 3.h),
                          buildButton(context),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ScreenWidget().modalTitle('เพิ่มรายการอาหาร'),
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
          width: 40.w,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.primary),
          ),
          child: DropdownButton(
            iconSize: 24.sp,
            icon:
                const Icon(Icons.arrow_drop_down_outlined, color: MyStyle.dark),
            isExpanded: true,
            value: chooseType,
            items: MyVariable.productTypes
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
            return 'กรุณากรอก ชื่ออาหาร';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'ชื่ออาหาร :',
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

  Widget buildPrice() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        style: MyStyle().normalBlack16(),
        keyboardType: TextInputType.number,
        controller: priceController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ราคา';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'ราคา :',
          prefixIcon: const Icon(
            Icons.attach_money_rounded,
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

  Widget buildScore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        inputFormatters: [scoreFormat],
        style: MyStyle().normalBlack16(),
        keyboardType: TextInputType.number,
        controller: scoreController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก คะแนน';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'คะแนน :',
          hintText: 'X.X',
          hintStyle: MyStyle().normalGrey16(),
          prefixIcon: const Icon(
            Icons.score_rounded,
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

  Widget buildDetail() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        style: MyStyle().normalBlack16(),
        maxLines: 3,
        controller: detailController,
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'รายละเอียด : ',
          prefixIcon: const Icon(
            Icons.details_rounded,
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

  Widget buildImage(Function setState) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () async {
            file = await SaveImagePath().chooseImage(ImageSource.camera);
            setState(() {});
          },
          icon: Icon(Icons.add_a_photo, size: 24.sp, color: MyStyle.dark),
        ),
        SizedBox(
          width: 40.w,
          height: 40.w,
          child: file == null
              ? Image.asset(MyImage.image, fit: BoxFit.contain)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () async {
            file = await SaveImagePath().chooseImage(ImageSource.gallery);
            setState(() {});
          },
          icon:
              Icon(Icons.add_photo_alternate, size: 24.sp, color: MyStyle.dark),
        ),
      ],
    );
  }

  Widget buildCheck(Function setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: suggest,
          activeColor: MyStyle.primary,
          onChanged: (check) {
            setState(() => suggest = check!);
          },
        ),
        Text(
          'แนะนำรายการอาหารที่หน้าหลัก',
          style: MyStyle().normalBlack16(),
        )
      ],
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            EasyLoading.show(status: 'loading...');
            processInsert(context);
          } else if (chooseType == null) {
            DialogAlert().singleDialog(context, 'กรุณาเลือก ประเภท');
          }
        },
        child: Text('เพิ่มรายการอาหาร', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Future processInsert(BuildContext context) async {
    String chooseImage = await SaveImagePath().saveProductImage(image!, file);

    bool status = await ProductApi().insertProduct(
      name: nameController.text,
      type: chooseType!,
      price: double.parse(priceController.text),
      score: double.parse(scoreController.text),
      detail: detailController.text.isEmpty ? 'ไม่มี' : detailController.text,
      image: chooseImage,
      suggest: suggest ? 1 : 0,
      time: DateTime.now(),
    );

    if (status) {
      Provider.of<OrderProvider>(context, listen: false).getAllProductWhereType(
          MyVariable.productTypes[MyVariable.indexProductChip]);
      EasyLoading.dismiss();
      ShowToast().toast('เพิ่มรายการอาหารเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      EasyLoading.dismiss();
      DialogAlert().doubleDialog(
          context, 'เพิ่มข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
