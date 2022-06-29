import 'dart:io';
import 'dart:math';

import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Service/Api/shop_api.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/show_toast.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditShopSaler extends StatefulWidget {
  final int shopId;
  final String shopName;
  final String shopAnnounce;
  final String shopDetail;
  final String timeType;
  final String timeWeekdayOpen;
  final String timeWeekdayClose;
  final String timeWeekendOpen;
  final String timeWeekendClose;
  final String shopVideo;
  const EditShopSaler({
    Key? key,
    required this.shopId,
    required this.shopName,
    required this.shopAnnounce,
    required this.shopDetail,
    required this.timeType,
    required this.timeWeekdayOpen,
    required this.timeWeekdayClose,
    required this.timeWeekendOpen,
    required this.timeWeekendClose,
    required this.shopVideo,
  }) : super(key: key);

  @override
  _EditShopSalerState createState() => _EditShopSalerState();
}

class _EditShopSalerState extends State<EditShopSaler> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController announceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController weekDayOpenController = TextEditingController();
  TextEditingController weekDayCloseController = TextEditingController();
  TextEditingController weekEndOpenController = TextEditingController();
  TextEditingController weekEndCloseController = TextEditingController();
  String video = '';
  File? file;
  final types = [
    'เปิดตามเวลาปกติ',
    'ปิดชั่วคราว',
    'ปิดช่วงเทศกาล',
  ];
  String chooseType = '';

  @override
  void initState() {
    super.initState();
    nameController.text = widget.shopName;
    announceController.text = widget.shopAnnounce;
    detailController.text = widget.shopDetail;
    chooseType = widget.timeType;
    weekDayOpenController.text = widget.timeWeekdayOpen;
    weekDayCloseController.text = widget.timeWeekdayClose;
    weekEndOpenController.text = widget.timeWeekendOpen;
    weekEndCloseController.text = widget.timeWeekendClose;
    video = widget.shopVideo;
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
                          buildAnnounce(),
                          SizedBox(height: 3.h),
                          buildDetail(),
                          SizedBox(height: 5.h),
                          buildWeekDayOpen(),
                          SizedBox(height: 3.h),
                          buildWeekDayClose(),
                          SizedBox(height: 3.h),
                          buildWeekEndOpen(),
                          SizedBox(height: 3.h),
                          buildWeekEndClose(),
                          SizedBox(height: 4.h),
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
          style: MyStyle().boldBlack16(),
        ),
        Container(
          width: 50.w,
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
          width: 85.w,
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
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'ชื่อร้านค้า :',
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

  Row buildAnnounce() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
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
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'ประกาศของร้านค้า :',
              prefixIcon: const Icon(
                Icons.announcement_rounded,
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
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'รายละเอียดร้านค้า :',
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

  Row buildWeekDayOpen() {
    DateTime? time;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 60.w,
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            controller: weekDayOpenController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ช่วงเวลา';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'Open วันธรรมดา :',
              hintText: 'ชั่วโมง : นาที',
              hintStyle: MyStyle().normalGrey14(),
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
              suffixIcon: IconButton(
                onPressed: () {
                  showCupertinoModalPopup(
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
                            onDateTimeChanged: (value) => setState(() {
                              time = value;
                            }),
                          ),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          final ans = DateFormat('HH:mm').format(time!);
                          weekDayOpenController.text = ans;
                          Navigator.pop(context);
                        },
                        child: Text(
                          'ยืนยัน',
                          style: MyStyle().normalPrimary16(),
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.schedule_rounded,
                  color: MyStyle.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildWeekDayClose() {
    DateTime? time;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 60.w,
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            controller: weekDayCloseController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ช่วงเวลา';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'Close วันธรรมดา :',
              hintText: 'ชั่วโมง : นาที',
              hintStyle: MyStyle().normalGrey14(),
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
              suffixIcon: IconButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      actions: [
                        SizedBox(
                          height: 180,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: DateTime(0),
                            minuteInterval: 60,
                            use24hFormat: true,
                            onDateTimeChanged: (value) => setState(() {
                              time = value;
                            }),
                          ),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          final value = DateFormat('HH').format(time!);
                          weekDayCloseController.text = value;
                          Navigator.pop(context);
                        },
                        child: Text(
                          'ยืนยัน',
                          style: MyStyle().normalPrimary16(),
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.schedule_rounded,
                  color: MyStyle.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildWeekEndOpen() {
    DateTime? time;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 60.w,
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            controller: weekEndOpenController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ช่วงเวลา';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'Open วันหยุด :',
              hintText: 'ชั่วโมง : นาที',
              hintStyle: MyStyle().normalGrey14(),
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
              suffixIcon: IconButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      actions: [
                        SizedBox(
                          height: 180,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: DateTime(0),
                            minuteInterval: 60,
                            use24hFormat: true,
                            onDateTimeChanged: (value) => setState(() {
                              time = value;
                            }),
                          ),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          final value = DateFormat('HH').format(time!);
                          weekEndOpenController.text = value;
                          Navigator.pop(context);
                        },
                        child: Text(
                          'ยืนยัน',
                          style: MyStyle().normalPrimary16(),
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.schedule_rounded,
                  color: MyStyle.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildWeekEndClose() {
    DateTime? time;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 60.w,
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            controller: weekEndCloseController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ช่วงเวลา';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'Close วันหยุด :',
              hintText: 'ชั่วโมง : นาที',
              hintStyle: MyStyle().normalGrey14(),
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
              suffixIcon: IconButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      actions: [
                        SizedBox(
                          height: 180,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: DateTime(0),
                            minuteInterval: 60,
                            use24hFormat: true,
                            onDateTimeChanged: (value) => setState(() {
                              time = value;
                            }),
                          ),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          final value = DateFormat('HH').format(time!);
                          weekEndCloseController.text = value;
                          Navigator.pop(context);
                        },
                        child: Text(
                          'ยืนยัน',
                          style: MyStyle().normalPrimary16(),
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.schedule_rounded,
                  color: MyStyle.primary,
                ),
              ),
            ),
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
          width: 85.w,
          height: MyVariable.largeDevice ? 60 : 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.bluePrimary),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                processUpdate();
              }
            },
            child: Text(
              'แก้ไขข้อมูลร้านค้า',
              style: MyStyle().boldWhite18(),
            ),
          ),
        ),
      ],
    );
  }

  Future processUpdate() async {
    int id = widget.shopId;
    String name = nameController.text;
    String announce = announceController.text;
    String detail = detailController.text;
    String type = chooseType;
    String weekdayOpen = weekDayOpenController.text;
    String weekdayClose = weekDayCloseController.text;
    String weekendOpen = weekEndOpenController.text;
    String weekendClose = weekEndCloseController.text;
    DateTime time = DateTime.now();

    if (file != null) {
      String url = '${RouteApi.domainApiShop}saveVideoShop.php';
      int i = Random().nextInt(100000);
      String nameVideo = 'video$i.jpg';
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameVideo);
      FormData data = FormData.fromMap(map);
      await Dio().post(url, data: data).then((value) {
        video = nameVideo;
      });
    }

    bool status1 = await ShopApi().editInformationShopWhereId(
      id: id,
      name: name,
      announce: announce,
      detail: detail,
      video: video,
      time: time,
    );

    bool status2 = await ShopApi().editTimeWhereId(
      id: id,
      type: type,
      weekdayOpen: weekdayOpen,
      weekdayClose: weekdayClose,
      weekendOpen: weekendOpen,
      weekendClose: weekendClose,
    );

    if (status1 && status2) {
      Provider.of<ShopProvider>(context, listen: false).getShopWhereId();
      Provider.of<ShopProvider>(context, listen: false).getTimeWhereId();
      ShowToast().toast('แก้ไขร้านค้าเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      DialogAlert().doubleDialog(
          context, 'แก้ไขข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
