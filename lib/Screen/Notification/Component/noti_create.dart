import 'dart:io';
import 'dart:math';

import 'package:charoz/Screen/Notification/Provider/noti_provider.dart';
import 'package:charoz/Service/Api/noti_api.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Constant/my_dialog.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotiCreate extends StatefulWidget {
  const NotiCreate({Key? key}) : super(key: key);

  @override
  _NotiCreateState createState() => _NotiCreateState();
}

class _NotiCreateState extends State<NotiCreate> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController referController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  String image = 'null';
  File? file;

  final types = [
    'ข่าวสาร',
    'โปรโมชั่น',
    'อื่นๆ',
  ];
  String chooseType = 'ข่าวสาร';

  @override
  void initState() {
    super.initState();
    startController.text =
        DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
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
                          buildDetail(),
                          SizedBox(height: 3.h),
                          buildRefer(),
                          SizedBox(height: 3.h),
                          buildStart(),
                          SizedBox(height: 3.h),
                          buildEnd(),
                          SizedBox(height: 3.h),
                          buildImage(),
                          SizedBox(height: 3.h),
                          buildButton(context),
                          SizedBox(height: 3.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              MyWidget().backgroundTitle(),
              MyWidget().title('เพิ่มการแจ้งเตือน'),
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
            items: types.map(buildMenuItem).toList(),
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
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'หัวข้อ :',
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

  Row buildDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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

  Row buildRefer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 80.w,
          child: TextFormField(
            style: MyStyle().normalBlack16(),
            controller: referController,
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'การอ้างถึง :',
              prefixIcon: const Icon(
                Icons.trending_up_rounded,
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

  Row buildStart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 80.w,
          child: TextFormField(
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
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'เวลาเริ่ม (D-M-Y H:M):',
              prefixIcon: const Icon(
                Icons.calendar_today_rounded,
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

  Row buildEnd() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 80.w,
          child: TextFormField(
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
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'เวลาสิ้นสุด (D-M-Y H:M):',
              prefixIcon: const Icon(
                Icons.calendar_today_rounded,
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
              ? Image.asset(
                  MyImage.image,
                  fit: BoxFit.contain,
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

  Row buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 60.w,
          height: MyVariable.largeDevice ? 60 : 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.blue),
            onPressed: () {
              if (formKey.currentState!.validate() && file != null) {
                processInsert();
              }
            },
            child: Text(
              'เพิ่มการแจ้งเตือน',
              style: MyStyle().boldWhite18(),
            ),
          ),
        ),
      ],
    );
  }

  Future processInsert() async {
    String type = chooseType;
    String name = nameController.text;
    String detail = detailController.text;
    String refer = referController.text.isEmpty ? 'null' : referController.text;
    String start = startController.text;
    String end = endController.text;

    if (file != null) {
      String url = '${RouteApi.domainApi}saveImagePromo.php';
      int i = Random().nextInt(100000);
      String nameImage = 'promo$i.jpg';
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameImage);
      FormData data = FormData.fromMap(map);
      await Dio().post(url, data: data).then((value) {
        image = nameImage;
      });
    }

    bool status = await NotiApi().insertNoti(
      type: type,
      name: name,
      detail: detail,
      image: image,
      refer: refer,
      start: start,
      end: end,
    );

    if (status) {
      NotiProvider().getAllNoti();
      MyWidget().toast('เพิ่มการแจ้งเตือนเรียบร้อย');
      Navigator.pop(context);
    } else {
      MyDialog().doubleDialog(
          context, 'เพิ่มข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
