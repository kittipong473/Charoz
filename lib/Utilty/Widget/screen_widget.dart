import 'package:charoz/Component/Shop/edit_shop_admin.dart';
import 'package:charoz/Component/Shop/edit_shop_saler.dart';
import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Model/time_model.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScreenWidget {
  Positioned appBarTitle(String title) {
    return Positioned(
      top: 0,
      child: Container(
        width: 100.w,
        height: 7.h,
        padding: EdgeInsets.only(top: 3.h),
        decoration: const BoxDecoration(
          color: MyStyle.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Text(title,
            style: MyStyle().boldWhite18(), textAlign: TextAlign.center),
      ),
    );
  }

  Positioned appBarTitleLarge(String title) {
    return Positioned(
      top: 0,
      child: Container(
        width: 100.w,
        height: 15.h,
        padding: EdgeInsets.only(top: 3.h),
        decoration: const BoxDecoration(
          color: MyStyle.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Text(title,
            style: MyStyle().boldWhite18(), textAlign: TextAlign.center),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: MyStyle().boldBlack18()),
      ],
    );
  }

  Widget buildTitlePadding(String title) {
    return Padding(
      padding: MyVariable.largeDevice
          ? const EdgeInsets.symmetric(horizontal: 40)
          : const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: MyStyle().boldBlack18()),
        ],
      ),
    );
  }

  Widget modalTitle(String title) {
    return Positioned(
      top: 0,
      child: Container(
        width: 100.w,
        height: 4.h,
        padding: EdgeInsets.only(top: 1.h),
        decoration: const BoxDecoration(
          color: MyStyle.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Text(title,
            style: MyStyle().boldWhite16(), textAlign: TextAlign.center),
      ),
    );
  }

  Positioned backPage(BuildContext context) {
    return Positioned(
      top: 2.h,
      left: 3.w,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_rounded,
            color: Colors.white, size: 18.sp),
      ),
    );
  }

  Positioned editShop(BuildContext context, ShopModel shop, TimeModel time) {
    return Positioned(
      top: 2.h,
      right: 3.w,
      child: IconButton(
        onPressed: () {
          if (MyVariable.role == "saler") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditShopSaler(shop: shop, time: time),
              ),
            );
          } else if (MyVariable.role == "admin") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditShopAdmin(shop: shop, time: time),
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
      top: 2.h,
      right: 3.w,
      child: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutePage.routeManageNoti);
        },
        icon: Icon(
          Icons.notification_add_rounded,
          color: Colors.white,
          size: MyVariable.largeDevice ? 30 : 20,
        ),
      ),
    );
  }

  Widget showEmptyData(String title, String subtitle) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: MyStyle().boldPrimary20(),
          ),
          SizedBox(height: 3.h),
          Text(
            subtitle,
            style: MyStyle().boldPrimary20(),
          ),
        ],
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
