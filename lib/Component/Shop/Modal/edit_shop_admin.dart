import 'dart:io';

import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Model/time_model.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Service/Api/PHP/shop_api.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Widget/dropdown_menu.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditShopAdmin {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController announceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  TextEditingController openController = TextEditingController();
  TextEditingController closeController = TextEditingController();
  MaskTextInputFormatter timeFormat = MaskTextInputFormatter(mask: '##:##:##');
  MaskTextInputFormatter latFormat = MaskTextInputFormatter(mask: '##.######');
  MaskTextInputFormatter lngFormat = MaskTextInputFormatter(mask: '###.######');
  File? file;
  String? image;
  String? chooseType;

  Future<dynamic> openModalEditShopAdmin(
      context, ShopModel shop, TimeModel time) {
    nameController.text = shop.shopName;
    announceController.text = shop.shopAnnounce;
    detailController.text = shop.shopDetail;
    addressController.text = shop.shopAddress;
    latController.text = shop.shopLat.toString();
    lngController.text = shop.shopLng.toString();
    openController.text = time.timeOpen;
    closeController.text = time.timeClose;
    image = shop.shopImage;
    chooseType = time.timeChoose;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => modalEditShop(shop.shopId));
  }

  Widget modalEditShop(int id) {
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
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h),
                        buildType(setState),
                        SizedBox(height: 3.h),
                        buildName(),
                        SizedBox(height: 3.h),
                        buildAnnounce(),
                        SizedBox(height: 3.h),
                        buildDetail(),
                        SizedBox(height: 3.h),
                        buildAddress(),
                        SizedBox(height: 3.h),
                        buildLat(),
                        SizedBox(height: 3.h),
                        buildLng(),
                        SizedBox(height: 3.h),
                        buildOpen(context, setState),
                        SizedBox(height: 3.h),
                        buildClose(context, setState),
                        SizedBox(height: 3.h),
                        buildImage(setState),
                        SizedBox(height: 3.h),
                        buildButton(context, id),
                        SizedBox(height: 2.h),
                      ],
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
            items: GlobalVariable.timeTypes
                .map(DropDownMenu().dropdownItem)
                .toList(),
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

  Widget buildAnnounce() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        maxLines: 5,
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
        maxLines: 5,
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

  Widget buildAddress() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        maxLines: 3,
        style: MyStyle().normalBlack16(),
        controller: addressController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ที่อยู่ร้านค้า';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().normalBlack16(),
          labelText: 'ที่อยู่ร้านค้า :',
          prefixIcon: const Icon(
            Icons.location_city_rounded,
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

  Widget buildLat() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 60.w,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [latFormat],
        style: MyStyle().normalBlack16(),
        controller: latController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ละติจูด';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().boldBlack16(),
          labelText: 'ละติจูด :',
          prefixIcon: const Icon(
            Icons.location_searching_rounded,
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

  Widget buildLng() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 60.w,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [lngFormat],
        style: MyStyle().normalBlack16(),
        controller: lngController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ลองติจูด';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle().boldBlack16(),
          labelText: 'ลองติจูด :',
          prefixIcon: const Icon(
            Icons.location_searching_rounded,
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
              file == null ? ShowImage().showShop(image!) : Image.file(file!),
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

  Widget buildButton(BuildContext context, int id) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            processUpdate(context, id);
          }
        },
        child: Text('แก้ไขข้อมูลร้านค้า', style: MyStyle().normalWhite16()),
      ),
    );
  }

  Future processUpdate(BuildContext context, int id) async {
    String chooseImage = await ShopApi().saveShopImage(image!, file);

    bool status1 = await ShopApi().editShopByAdmin(
      id: id,
      name: nameController.text,
      announce: announceController.text,
      detail: detailController.text,
      address: addressController.text,
      lat: double.parse(latController.text),
      lng: double.parse(lngController.text),
      image: chooseImage,
      time: DateTime.now(),
    );
    bool status2 = await ShopApi().editTimeWhereShop(
      id: id,
      type: chooseType!,
      timeOpen: openController.text,
      timeClose: closeController.text,
    );

    if (status1 && status2) {
      Provider.of<ShopProvider>(context, listen: false).selectShopWhereId(id);
      Provider.of<ShopProvider>(context, listen: false).getTimeWhereId(id);
      MyFunction().toast('แก้ไขร้านค้าเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      DialogAlert().editFailedDialog(context);
    }
  }
}
