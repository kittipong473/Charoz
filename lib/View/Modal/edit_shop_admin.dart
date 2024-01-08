import 'dart:io';

import 'package:charoz/Model/Api/FireStore/shop_model.dart';
import 'package:charoz/Model/Api/Modify/shop_modify.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Firebase/shop_crud.dart';
import 'package:charoz/Service/Library/console_log.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditShopAdmin {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController announceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  TextEditingController freightController = TextEditingController();
  MaskTextInputFormatter timeFormat = MaskTextInputFormatter(mask: '##:##:##');
  MaskTextInputFormatter latFormat = MaskTextInputFormatter(mask: '##.######');
  MaskTextInputFormatter lngFormat = MaskTextInputFormatter(mask: '###.######');
  File? file;
  String? image;

  final ShopViewModel shopVM = Get.find<ShopViewModel>();

  Future<dynamic> openModalEditShopAdmin(context, ShopModel shop) {
    nameController.text = shop.name!;
    phoneController.text = shop.phone!;
    announceController.text = shop.announce!;
    detailController.text = shop.detail!;
    addressController.text = shop.address!;
    latController.text = shop.lat.toString();
    lngController.text = shop.lng.toString();
    freightController.text = shop.freight.toString();
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => modalEditShop(shop.id!));
  }

  Widget modalEditShop(String shopid) {
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
                        SizedBox(height: 7.h),
                        // buildType(setState),
                        SizedBox(height: 3.h),
                        buildName(),
                        SizedBox(height: 3.h),
                        buildPhone(),
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
                        // buildOpen(context, setState),
                        SizedBox(height: 3.h),
                        // buildClose(context, setState),
                        SizedBox(height: 3.h),
                        buildFreight(),
                        SizedBox(height: 3.h),
                        buildImage(setState),
                        SizedBox(height: 3.h),
                        buildButton(context, shopid),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),
              ),
              MyWidget().buildModalHeader(title: 'แก้ไขข้อมูลร้านค้า'),
            ],
          ),
        ),
      ),
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
            return 'กรุณากรอก ชื่อร้านค้า';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'ชื่อร้านค้า :',
          prefixIcon: const Icon(
            Icons.table_restaurant_rounded,
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

  Widget buildPhone() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        keyboardType: TextInputType.phone,
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: phoneController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก เบอร์โทร';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'เบอร์โทรร้าน :',
          prefixIcon:
              const Icon(Icons.phone_rounded, color: MyStyle.orangeDark),
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

  Widget buildAnnounce() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        maxLines: 5,
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: announceController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ประกาศร้านค้า';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'ประกาศร้านค้า :',
          prefixIcon: const Icon(
            Icons.campaign_rounded,
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
        maxLines: 5,
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: detailController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก รายละเอียดร้านค้า';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'รายละเอียดร้านค้า :',
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

  Widget buildAddress() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 80.w,
      child: TextFormField(
        maxLines: 3,
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: addressController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ที่อยู่ร้านค้า';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'ที่อยู่ร้านค้า :',
          prefixIcon: const Icon(
            Icons.location_city_rounded,
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

  Widget buildLat() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 60.w,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [latFormat],
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: latController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ละติจูด';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'ละติจูด :',
          prefixIcon: const Icon(
            Icons.location_searching_rounded,
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

  Widget buildLng() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 60.w,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [lngFormat],
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: lngController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ลองติจูด';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'ลองติจูด :',
          prefixIcon: const Icon(
            Icons.location_searching_rounded,
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

  // Widget buildOpen(BuildContext context, Function setState) {
  //   DateTime? time;
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 10),
  //     width: 60.w,
  //     child: TextFormField(
  //       inputFormatters: [timeFormat],
  //       keyboardType: TextInputType.datetime,
  //       controller: openController,
  //       validator: (value) {
  //         if (value!.isEmpty) {
  //           return 'กรุณากรอก ช่วงเวลา';
  //         } else {
  //           return null;
  //         }
  //       },
  //       decoration: InputDecoration(
  //         labelStyle: MyStyle().boldBlack16(),
  //         labelText: 'เวลาเปิด :',
  //         hintText: 'ชั่วโมง : นาที',
  //         hintStyle: MyStyle().normalGrey14(),
  //         prefixIcon:
  //             const Icon(Icons.calendar_today_rounded, color: MyStyle.dark),
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: const BorderSide(color: MyStyle.dark),
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: const BorderSide(color: MyStyle.light),
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         suffixIcon: IconButton(
  //           onPressed: () =>
  //               modalChooseTime(context, setState, time!, openController),
  //           icon: const Icon(Icons.schedule_rounded, color: MyStyle.primary),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildClose(BuildContext context, Function setState) {
  //   DateTime? time;
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 10),
  //     width: 60.w,
  //     child: TextFormField(
  //       inputFormatters: [timeFormat],
  //       keyboardType: TextInputType.datetime,
  //       controller: closeController,
  //       validator: (value) {
  //         if (value!.isEmpty) {
  //           return 'กรุณากรอก ช่วงเวลา';
  //         } else {
  //           return null;
  //         }
  //       },
  //       decoration: InputDecoration(
  //         labelStyle: MyStyle().boldBlack16(),
  //         labelText: 'เวลาปิด :',
  //         hintText: 'ชั่วโมง : นาที',
  //         hintStyle: MyStyle().normalGrey14(),
  //         prefixIcon:
  //             const Icon(Icons.calendar_today_rounded, color: MyStyle.dark),
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: const BorderSide(color: MyStyle.dark),
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: const BorderSide(color: MyStyle.light),
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         suffixIcon: IconButton(
  //           onPressed: () =>
  //               modalChooseTime(context, setState, time!, closeController),
  //           icon: const Icon(Icons.schedule_rounded, color: MyStyle.primary),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildFreight() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 60.w,
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
        controller: freightController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ค่าส่งอาหาร';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelStyle: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          labelText: 'ค่าส่งอาหาร(บาท) :',
          prefixIcon: const Icon(Icons.delivery_dining_rounded,
              color: MyStyle.orangeDark),
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
          icon: const Icon(Icons.add_a_photo,
              size: 36, color: MyStyle.orangeDark),
        ),
        SizedBox(
          width: 50.w,
          height: 50.w,
          child: file == null
              ? MyWidget().showImage(path: image!, fit: BoxFit.cover)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () async {
            file = await MyFunction().chooseImage(source: ImageSource.gallery);
            setState(() {});
          },
          icon: const Icon(Icons.add_photo_alternate,
              size: 36, color: MyStyle.orangeDark),
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
            Get.back();
          },
          child: Text(
            'ยืนยัน',
            style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String shopid) {
    return SizedBox(
      width: 80.w,
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: MyStyle.bluePrimary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            EasyLoading.show(status: 'loading...');
            processUpdate(context, shopid);
          }
        },
        child: Text(
          'แก้ไขข้อมูลร้านค้า',
          style: MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary),
        ),
      ),
    );
  }

  Future processUpdate(BuildContext context, String shopid) async {
    bool status = await ShopCRUD().updateShop(
      id: shopid,
      model: ShopModify(
        name: nameController.text,
        announce: announceController.text,
        detail: detailController.text,
        address: addressController.text,
        phone: phoneController.text,
        lat: double.parse(latController.text),
        lng: double.parse(lngController.text),
        freight: int.parse(freightController.text),
        time: Timestamp.fromDate(DateTime.now()),
      ),
    );

    if (status) {
      shopVM.readShopModel();
      EasyLoading.dismiss();
      ConsoleLog.toast(text: 'แก้ไขร้านค้าเรียบร้อยแล้ว');
      Get.back();
    } else {
      EasyLoading.dismiss();
      DialogAlert(context).dialogApi();
    }
  }
}
