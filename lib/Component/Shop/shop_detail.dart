import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/Component/Shop/Dialog/carousel_detail.dart';
import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:charoz/Utilty/Function/location_service.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShopDetail extends StatefulWidget {
  final int id;
  const ShopDetail({Key? key, required this.id}) : super(key: key);

  @override
  _ShopDetailState createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  GoogleMapController? googleMapController;
  bool? allowLocation;

  @override
  void initState() {
    getData();
    checkLocation();
    super.initState();
  }

  Future checkLocation() async {
    allowLocation = await LocationService().checkPermission();
    setState(() {});
  }

  Future getData() async {
    await Provider.of<ShopProvider>(context, listen: false)
        .getTimeWhereId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<ShopProvider>(
          builder: (_, provider, __) => Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        ScreenWidget().buildTitle('????????????????????????????????? :'),
                        SizedBox(height: 1.h),
                        buildName(provider.shop.shopName),
                        SizedBox(height: 2.h),
                        ScreenWidget().buildTitle('?????????????????????????????? :'),
                        SizedBox(height: 1.h),
                        buildDetail(provider.shop.shopDetail),
                        SizedBox(height: 2.h),
                        ScreenWidget().buildTitle('????????????????????????-????????? :'),
                        SizedBox(height: 1.h),
                        buildTime(
                            provider.time.timeOpen, provider.time.timeClose),
                        SizedBox(height: 2.h),
                        ScreenWidget().buildTitle('?????????????????????????????????????????? :'),
                        SizedBox(height: 1.h),
                        buildAddress(provider.shop.shopAddress),
                        SizedBox(height: 2.h),
                        allowLocation != null
                            ? allowLocation!
                                ? buildActiveMap(provider.shop)
                                : buildDisableMap()
                            : const ShowProgress(),
                        SizedBox(height: 5.h),
                        ScreenWidget().buildTitle('?????????????????????????????????????????????????????????????????? :'),
                        SizedBox(height: 1.h),
                        buildShopImageList(),
                        SizedBox(height: 3.h),
                      ],
                    ),
                  ),
                ),
              ),
              ScreenWidget().appBarTitle('???????????????????????????????????????'),
              ScreenWidget().backPage(context),
              if (GlobalVariable.role == 'admin' ||
                  GlobalVariable.role == 'manager') ...[
                ScreenWidget()
                    .editShop(context, provider.shop!, provider.time!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(String name) {
    return SizedBox(
      width: 80.w,
      child: Text(
        name,
        style: MyStyle().normalPrimary18(),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildDetail(String detail) {
    return SizedBox(
      width: 80.w,
      child: Text(
        detail,
        style: MyStyle().normalPrimary18(),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildTime(String open, String close) {
    return SizedBox(
      width: 80.w,
      child: Text(
        '${MyFunction().convertToOpenClose(open)} ???. - ${MyFunction().convertToOpenClose(close)} ???.',
        style: MyStyle().normalPrimary18(),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildAddress(String address) {
    return SizedBox(
      width: 80.w,
      child: Text(
        address,
        style: MyStyle().normalPrimary18(),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildActiveMap(ShopModel shop) {
    return SizedBox(
      width: 80.w,
      height: 80.w,
      child: GoogleMap(
        myLocationEnabled: true,
        compassEnabled: false,
        tiltGesturesEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(shop.shopLat, shop.shopLng), zoom: 18, tilt: 80),
        onMapCreated: (controller) {
          setState(() => googleMapController = controller);
        },
        markers: setMarker(shop),
      ),
    );
  }

  Widget buildDisableMap() {
    return SizedBox(
      width: 80.w,
      height: 80.w,
      child: Center(
        child: Text(
          '?????????????????????????????????????????????\n??????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
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
    return CarouselSlider.builder(
      options: CarouselOptions(height: 30.h, autoPlay: true),
      itemCount: GlobalVariable.carouselShopImage.length,
      itemBuilder: (context, index, realIndex) =>
          buildShopImageItem(GlobalVariable.carouselShopImage[index], index),
    );
  }

  Widget buildShopImageItem(String shopimage, int index) {
    return InkWell(
      onTap: () => CarouselDetail().dialogShop(context, shopimage),
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
