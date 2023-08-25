import 'package:charoz/Model/Api/FireStore/shop_model.dart';
import 'package:charoz/View/Modal/add_noti.dart';
import 'package:charoz/View/Modal/edit_shop_admin.dart';
import 'package:charoz/Utility/Constant/my_image.dart';
import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScreenWidget {
  AppBar appBarTheme(String title) {
    return AppBar(
      title: Text(title, style: MyStyle().boldBlue18()),
      backgroundColor: MyStyle.orangeLight,
      centerTitle: true,
      toolbarHeight: 5.h,
      elevation: 10,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade200, Colors.orange.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Positioned appBarTitle(String title) {
    return Positioned(
      top: 0,
      child: Container(
        width: 100.w,
        height: 7.h,
        padding: EdgeInsets.only(top: 3.h),
        decoration: const BoxDecoration(
          color: MyStyle.orangePrimary,
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
          color: MyStyle.orangePrimary,
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

  Widget buildModalHeader(String title) {
    return Container(
      width: 100.w,
      height: 7.h,
      padding: EdgeInsets.only(top: 1.h),
      margin: EdgeInsets.only(bottom: 3.h),
      color: MyStyle.orangeLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: MyStyle().borderRadius(value: 20),
            ),
            width: 50,
            height: 5,
          ),
          SizedBox(height: 1.h),
          Text(title,
              style: MyStyle().boldWhite18(), textAlign: TextAlign.center),
        ],
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
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: MyStyle().boldBlack18()),
        ],
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

  Positioned editShop(BuildContext context, ShopModel shop) {
    return Positioned(
      top: 2.h,
      right: 3.w,
      child: IconButton(
        onPressed: () => EditShopAdmin().openModalEditShopAdmin(context, shop),
        icon: Icon(
          Icons.edit_location_alt_rounded,
          color: Colors.white,
          size: 20.sp,
        ),
      ),
    );
  }

  Positioned createNoti(BuildContext context) {
    return Positioned(
      top: 2.h,
      right: 3.w,
      child: IconButton(
        onPressed: () => AddNoti().openModalAdNoti(context),
        icon: Icon(
          Icons.notification_add_rounded,
          color: Colors.white,
          size: 20.sp,
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
            style: MyStyle().boldPrimary18(),
          ),
          SizedBox(height: 3.h),
          SizedBox(
            width: 80.w,
            child: Text(
              subtitle,
              style: MyStyle().normalPrimary16(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSpacer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      color: Colors.grey,
      width: 100.w,
      height: 0.2.h,
    );
  }

  Widget buildLogoImage() =>
      Image.asset(MyImage.logo3, width: 40.w, height: 40.w);
}
