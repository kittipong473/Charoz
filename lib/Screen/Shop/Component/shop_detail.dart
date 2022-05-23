import 'dart:async';

import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/Screen/Home/Provider/home_provider.dart';
import 'package:charoz/Screen/Product/Provider/product_provider.dart';
import 'package:charoz/Screen/Shop/Model/shop_model.dart';
import 'package:charoz/Screen/Shop/Provider/shop_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
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
  late TransformationController transformationController;
  final Completer<GoogleMapController> _controller = Completer();
  bool allowLocation = false;

  @override
  void initState() {
    super.initState();
    checkLocation();
    transformationController = TransformationController();
  }

  void getData() {
    Provider.of<ShopProvider>(context, listen: false).getShopWhereId();
    Provider.of<ShopProvider>(context, listen: false).getTimeWhereId();
    Provider.of<ShopProvider>(context, listen: false).getShopDetailImage();
  }

  Future checkLocation() async {
    allowLocation = await MyWidget().checkPermission(context);
  }

  @override
  void dispose() {
    super.dispose();
    transformationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: !allowLocation
            ? const ShowProgress()
            : Stack(
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
                            MyWidget().buildTitle(title: 'ชื่อร้านค้า :'),
                            SizedBox(height: 1.h),
                            buildName(),
                            SizedBox(height: 2.h),
                            MyWidget().buildTitle(title: 'รายละเอียด :'),
                            SizedBox(height: 1.h),
                            buildDetail(),
                            SizedBox(height: 2.h),
                            MyWidget()
                                .buildTitle(title: 'เวลาเปิด-ปิด วันทำงาน :'),
                            SizedBox(height: 1.h),
                            buildWeekDayTime(),
                            SizedBox(height: 2.h),
                            MyWidget()
                                .buildTitle(title: 'เวลาเปิด-ปิด วันหยุด :'),
                            SizedBox(height: 1.h),
                            buildWeekEndTime(),
                            SizedBox(height: 2.h),
                            MyWidget().buildTitle(title: 'ตำแหน่งร้านค้า :'),
                            SizedBox(height: 1.h),
                            buildAddress(),
                            SizedBox(height: 2.h),
                            buildMap(),
                            SizedBox(height: 5.h),
                            MyWidget()
                                .buildTitle(title: 'รูปภาพเกี่ยวกับร้านค้า :'),
                            SizedBox(height: 1.h),
                            buildShopImage(),
                            SizedBox(height: 3.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                  MyWidget().backgroundTitle(),
                  MyWidget().title('ข้อมูลร้านค้า'),
                  MyWidget().backPage(context),
                  if (MyVariable.role == 'admin' ||
                      MyVariable.role == 'saler') ...[
                    Consumer<ShopProvider>(
                      builder: (_, value, __) => MyWidget()
                          .editShop(context, value.shop!, value.time!),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Widget buildName() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => value.shop == null
          ? const ShowProgress()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.shop.shopName,
                  style: MyStyle().normalBlue18(),
                ),
              ],
            ),
    );
  }

  Widget buildDetail() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => value.shop == null
          ? const ShowProgress()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80.w,
                  child: Text(
                    value.shop.shopDetail,
                    style: MyStyle().normalBlue18(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildWeekDayTime() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => value.time == null
          ? const ShowProgress()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(
                    '${value.time.timeWeekdayOpen} น. - ${value.time.timeWeekdayClose} น.',
                    style: MyStyle().normalBlue18(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildWeekEndTime() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => value.time == null
          ? const ShowProgress()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(
                    '${value.time.timeWeekendOpen} น. - ${value.time!.timeWeekendClose} น.',
                    style: MyStyle().normalBlue18(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildAddress() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 70.w,
            child: Text(
              value.shop.shopAddress,
              style: MyStyle().normalBlue18(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMap() {
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
                  target: LatLng(double.parse(value.shop.shopLat),
                      double.parse(value.shop.shopLng)),
                  zoom: 18,
                  tilt: 80,
                ),
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
                markers: setMarker(value.shop),
              ),
      ),
    );
  }

  Set<Marker> setMarker(ShopModel shop) {
    return <Marker>{
      Marker(
        markerId: const MarkerId('1'),
        position:
            LatLng(double.parse(shop.shopLat), double.parse(shop.shopLng)),
        infoWindow: InfoWindow(title: shop.shopName, snippet: shop.shopAddress),
      ),
    };
  }

  Widget buildShopImage() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => value.shopimages.isEmpty
          ? const ShowProgress()
          : CarouselSlider.builder(
              options: CarouselOptions(height: 30.h, autoPlay: true),
              itemCount: value.shopimagesLength,
              itemBuilder: (context, index, realIndex) =>
                  buildShopImageItem(value.shopimages[index], index),
            ),
    );
  }

  Widget buildShopImageItem(String shopimage, int index) {
    return InkWell(
      onTap: () => dialogCarouselDetail(shopimage),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            shopimage,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  void dialogCarouselDetail(String shopimage) {
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) => SimpleDialog(
        title: Column(
          children: [
            SizedBox(
              height: 25.h,
              child: InteractiveViewer(
                transformationController: transformationController,
                clipBehavior: Clip.none,
                panEnabled: false,
                minScale: 1,
                maxScale: 4,
                // onInteractionEnd: (details) => resetAnimation(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    shopimage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'เลื่อนนิ้วเพื่อ zoom เข้า zoom ออก',
              style: MyStyle().normalBlack16(),
            ),
          ],
        ),
      ),
    );
  }
}
