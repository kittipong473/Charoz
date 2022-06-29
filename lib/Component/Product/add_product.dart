import 'dart:io';
import 'dart:math';

import 'package:charoz/Service/Api/product_api.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/show_toast.dart';
import 'package:charoz/Utilty/Widget/dropdown_menu.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController scoreController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  bool suggest = false;
  String image = '';
  File? file;
  String chooseType = 'อาหาร';

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
                          buildType(),
                          SizedBox(height: 3.h),
                          buildName(),
                          SizedBox(height: 3.h),
                          buildPrice(),
                          SizedBox(height: 3.h),
                          buildScore(),
                          SizedBox(height: 3.h),
                          buildDetail(),
                          SizedBox(height: 4.h),
                          buildImage(),
                          SizedBox(height: 3.h),
                          buildCheck(),
                          SizedBox(height: 3.h),
                          buildButton(context),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ScreenWidget().appBarTitle('เพิ่มรายการอาหาร'),
              ScreenWidget().backPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ประเภท : ',
          style: MyStyle().boldBlack16(),
        ),
        Container(
          width: 40.w,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.primary),
          ),
          child: DropdownButton(
            iconSize: 36,
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: MyStyle.dark,
            ),
            isExpanded: true,
            value: chooseType,
            items: MyVariable.productTypes
                .map(DropDownMenu().dropdownItem)
                .toList(),
            onChanged: (value) {
              setState(() {
                chooseType = value as String;
              });
            },
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: MyStyle().normalBlack16(),
      ),
    );
  }

  Row buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 60.w,
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
              labelStyle: MyStyle().boldBlack16(),
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
        ),
      ],
    );
  }

  Row buildPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 60.w,
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
              labelStyle: MyStyle().boldBlack16(),
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
        ),
      ],
    );
  }

  Row buildScore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 60.w,
          child: TextFormField(
            maxLength: 3,
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
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'คะแนน (5.0) :',
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
        ),
      ],
    );
  }

  Row buildDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
          child: TextFormField(
            style: MyStyle().normalBlack16(),
            maxLines: 3,
            controller: detailController,
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'รายละเอียด :',
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
        ),
      ],
    );
  }

  // Future chooseImage(ImageSource source) async {
  //   try {
  //     var result = await ImagePicker().pickImage(
  //       source: source,
  //       maxWidth: 800,
  //       maxHeight: 800,
  //     );
  //     setState(() {
  //       file = File(result!.path);
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Row buildImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          // onPressed: () => chooseImage(ImageSource.camera),
          onPressed: () {},
          icon: const Icon(
            Icons.add_a_photo,
            size: 36,
            color: MyStyle.dark,
          ),
        ),
        SizedBox(
          width: 50.w,
          height: 50.w,
          child: file == null
              ? Image.asset(
                  MyImage.image,
                  fit: BoxFit.contain,
                )
              : Image.file(file!),
        ),
        IconButton(
          // onPressed: () => chooseImage(ImageSource.gallery),
          onPressed: () {},
          icon: const Icon(
            Icons.add_photo_alternate,
            size: 36,
            color: MyStyle.dark,
          ),
        ),
      ],
    );
  }

  Row buildCheck() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: suggest,
          activeColor: MyStyle.primary,
          onChanged: (check) {
            setState(() {
              suggest = check!;
            });
          },
        ),
        Text(
          'แนะนำรายการอาหารที่หน้าหลัก',
          style: MyStyle().boldBlack16(),
        )
      ],
    );
  }

  Row buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 85.w,
          height: MyVariable.largeDevice ? 60 : 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                processInsert();
              }
            },
            child: Text(
              'เพิ่มรายการอาหาร',
              style: MyStyle().boldWhite16(),
            ),
          ),
        ),
      ],
    );
  }

  Future processInsert() async {
    String name = nameController.text;
    String type = chooseType;
    double price = double.parse(priceController.text);
    double score = double.parse(scoreController.text);
    String detail =
        detailController.text.isEmpty ? 'ไม่มี' : detailController.text;
    int suggestion = suggest ? 1 : 0;
    DateTime time = DateTime.now();

    if (file != null) {
      String url = '${RouteApi.domainApiProduct}saveImageProduct.php';
      int i = Random().nextInt(100000);
      String nameImage = 'product$i.jpg';
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameImage);
      FormData data = FormData.fromMap(map);
      await Dio().post(url, data: data).then((value) {
        image = nameImage;
      });
    } else {
      image = 'error.jfif';
    }

    bool status = await ProductApi().insertProduct(
      name: name,
      type: type,
      price: price,
      score: score,
      detail: detail,
      image: image,
      suggest: suggestion,
      time: time,
    );

    if (status) {
      ShowToast().toast('เพิ่มรายการอาหารเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      DialogAlert().doubleDialog(
          context, 'เพิ่มข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}