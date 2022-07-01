import 'dart:io';

import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Model/time_model.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Service/Api/shop_api.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/save_image_path.dart';
import 'package:charoz/Utilty/Function/show_toast.dart';
import 'package:charoz/Utilty/Widget/dropdown_menu.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditShopSaler extends StatefulWidget {
  final ShopModel shop;
  final TimeModel time;
  const EditShopSaler({Key? key, required this.shop, required this.time})
      : super(key: key);

  @override
  _EditShopSalerState createState() => _EditShopSalerState();
}

class _EditShopSalerState extends State<EditShopSaler> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController announceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController openController = TextEditingController();
  TextEditingController closeController = TextEditingController();
  MaskTextInputFormatter timeFormat = MaskTextInputFormatter(mask: '##:##:##');
  File? file;
  String? image;
  String? chooseType;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.shop.shopName;
    announceController.text = widget.shop.shopAnnounce;
    detailController.text = widget.shop.shopDetail;
    openController.text = widget.time.timeOpen;
    closeController.text = widget.time.timeClose;
    image = widget.shop.shopImage;
    chooseType = widget.time.timeChoose;
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          buildType(),
                          SizedBox(height: 3.h),
                          buildName(),
                          SizedBox(height: 3.h),
                          buildAnnounce(),
                          SizedBox(height: 3.h),
                          buildDetail(),
                          SizedBox(height: 5.h),
                          buildOpen(),
                          SizedBox(height: 3.h),
                          buildClose(),
                          SizedBox(height: 3.h),
                          buildImage(),
                          SizedBox(height: 3.h),
                          buildButton(context),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ScreenWidget().appBarTitle('แก้ไขข้อมูลร้านค้า'),
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
          style: MyStyle().normalBlack16(),
        ),
        Container(
          width: 40.w,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.dark),
          ),
          child: DropdownButton(
            iconSize: 24,
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: MyStyle.primary,
            ),
            isExpanded: true,
            value: chooseType,
            items:
                MyVariable.timeTypes.map(DropDownMenu().dropdownItem).toList(),
            onChanged: (value) {
              setState(() => chooseType = value as String);
            },
          ),
        ),
      ],
    );
  }

  Widget buildName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 90.w,
      child: TextFormField(
        style: MyStyle().normalBlack16(),
        controller: nameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ชื่อร้านค้า';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'ชื่อร้านค้า :',
          prefixIcon: const Icon(
            Icons.table_restaurant_rounded,
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

  Widget buildAnnounce() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 90.w,
      child: TextFormField(
        maxLines: 4,
        style: MyStyle().normalBlack16(),
        controller: announceController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ประกาศร้านค้า';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'ประกาศร้านค้า :',
          prefixIcon: const Icon(
            Icons.campaign_rounded,
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
      width: 90.w,
      child: TextFormField(
        maxLines: 4,
        style: MyStyle().normalBlack16(),
        controller: detailController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก รายละเอียดร้านค้า';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'รายละเอียดร้านค้า :',
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

  Widget buildOpen() {
    DateTime? time;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 60.w,
      child: TextFormField(
        inputFormatters: [timeFormat],
        keyboardType: TextInputType.datetime,
        controller: openController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ช่วงเวลา';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().boldBlack16(),
          labelText: 'เวลาเปิด :',
          hintText: 'ชั่วโมง : นาที',
          hintStyle: MyStyle().normalGrey14(),
          prefixIcon:
              const Icon(Icons.calendar_today_rounded, color: MyStyle.dark),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.dark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.light),
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            onPressed: () => modalChooseTime(time!, openController),
            icon: const Icon(Icons.schedule_rounded, color: MyStyle.primary),
          ),
        ),
      ),
    );
  }

  Widget buildClose() {
    DateTime? time;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 60.w,
      child: TextFormField(
        inputFormatters: [timeFormat],
        keyboardType: TextInputType.datetime,
        controller: closeController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ช่วงเวลา';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().boldBlack16(),
          labelText: 'เวลาปิด :',
          hintText: 'ชั่วโมง : นาที',
          hintStyle: MyStyle().normalGrey14(),
          prefixIcon:
              const Icon(Icons.calendar_today_rounded, color: MyStyle.dark),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.dark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyStyle.light),
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            onPressed: () => modalChooseTime(time!, closeController),
            icon: const Icon(Icons.schedule_rounded, color: MyStyle.primary),
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () async {
            file = await SaveImagePath().chooseImage(ImageSource.camera);
            setState(() {});
          },
          icon: const Icon(Icons.add_a_photo, size: 36, color: MyStyle.dark),
        ),
        SizedBox(
          width: 50.w,
          height: 50.w,
          child:
              file == null ? ShowImage().shopImage(image!) : Image.file(file!),
        ),
        IconButton(
          onPressed: () async {
            file = await SaveImagePath().chooseImage(ImageSource.gallery);
            setState(() {});
          },
          icon: const Icon(Icons.add_photo_alternate,
              size: 36, color: MyStyle.dark),
        ),
      ],
    );
  }

  Future modalChooseTime(DateTime time, TextEditingController controller) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: DateTime(0),
              minuteInterval: 10,
              use24hFormat: true,
              onDateTimeChanged: (value) => setState(() => time = value),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            final ans = DateFormat('HH:mm:ss').format(time);
            controller.text = ans;
            Navigator.pop(context);
          },
          child: Text('ยืนยัน', style: MyStyle().normalPrimary16()),
        ),
      ),
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
            processUpdate();
          }
        },
        child: Text('แก้ไขข้อมูลร้านค้า', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Future processUpdate() async {
    String chooseImage = await SaveImagePath().saveShopImage(image!, file);

    bool status1 = await ShopApi().editShopByManager(
      id: widget.shop.shopId,
      name: nameController.text,
      announce: announceController.text,
      detail: detailController.text,
      image: chooseImage,
      time: DateTime.now(),
    );
    bool status2 = await ShopApi().editTimeWhereShop(
      id: widget.shop.shopId,
      type: chooseType!,
      timeOpen: openController.text,
      timeClose: closeController.text,
    );

    if (status1 && status2) {
      Provider.of<ShopProvider>(context, listen: false)
          .getShopWhereId(widget.shop.shopId);
      Provider.of<ShopProvider>(context, listen: false)
          .getTimeWhereId(widget.shop.shopId);
      ShowToast().toast('แก้ไขร้านค้าเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      DialogAlert().doubleDialog(
          context, 'แก้ไขข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
