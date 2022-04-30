import 'dart:async';

import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/screens/home/provider/home_provider.dart';
import 'package:charoz/screens/shop/model/shop_model.dart';
import 'package:charoz/screens/shop/provider/shop_provider.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:charoz/utils/show_progress.dart';
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

  Future checkLocation() async {
    allowLocation = await Provider.of<HomeProvider>(context, listen: false)
        .checkPermission(context);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    transformationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<ShopProvider>(
          builder: (context, sprovider, child) => allowLocation
              ? Stack(
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
                              buildName(sprovider.shop!.shopName),
                              SizedBox(height: 2.h),
                              MyWidget().buildTitle(title: 'รายละเอียด :'),
                              SizedBox(height: 1.h),
                              buildDetail(sprovider.shop!.shopDetail),
                              SizedBox(height: 2.h),
                              MyWidget()
                                  .buildTitle(title: 'เวลาเปิด-ปิด วันทำงาน :'),
                              SizedBox(height: 1.h),
                              buildWeekDayTime(sprovider.time!.timeWeekdayOpen,
                                  sprovider.time!.timeWeekdayClose),
                              SizedBox(height: 2.h),
                              MyWidget()
                                  .buildTitle(title: 'เวลาเปิด-ปิด วันหยุด :'),
                              SizedBox(height: 1.h),
                              buildWeekEndTime(sprovider.time!.timeWeekendOpen,
                                  sprovider.time!.timeWeekendClose),
                              SizedBox(height: 2.h),
                              MyWidget().buildTitle(title: 'ตำแหน่งร้านค้า :'),
                              SizedBox(height: 1.h),
                              buildAddress(sprovider.shop!.shopAddress),
                              SizedBox(height: 2.h),
                              buildMap(sprovider.shop),
                              SizedBox(height: 5.h),
                              MyWidget().buildTitle(
                                  title: 'รูปภาพเกี่ยวกับร้านค้า :'),
                              SizedBox(height: 1.h),
                              buildShopImage(sprovider.shopimages),
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
                      MyWidget()
                          .editShop(context, sprovider.shop!, sprovider.time!),
                    ],
                  ],
                )
              : const ShowProgress(),
        ),
      ),
    );
  }

  Widget buildName(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: MyStyle().normalPrimary18(),
        ),
      ],
    );
  }

  Widget buildDetail(String detail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            detail,
            style: MyStyle().normalPrimary18(),
          ),
        ),
      ],
    );
  }

  Widget buildWeekDayTime(String open, String close) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Text(
            '$open น. - $close น.',
            style: MyStyle().normalPrimary18(),
          ),
        ),
      ],
    );
  }

  Widget buildWeekEndTime(String open, String close) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Text(
            '$open น. - $close น.',
            style: MyStyle().normalPrimary18(),
          ),
        ),
      ],
    );
  }

  Widget buildAddress(String address) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 70.w,
          child: Text(
            address,
            style: MyStyle().normalPrimary18(),
          ),
        ),
      ],
    );
  }

  Widget buildMap(ShopModel shop) {
    return SizedBox(
      width: 80.w,
      height: 80.w,
      child: GoogleMap(
        myLocationEnabled: true,
        compassEnabled: false,
        tiltGesturesEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target:
              LatLng(double.parse(shop.shopLat), double.parse(shop.shopLng)),
          zoom: 18,
          tilt: 80,
        ),
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        markers: setMarker(shop),
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

  Widget buildShopImage(List shopimages) {
    return CarouselSlider.builder(
      options: CarouselOptions(height: 30.h, autoPlay: true),
      itemCount: shopimages.length,
      itemBuilder: (context, index, realIndex) =>
          buildShopImageItem(shopimages[index], index),
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
