import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Service/Api/shop_api.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/show_toast.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditShopAdmin extends StatefulWidget {
  final int id;
  final String address;
  final double lat;
  final double lng;
  const EditShopAdmin({
    Key? key,
    required this.id,
    required this.address,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  @override
  _EditShopAdminState createState() => _EditShopAdminState();
}

class _EditShopAdminState extends State<EditShopAdmin> {
  final formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addressController.text = widget.address;
    latController.text = widget.lat.toString();
    lngController.text = widget.lng.toString();
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
              ScreenWidget().appBarTitle('แก้ไขข้อมูลร้านค้า'),
              ScreenWidget().backPage(context),
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
            keyboardType: TextInputType.number,
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
            keyboardType: TextInputType.number,
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
    int id = widget.id;
    String address = addressController.text;
    double lat = double.parse(latController.text);
    double lng = double.parse(lngController.text);
    DateTime time = DateTime.now();

    bool status = await ShopApi().editAddressShopWhereId(
      id: id,
      address: address,
      lat: lat,
      lng: lng,
      time: time,
    );

    if (status) {
      Provider.of<ShopProvider>(context, listen: false).getShopWhereId();
      ShowToast().toast('แก้ไขร้านค้าเรียบร้อยแล้ว');
      Navigator.pop(context);
    } else {
      DialogAlert().doubleDialog(
          context, 'แก้ไขข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
