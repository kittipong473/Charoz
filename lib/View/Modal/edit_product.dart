import 'dart:io';

import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/Model/Api/Modify/product_modify.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Firebase/product_crud.dart';
import 'package:charoz/Service/Library/console_log.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditProduct {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  bool suggest = false;
  String? image;
  File? file;
  String? chooseType;

  final ProductViewModel prodVM = Get.find<ProductViewModel>();

  Future<dynamic> openModalEditProduct(context, ProductModel product) {
    chooseType = product.type!.toString();
    nameController.text = product.name!;
    priceController.text = product.price.toString();
    detailController.text = product.detail!;
    image = product.image;
    suggest = product.suggest!;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => modalEditProduct(product.id!));
  }

  Widget modalEditProduct(String id) {
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
                        children: [
                          SizedBox(height: 10.h),
                          buildType(setState),
                          SizedBox(height: 3.h),
                          buildName(),
                          SizedBox(height: 3.h),
                          buildPrice(),
                          SizedBox(height: 3.h),
                          buildDetail(),
                          SizedBox(height: 4.h),
                          buildImage(setState),
                          SizedBox(height: 3.h),
                          buildCheck(setState),
                          SizedBox(height: 3.h),
                          buildButton(context, id),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              MyWidget().buildModalHeader(title: 'แก้ไขรายการอาหาร'),
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
        Text(
          'ประเภท : ',
          style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        ),
        Container(
          width: 40.w,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.orangePrimary),
          ),
          child: DropdownButton(
            iconSize: 24.sp,
            icon: const Icon(Icons.arrow_drop_down_outlined,
                color: MyStyle.orangeDark),
            isExpanded: true,
            value: chooseType,
            items: prodVM.datatypeProduct.map(MyWidget().dropdownItem).toList(),
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
            return 'กรุณากรอก ชื่ออาหาร';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'ชื่ออาหาร :',
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

  Widget buildPrice() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
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
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'ราคา :',
          prefixIcon: const Icon(
            Icons.attach_money_rounded,
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

  Widget buildDetail() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        maxLines: 3,
        controller: detailController,
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'รายละเอียด : ',
          prefixIcon: const Icon(
            Icons.details_rounded,
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
              ? MyWidget().showImage(path: image!, fit: BoxFit.cover)
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

  Widget buildCheck(Function setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: suggest,
          activeColor: MyStyle.orangePrimary,
          onChanged: (check) {
            setState(() => suggest = check!);
          },
        ),
        Text(
          'แนะนำรายการอาหารที่หน้าหลัก',
          style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        )
      ],
    );
  }

  Widget buildButton(BuildContext context, String id) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: MyStyle.bluePrimary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            EasyLoading.show(status: 'loading...');
            processUpdate(context, id);
          } else if (chooseType == null) {
            DialogAlert(context)
                .dialogStatus(type: 1, title: 'กรุณาเลือก ประเภท');
          }
        },
        child: Text(
          'เพิ่มรายการอาหาร',
          style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        ),
      ),
    );
  }

  Future processUpdate(BuildContext context, String id) async {
    String? chooseImage = file != null
        ? await ProductCRUD().uploadImageProduct(file: file!)
        : image!;

    bool status = await ProductCRUD().updateProduct(
      id: id,
      model: ProductModify(
        name: nameController.text,
        type: chooseType!,
        price: int.parse(priceController.text),
        detail: detailController.text.isEmpty ? 'ไม่มี' : detailController.text,
        image: chooseImage,
        status: true,
        suggest: suggest,
        time: Timestamp.fromDate(DateTime.now()),
      ),
    );

    if (status) {
      prodVM.readProductAllList();
      EasyLoading.dismiss();
      ConsoleLog.toast(text: 'แก้ไขรายการอาหารเรียบร้อยแล้ว');
      Get.back();
    } else {
      EasyLoading.dismiss();
      DialogAlert(context).dialogApi();
    }
  }
}
