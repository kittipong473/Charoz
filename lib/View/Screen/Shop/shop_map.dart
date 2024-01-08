import 'package:charoz/Model/Api/FireStore/shop_model.dart';
import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShopMap extends StatefulWidget {
  const ShopMap({Key? key}) : super(key: key);

  @override
  State<ShopMap> createState() => _ShopMapState();
}

class _ShopMapState extends State<ShopMap> {
  GoogleMapController? googleMapController;
  String? theme;

  final shopVM = Get.find<ShopViewModel>();

  @override
  void initState() {
    super.initState();
    getMapTheme();
    getLocation();
  }

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  void getMapTheme() async {
    theme = await DefaultAssetBundle.of(context).loadString(MyImage.styleMap);
  }

  Future getLocation() async {
    await shopVM.checkLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        appBar: MyWidget().appBarTheme(title: 'แผนที่ร้านอาหาร'),
        body: GetBuilder<ShopViewModel>(
          builder: (vm) =>
              vm.allowLocation == true ? buildActiveMap() : buildDisableMap(),
        ),
      ),
    );
  }

  Widget buildActiveMap() {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: GoogleMap(
        myLocationEnabled: true,
        compassEnabled: false,
        tiltGesturesEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(shopVM.shop.lat, shopVM.shop.lng),
          zoom: 17,
          tilt: 50,
        ),
        onMapCreated: (controller) {
          setState(() {
            googleMapController = controller;
            // googleMapController!.setMapStyle(theme);
          });
        },
        markers: setMarker(shopVM.shop),
      ),
    );
  }

  Widget buildDisableMap() {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: Center(
        child: Text(
          'แผนที่ไม่แสดงผล\nเนื่องจากไม่ได้อนุญาตการเข้าถึงตำแหน่ง',
          style: MyStyle.textStyle(size: 18, color: MyStyle.redPrimary),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Set<Marker> setMarker(ShopModel shop) {
    return <Marker>{
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(shop.lat!, shop.lng!),
        infoWindow: InfoWindow(title: shop.name, snippet: shop.address),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    };
  }
}
