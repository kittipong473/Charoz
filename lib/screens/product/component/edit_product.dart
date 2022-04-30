import 'dart:io';
import 'dart:math';

import 'package:charoz/screens/product/provider/product_provider.dart';
import 'package:charoz/services/api/product_api.dart';
import 'package:charoz/services/route/route_api.dart';
import 'package:charoz/utils/constant/my_dialog.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditProduct extends StatefulWidget {
  final String productId;
  final String productType;
  final String productName;
  final String productPrice;
  final String productDetail;
  final String productImage;
  final int productSuggest;
  const EditProduct({
    Key? key,
    required this.productId,
    required this.productType,
    required this.productName,
    required this.productPrice,
    required this.productDetail,
    required this.productImage,
    required this.productSuggest,
  }) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  bool suggest = false;
  String image = '';
  File? file;
  String chooseType = '';

  @override
  void initState() {
    super.initState();
    chooseType = widget.productType;
    nameController.text = widget.productName;
    priceController.text = widget.productPrice;
    detailController.text = widget.productDetail;
    image = widget.productImage;
    if (widget.productSuggest == 1) {
      suggest = true;
    } else {
      suggest = false;
    }
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
                        children: [
                          SizedBox(height: 10.h),
                          buildType(),
                          SizedBox(height: 3.h),
                          buildName(),
                          SizedBox(height: 3.h),
                          buildPrice(),
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
              MyWidget().backgroundTitle(),
              MyWidget().title('แก้ไขรายการอาหาร'),
              MyWidget().backPage(context),
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
            items: MyVariable.producttypes.map(buildMenuItem).toList(),
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

  Future chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {
      //
    }
  }

  Row buildImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
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
              ? Image.network(
                  '${RouteApi.domainProduct}$image',
                  fit: BoxFit.cover,
                )
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
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
            style: ElevatedButton.styleFrom(primary: MyStyle.blue),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                processUpdate();
              }
            },
            child: Text(
              'แก้ไขรายการอาหาร',
              style: MyStyle().boldWhite18(),
            ),
          ),
        ),
      ],
    );
  }

  Future processUpdate() async {
    String id = widget.productId;
    String name = nameController.text;
    String type = chooseType;
    String price = priceController.text;
    String detail =
        detailController.text.isEmpty ? 'ไม่มี' : detailController.text;
    int suggestion = suggest ? 1 : 0;
    String time = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

    if (file != null) {
      String url = '${RouteApi.domainApi}saveImageProduct.php';
      int i = Random().nextInt(100000);
      String nameImage = 'product$i.jpg';
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameImage);
      FormData data = FormData.fromMap(map);
      await Dio().post(url, data: data).then((value) {
        image = nameImage;
      });
    }

    bool status = await ProductApi().editProductWhereId(
      id: id,
      name: name,
      type: type,
      price: price,
      detail: detail,
      image: image,
      suggest: suggestion,
      time: time,
    );

    if (status) {
      MyWidget().toast('แก้ไขรายการอาหารเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      MyDialog().doubleDialog(
          context, 'แก้ไขข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
