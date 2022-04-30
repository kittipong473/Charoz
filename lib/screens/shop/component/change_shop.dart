import 'package:charoz/screens/shop/provider/shop_provider.dart';
import 'package:charoz/services/api/shop_api.dart';
import 'package:charoz/utils/constant/my_dialog.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChangeShop extends StatefulWidget {
  final String id;
  final String address;
  final String lat;
  final String lng;
  const ChangeShop({
    Key? key,
    required this.id,
    required this.address,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  @override
  _ChangeShopState createState() => _ChangeShopState();
}

class _ChangeShopState extends State<ChangeShop> {
  final formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addressController.text = widget.address;
    latController.text = widget.lat;
    lngController.text = widget.lng;
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
              Positioned(
                child: SingleChildScrollView(
                  padding: MyVariable.largeDevice
                      ? const EdgeInsets.symmetric(horizontal: 40)
                      : const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 15.h),
                        buildAddress(),
                        SizedBox(height: 3.h),
                        buildLat(),
                        SizedBox(height: 3.h),
                        buildLng(),
                        SizedBox(height: 5.h),
                        buildButton(context),
                      ],
                    ),
                  ),
                ),
              ),
              MyWidget().backgroundTitle(),
              MyWidget().title('แก้ไขข้อมูลร้านค้า'),
              MyWidget().backPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Row buildAddress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
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
              labelStyle: MyStyle().boldBlack16(),
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
        ),
      ],
    );
  }

  Row buildLat() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 60.w,
          child: TextFormField(
            maxLength: 9,
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
        ),
      ],
    );
  }

  Row buildLng() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 60.w,
          child: TextFormField(
            maxLength: 10,
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
    String id = widget.id;
    String address = addressController.text;
    String lat = latController.text;
    String lng = lngController.text;
    String time = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

    bool status = await ShopApi().editAddressWhereId(
      id: id,
      address: address,
      lat: lat,
      lng: lng,
      time: time,
    );

    if (status) {
      Provider.of<ShopProvider>(context, listen: false).getShopWhereId();
      MyWidget().toast('แก้ไขร้านค้าเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      MyDialog().doubleDialog(
          context, 'แก้ไขข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
