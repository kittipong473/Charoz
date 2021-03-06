import 'dart:io';

import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Service/Api/PHP/product_api.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Widget/dropdown_menu.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditProduct {
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

  Future<dynamic> openModalEditProduct(context, ProductModel product) {
    chooseType = product.productType;
    nameController.text = product.productName;
    priceController.text = product.productPrice.toString();
    scoreController.text = product.productScore.toString();
    detailController.text = product.productDetail;
    image = product.productImage;
    if (product.productSuggest == 1) {
      suggest = true;
    } else {
      suggest = false;
    }
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => modalEditProduct(product.productId));
  }

  Widget modalEditProduct(int id) {
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
                        children: [
                          SizedBox(height: 10.h),
                          buildType(setState),
                          SizedBox(height: 3.h),
                          buildName(),
                          SizedBox(height: 3.h),
                          buildPrice(),
                          SizedBox(height: 3.h),
                          buildScore(),
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
              ScreenWidget().modalTitle('????????????????????????????????????????????????'),
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
        Text('?????????????????? : ', style: MyStyle().normalBlack16()),
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
            items: GlobalVariable.productTypes
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
            return '??????????????????????????? ???????????????????????????';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: '??????????????????????????? :',
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
            return '??????????????????????????? ????????????';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: '???????????? :',
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
            return '??????????????????????????? ???????????????';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: '??????????????? :',
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
          labelText: '?????????????????????????????? : ',
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
          child: file == null
              ? ShowImage().showProduct(image!)
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
          '?????????????????????????????????????????????????????????????????????????????????',
          style: MyStyle().normalBlack16(),
        )
      ],
    );
  }

  Widget buildButton(BuildContext context, int id) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            EasyLoading.show(status: 'loading...');
            processInsert(context,id);
          } else if (chooseType == null) {
            DialogAlert().singleDialog(context, '?????????????????????????????? ??????????????????');
          }
        },
        child: Text('????????????????????????????????????????????????', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Future processInsert(BuildContext context, int id) async {
    String chooseImage = await ProductApi().saveProductImage(image!, file);

    bool status = await ProductApi().editProductWhereId(
      id: id,
      name: nameController.text,
      type: chooseType!,
      price: double.parse(priceController.text),
      score: double.parse(scoreController.text),
      detail: detailController.text.isEmpty ? '???????????????' : detailController.text,
      image: chooseImage,
      suggest: suggest ? 1 : 0,
      time: DateTime.now(),
    );

    if (status) {
      Provider.of<ProductProvider>(context, listen: false).getAllProductWhereType(
          GlobalVariable.productTypes[GlobalVariable.indexProductChip]);
      EasyLoading.dismiss();
      MyFunction().toast('???????????????????????????????????????????????????????????????????????????????????????');
      Navigator.pop(context);
    } else {
      EasyLoading.dismiss();
      DialogAlert().editFailedDialog(context);
    }
  }
}
