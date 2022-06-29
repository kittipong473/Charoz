import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/dialog_detail.dart';
import 'package:charoz/Utilty/Function/location_service.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShopDetail extends StatefulWidget {
  const ShopDetail({Key? key}) : super(key: key);

  @override
  _ShopDetailState createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  GoogleMapController? googleMapController;
  bool allowLocation = false;

  @override
  void initState() {
    getData();
    checkLocation();
    super.initState();
  }

  Future checkLocation() async {
    allowLocation = await LocationService().checkPermission(context);
  }

  void getData() {
    Provider.of<ShopProvider>(context, listen: false).getShopWhereId();
    Provider.of<ShopProvider>(context, listen: false).getTimeWhereId();
    Provider.of<ShopProvider>(context, listen: false).getShopDetailImage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: MyVariable.largeDevice
                      ? const EdgeInsets.symmetric(horizontal: 40)
                      : const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      ScreenWidget().buildTitle('ชื่อร้านค้า :'),
                      SizedBox(height: 1.h),
                      buildName(),
                      SizedBox(height: 2.h),
                      ScreenWidget().buildTitle('รายละเอียด :'),
                      SizedBox(height: 1.h),
                      buildDetail(),
                      SizedBox(height: 2.h),
                      ScreenWidget().buildTitle('เวลาเปิด-ปิด วันทำงาน :'),
                      SizedBox(height: 1.h),
                      buildWeekDayTime(),
                      SizedBox(height: 2.h),
                      ScreenWidget().buildTitle('เวลาเปิด-ปิด วันหยุด :'),
                      SizedBox(height: 1.h),
                      buildWeekEndTime(),
                      SizedBox(height: 2.h),
                      ScreenWidget().buildTitle('ตำแหน่งร้านค้า :'),
                      SizedBox(height: 1.h),
                      buildAddress(),
                      SizedBox(height: 2.h),
                      allowLocation ? buildActiveMap() : buildDisableMap(),
                      SizedBox(height: 5.h),
                      ScreenWidget().buildTitle('รูปภาพเกี่ยวกับร้านค้า :'),
                      SizedBox(height: 1.h),
                      buildShopImageList(),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ),
            ),
            ScreenWidget().appBarTitle('ข้อมูลร้านค้า'),
            ScreenWidget().backPage(context),
            // if (MyVariable.role == 'admin' ||
            //     MyVariable.role == 'saler') ...[
            //   Consumer<ShopProvider>(
            //     builder: (_, value, __) => ScreenWidget()
            //         .editShop(context, value.shop!, value.time!),
            //   ),
            // ],
          ],
        ),
      ),
    );
  }

  Widget buildName() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => value.shop == null
          ? const ShowProgress()
          : SizedBox(
              width: 80.w,
              child: Text(
                value.shop.shopName,
                style: MyStyle().normalBlue18(),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  Widget buildDetail() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => value.shop == null
          ? const ShowProgress()
          : SizedBox(
              width: 80.w,
              child: Text(
                value.shop.shopDetail,
                style: MyStyle().normalBlue18(),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  Widget buildWeekDayTime() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => value.time == null
          ? const ShowProgress()
          : SizedBox(
              width: 80.w,
              child: Text(
                '${MyFunction().convertShopTime(value.time.timeWeekdayOpen)} น. - ${MyFunction().convertShopTime(value.time.timeWeekdayClose)} น.',
                style: MyStyle().normalBlue18(),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  Widget buildWeekEndTime() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => value.time == null
          ? const ShowProgress()
          : SizedBox(
              width: 80.w,
              child: Text(
                '${MyFunction().convertShopTime(value.time.timeWeekendOpen)} น. - ${MyFunction().convertShopTime(value.time.timeWeekendClose)} น.',
                style: MyStyle().normalBlue18(),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  Widget buildAddress() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => SizedBox(
        width: 80.w,
        child: Text(
          value.shop.shopAddress,
          style: MyStyle().normalBlue18(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildActiveMap() {
    return SizedBox(
      width: 80.w,
      height: 80.w,
      child: Consumer<ShopProvider>(
        builder: (_, value, __) => value.shop == null
            ? const ShowProgress()
            : GoogleMap(
                myLocationEnabled: true,
                compassEnabled: false,
                tiltGesturesEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(value.shop.shopLat, value.shop.shopLng),
                  zoom: 18,
                  tilt: 80,
                ),
                onMapCreated: (controller) {
                  setState(() => googleMapController = controller);
                },
                markers: setMarker(value.shop),
              ),
      ),
    );
  }

  Widget buildDisableMap() {
    return SizedBox(
      width: 80.w,
      height: 80.w,
      child: Center(
        child: Text(
          'แผนที่ไม่แสดงผล\nเนื่องจากไม่ได้อนุญาตการเข้าถึงตำแหน่ง',
          style: MyStyle().normalRed18(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Set<Marker> setMarker(ShopModel shop) {
    return <Marker>{
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(shop.shopLat, shop.shopLng),
        infoWindow: InfoWindow(title: shop.shopName, snippet: shop.shopAddress),
      ),
    };
  }

  Widget buildShopImageList() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => value.shopImageList == null
          ? const ShowProgress()
          : CarouselSlider.builder(
              options: CarouselOptions(height: 30.h, autoPlay: true),
              itemCount: value.shopImageList.length,
              itemBuilder: (context, index, realIndex) =>
                  buildShopImageItem(value.shopImageList[index], index),
            ),
    );
  }

  Widget buildShopImageItem(String shopimage, int index) {
    return InkWell(
      onTap: () => DialogDetail().dialogShop(context, shopimage),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(shopimage, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
