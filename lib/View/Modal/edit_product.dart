import 'dart:io';

import 'package:charoz/Model/Data/product_model.dart';
import 'package:charoz/Model/Api/Request/product_modify.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/product_crud.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/Util/Variable/var_data.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Widget/dropdown_menu.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View/Widget/show_image.dart';
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
    chooseType = product.type;
    nameController.text = product.name;
    priceController.text = product.price.toString();
    detailController.text = product.detail;
    image = product.image;
    if (product.suggest == 1) {
      suggest = true;
    } else {
      suggest = false;
    }
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => modalEditProduct(product.id));
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
                    padding: VariableGeneral.largeDevice!
                        ? EdgeInsets.symmetric(horizontal: 10.w)
                        : EdgeInsets.symmetric(horizontal: 5.w),
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
              ScreenWidget().modalTitle('แก้ไขรายการอาหาร'),
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
            items: VariableData.productTypes
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
            file = await MyFunction().chooseImage(ImageSource.camera);
            setState(() {});
          },
          icon: Icon(Icons.add_a_photo, size: 24.sp, color: MyStyle.dark),
        ),
        SizedBox(
          width: 40.w,
          height: 40.w,
          child:
              file == null ? ShowImage().showImage(image!) : Image.file(file!),
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
            MyDialog(context).singleDialog('กรุณาเลือก ประเภท');
          }
        },
        child: Text('เพิ่มรายการอาหาร', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Future processUpdate(BuildContext context, String id) async {
    String chooseImage =
        file != null ? await ProductCRUD().uploadImageProduct(file!) : image!;

    bool status = await ProductCRUD().updateProduct(
      id,
      ProductManage(
        name: nameController.text,
        type: chooseType!,
        price: int.parse(priceController.text),
        detail: detailController.text.isEmpty ? 'ไม่มี' : detailController.text,
        image: chooseImage,
        status: 1,
        suggest: suggest ? 1 : 0,
        time: Timestamp.fromDate(DateTime.now()),
      ),
    );

    if (status) {
      prodVM.readProductAllList();
      prodVM.readProductTypeList(
          VariableData.productTypes[VariableGeneral.indexProductChip]);
      EasyLoading.dismiss();
      MyFunction().toast('แก้ไขรายการอาหารเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      EasyLoading.dismiss();
      MyDialog(context).addFailedDialog();
    }
  }
}
