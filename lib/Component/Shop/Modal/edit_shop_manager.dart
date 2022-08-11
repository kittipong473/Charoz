import 'dart:io';

import 'package:charoz/Model_Sub/shop_manager_sub.dart';
import 'package:charoz/Model_Sub/time_sub.dart';
import 'package:charoz/Model_Main/shop_model.dart';
import 'package:charoz/Model_Main/time_model.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Service/Database/Firebase/shop_crud.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Widget/dropdown_menu.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditShopManager {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController announceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController openController = TextEditingController();
  TextEditingController closeController = TextEditingController();
  TextEditingController freightController = TextEditingController();
  MaskTextInputFormatter timeFormat = MaskTextInputFormatter(mask: '##:##:##');
  File? file;
  String? image;
  String? chooseType;

  Future<dynamic> openModalEditShopManager(
      context, ShopModel shop, TimeModel time) {
    nameController.text = shop.name;
    phoneController.text = shop.phone;
    announceController.text = shop.announce;
    detailController.text = shop.detail;
    openController.text = time.open;
    closeController.text = time.close;
    freightController.text = shop.freight.toString();
    image = shop.image;
    chooseType = time.choose;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => modalEditShop(shop.id, time.id));
  }

  Widget modalEditShop(String shopid, String timeid) {
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
                          buildPhone(),
                          SizedBox(height: 3.h),
                          buildAnnounce(),
                          SizedBox(height: 3.h),
                          buildDetail(),
                          SizedBox(height: 5.h),
                          buildOpen(context, setState),
                          SizedBox(height: 3.h),
                          buildClose(context, setState),
                          SizedBox(height: 3.h),
                          buildFreight(),
                          SizedBox(height: 3.h),
                          buildImage(setState),
                          SizedBox(height: 3.h),
                          buildButton(context, shopid, timeid),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ScreenWidget().modalTitle('แก้ไขข้อมูลร้านค้า'),
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
      width: 80.w,
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

  Widget buildPhone() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        keyboardType: TextInputType.phone,
        style: MyStyle().normalBlack16(),
        controller: phoneController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก เบอร์โทร';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'เบอร์โทรร้าน :',
          prefixIcon: const Icon(Icons.phone_rounded, color: MyStyle.dark),
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
      width: 80.w,
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
      width: 80.w,
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

  Widget buildOpen(BuildContext context, Function setState) {
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
            onPressed: () =>
                modalChooseTime(context, setState, time!, openController),
            icon: const Icon(Icons.schedule_rounded, color: MyStyle.primary),
          ),
        ),
      ),
    );
  }

  Widget buildClose(BuildContext context, Function setState) {
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
            onPressed: () =>
                modalChooseTime(context, setState, time!, closeController),
            icon: const Icon(Icons.schedule_rounded, color: MyStyle.primary),
          ),
        ),
      ),
    );
  }

  Widget buildFreight() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 60.w,
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: MyStyle().normalBlack16(),
        controller: freightController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ค่าส่งอาหาร';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().boldBlack16(),
          labelText: 'ค่าส่งอาหาร(บาท) :',
          prefixIcon:
              const Icon(Icons.delivery_dining_rounded, color: MyStyle.dark),
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
          icon: const Icon(Icons.add_a_photo, size: 36, color: MyStyle.dark),
        ),
        SizedBox(
          width: 50.w,
          height: 50.w,
          child:
              file == null ? ShowImage().showImage(image!) : Image.file(file!),
        ),
        IconButton(
          onPressed: () async {
            file = await MyFunction().chooseImage(ImageSource.gallery);
            setState(() {});
          },
          icon: const Icon(Icons.add_photo_alternate,
              size: 36, color: MyStyle.dark),
        ),
      ],
    );
  }

  Future modalChooseTime(BuildContext context, Function setState, DateTime time,
      TextEditingController controller) {
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

  Widget buildButton(BuildContext context, String shopid, String timeid) {
    return SizedBox(
      width: 90.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            EasyLoading.show(status: 'loading...');
            processUpdate(context, shopid, timeid);
          }
        },
        child: Text('แก้ไขข้อมูลร้านค้า', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Future processUpdate(
      BuildContext context, String shopid, String timeid) async {
    String chooseImage =
        file == null ? await ShopCRUD().uploadImageShop(file!) : '';

    bool status1 = await ShopCRUD().updateShopByManager(
      shopid,
      ShopManagerModify(
        name: nameController.text,
        announce: announceController.text,
        detail: detailController.text,
        phone: phoneController.text,
        image: chooseImage,
        freight: int.parse(freightController.text),
        time: Timestamp.fromDate(DateTime.now()),
      ),
    );
    bool status2 = await ShopCRUD().updateTime(
      timeid,
      TimeModify(
        shopid: shopid,
        open: openController.text,
        close: closeController.text,
        choose: chooseType!,
      ),
    );

    if (status1 && status2) {
      Provider.of<ShopProvider>(context, listen: false).readShopModel();
      Provider.of<ShopProvider>(context, listen: false).readTimeModel();
      EasyLoading.dismiss();
      MyFunction().toast('แก้ไขร้านค้าเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      EasyLoading.dismiss();
      DialogAlert().editFailedDialog(context);
    }
  }
}
