import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/location_service.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShopMap extends StatefulWidget {
  const ShopMap({Key? key}) : super(key: key);

  @override
  State<ShopMap> createState() => _ShopMapState();
}

class _ShopMapState extends State<ShopMap> {
  GoogleMapController? googleMapController;
  bool? allowLocation;

  @override
  void initState() {
    super.initState();
    checkLocation();
  }

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  Future checkLocation() async {
    allowLocation = await LocationService().checkPermission();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        appBar: ScreenWidget().appBarTheme('แผนที่ร้านอาหาร'),
        body: Stack(
          children: [
            Positioned.fill(
              child: allowLocation != null
                  ? allowLocation!
                      ? buildActiveMap()
                      : buildDisableMap()
                  : const ShowProgress(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActiveMap() {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: Consumer<ShopProvider>(
        builder: (_, provider, __) => GoogleMap(
          myLocationEnabled: true,
          compassEnabled: false,
          tiltGesturesEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(provider.shop.lat, provider.shop.lng),
            zoom: 18,
            tilt: 80,
          ),
          onMapCreated: (controller) =>
              setState(() => googleMapController = controller),
          markers: setMarker(provider.shop),
        ),
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
        position: LatLng(shop.lat, shop.lng),
        infoWindow: InfoWindow(title: shop.name, snippet: shop.address),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
    };
  }
}
