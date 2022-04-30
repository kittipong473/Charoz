import 'package:charoz/screens/shop/component/change_shop.dart';
import 'package:charoz/screens/shop/component/edit_shop.dart';
import 'package:charoz/screens/shop/model/shop_model.dart';
import 'package:charoz/screens/shop/model/time_model.dart';
import 'package:charoz/screens/user/component/login.dart';
import 'package:charoz/screens/user/component/user_detail.dart';
import 'package:charoz/services/route/route_page.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyWidget {
  Future toast(String title) async {
    return Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Positioned backgroundTitle() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 8.h,
        decoration: const BoxDecoration(
          color: MyStyle.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }

  Positioned backgroundTitleSearch() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 14.h,
        decoration: const BoxDecoration(
          color: MyStyle.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }

  Positioned title(String title) {
    return Positioned(
      top: 4.h,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: MyStyle().boldWhite18(),
          ),
        ],
      ),
    );
  }

  Widget buildTitle({required String title}) {
    return Row(
      children: [
        Text(
          title,
          style: MyStyle().boldDark18(),
        ),
      ],
    );
  }

  Widget buildTitlePadding({required String title}) {
    return Padding(
      padding: MyVariable.largeDevice
          ? const EdgeInsets.symmetric(horizontal: 40)
          : const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: MyStyle().boldDark18(),
          ),
        ],
      ),
    );
  }

  Positioned backPage(BuildContext context) {
    return Positioned(
      top: MyVariable.largeDevice ? 30 : 20,
      left: MyVariable.largeDevice ? 30 : 10,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
          size: 20.sp,
        ),
      ),
    );
  }

  Positioned editShop(BuildContext context, ShopModel shop, TimeModel time) {
    return Positioned(
      top: MyVariable.largeDevice ? 60 : 20,
      right: MyVariable.largeDevice ? 30 : 10,
      child: IconButton(
        onPressed: () {
          if (MyVariable.role == "saler") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditShop(
                  shopId: shop.shopId,
                  shopName: shop.shopName,
                  shopAnnounce: shop.shopAnnounce,
                  shopDetail: shop.shopDetail,
                  timeType: time.timeChoose,
                  timeWeekdayOpen: time.timeWeekdayOpen,
                  timeWeekdayClose: time.timeWeekdayClose,
                  timeWeekendOpen: time.timeWeekendOpen,
                  timeWeekendClose: time.timeWeekendClose,
                  shopVideo: shop.shopVideo,
                ),
              ),
            );
          } else if (MyVariable.role == "admin") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeShop(
                  id: shop.shopId,
                  address: shop.shopAddress,
                  lat: shop.shopLat,
                  lng: shop.shopLng,
                ),
              ),
            );
          }
        },
        icon: Icon(
          Icons.edit_location_alt_rounded,
          color: Colors.white,
          size: MyVariable.largeDevice ? 30 : 20,
        ),
      ),
    );
  }

  Positioned createNoti(BuildContext context) {
    return Positioned(
      top: MyVariable.largeDevice ? 60 : 20,
      right: MyVariable.largeDevice ? 30 : 10,
      child: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutePage.routeNotiCreate);
        },
        icon: Icon(
          Icons.notification_add_rounded,
          color: Colors.white,
          size: MyVariable.largeDevice ? 30 : 20,
        ),
      ),
    );
  }

  Positioned loginIcon(BuildContext context) {
    return Positioned(
      top: MyVariable.largeDevice ? 60 : 20,
      right: MyVariable.largeDevice ? 30 : 10,
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            ),
          );
        },
        icon: Icon(
          Icons.login_rounded,
          color: Colors.white,
          size: 20.sp,
        ),
      ),
    );
  }

  // Widget buildQRcode() {
  //   return Column(
  //     children: [
  //       QrImage(
  //         data: controller.text,
  //         size: 200,
  //         backgroundColor: Colors.white,
  //       ),
  //       const SizedBox(height: 40),
  //       TextField(
  //         controller: controller,
  //         decoration: InputDecoration(
  //           hintText: "Enter the Data",
  //           suffixIcon: IconButton(
  //             icon: const Icon(Icons.send_rounded),
  //             onPressed: () => setState(() {}),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget buildOpenScanner() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const Scanner(),
  //         ),
  //       );
  //     },
  //     child: const Text('Open Scanner'),
  //   );
  // }
}
