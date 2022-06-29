import 'dart:io';
import 'dart:math';

import 'package:charoz/Provider/noti_provider.dart';
import 'package:charoz/Service/Api/noti_api.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ManageNoti extends StatefulWidget {
  const ManageNoti({Key? key}) : super(key: key);

  @override
  _ManageNotiState createState() => _ManageNotiState();
}

class _ManageNotiState extends State<ManageNoti> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController useridController = TextEditingController();
  DateTime? startValue;
  DateTime? endValue;
  String? image;
  File? file;
  String? chooseType;

  MaskTextInputFormatter dateFormat =
      MaskTextInputFormatter(mask: '##-##-####');

  @override
  void initState() {
    super.initState();
    startValue = DateTime.now();
    startController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
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
                          buildStart(),
                          SizedBox(height: 3.h),
                          buildEnd(),
                          SizedBox(height: 3.h),
                          buildUserId(),
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
              ScreenWidget().appBarTitle('เพิ่มการแจ้งเตือน'),
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
        Text('ประเภท : ', style: MyStyle().normalBlack16()),
        Container(
          width: 30.w,
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
            items:
                MyVariable.notisAdmin.map(DropDownMenu().dropdownItem).toList(),
            onChanged: (value) {
              setState(() => chooseType = value as String);
            },
          ),
        ),
      ],
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
              suffixIcon: IconButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 100),
                    lastDate: DateTime(DateTime.now().year + 1),
                  ).then((value) {
                    setState(() {
                      startValue = value;
                      startController.text =
                          DateFormat('dd MM yy').format(startValue!);
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
        ),
      ],
    );
  }

  Row buildUserId() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 50.w,
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: MyStyle().normalBlack16(),
            controller: useridController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก รหัสเป้าหมาย';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().normalBlack16(),
              labelText: 'รหัสเป้าหมาย :',
              prefixIcon: const Icon(
                Icons.key_rounded,
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
          width: 80.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                processInsert();
              } else if (chooseType == null) {
                DialogAlert().singleDialog(context, 'กรุณาเลือก หัวข้อ');
              }
            },
            child: Text('เพิ่มการแจ้งเตือน', style: MyStyle().normalWhite16()),
          ),
        ),
      ],
    );
  }

  Future processInsert() async {
    String type = chooseType!;
    String name = nameController.text;
    String detail = detailController.text;
    String userid = useridController.text;
    DateTime start = startValue!;
    DateTime end = endValue!;

    if (file != null) {
      String url = '${RouteApi.domainApiNoti}saveImagePromo.php';
      int i = Random().nextInt(100000);
      String nameImage = 'promo$i.jpg';
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameImage);
      FormData data = FormData.fromMap(map);
      await Dio().post(url, data: data).then((value) {
        image = nameImage;
      });
    } else {
      image = 'null';
    }

    bool status = await NotiApi().insertNoti(
      type: type,
      name: name,
      detail: detail,
      userid: userid,
      image: image!,
      start: start,
      end: end,
    );

    if (status) {
      Provider.of<NotiProvider>(context, listen: false)
          .getAllNotiWhereType(MyVariable.notisAdmin[MyVariable.indexNotiChip]);
      ShowToast().toast('เพิ่มการแจ้งเตือนเรียบร้อย');
      Navigator.pop(context);
    } else {
      DialogAlert().doubleDialog(
          context, 'เพิ่มข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
