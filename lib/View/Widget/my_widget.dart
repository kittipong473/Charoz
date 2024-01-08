import 'package:cached_network_image/cached_network_image.dart';
import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyWidget {
  Widget showProgress() {
    return const Center(
      child: CircularProgressIndicator(color: MyStyle.orangePrimary),
    );
  }

  DropdownMenuItem<String> dropdownItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: MyStyle.textStyle(
          size: 16,
          color: MyStyle.blackPrimary,
        ),
      ),
    );
  }

  Widget buildSpacer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      color: Colors.grey,
      width: 100.w,
      height: 5,
    );
  }

  Widget buildLogoImage() =>
      Image.asset(MyImage.imgLogo3, width: 40.w, height: 40.w);

  Widget buildTitle({required String title, bool? padding}) {
    return padding == true
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MyStyle.textStyle(
                      size: 18, color: MyStyle.blackPrimary, bold: true),
                ),
              ],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: MyStyle.textStyle(
                    size: 18, color: MyStyle.blackPrimary, bold: true),
              ),
            ],
          );
  }

  Widget buildModalHeader({required String title}) {
    return Container(
      width: 100.w,
      height: 55,
      padding: const EdgeInsets.only(top: 10),
      color: MyStyle.orangeLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(20)),
            width: 40,
            height: 5,
          ),
          const SizedBox(height: 10),
          Text(title,
              style: MyStyle.textStyle(
                  size: 18, color: MyStyle.bluePrimary, bold: true),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget showEmptyData({required String title, String? body}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: MyStyle.textStyle(
                size: 22, color: MyStyle.orangePrimary, bold: true),
          ),
          if (body != null) ...[
            SizedBox(height: 2.h),
            SizedBox(
              width: 80.w,
              child: Text(
                body,
                style: MyStyle.textStyle(
                    size: 20, color: MyStyle.orangePrimary, bold: true),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
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
            style: MyStyle.textStyle(
                size: 18, color: MyStyle.whitePrimary, bold: true),
            textAlign: TextAlign.center),
      ),
    );
  }

  Widget showImage(
      {required String path,
      double? width,
      double? height,
      BoxFit? fit,
      double? radius}) {
    String type = path.split('.')[1];
    if (type == 'svg') {
      return SvgPicture.asset(path,
          width: width, height: height, fit: fit ?? BoxFit.contain);
    } else if (type == 'json') {
      return Lottie.asset(path, width: width, height: height, fit: fit);
    } else if (type == 'png' ||
        type == 'jfif' ||
        type == 'jpg' ||
        type == 'jpeg') {
      return Image.asset(path, width: width, height: height, fit: fit);
    } else {
      return ClipRRect(
        borderRadius:
            radius == null ? BorderRadius.zero : BorderRadius.circular(radius),
        child: CachedNetworkImage(
          fit: fit,
          imageUrl: path,
          placeholder: (context, url) => MyWidget().showProgress(),
          errorWidget: (context, url, error) => Image.asset(MyImage.image),
        ),
      );
    }
  }

  AppBar appBarTheme({required String title, IconButton? action}) {
    return AppBar(
      title: Text(
        title,
        style:
            MyStyle.textStyle(size: 20, color: MyStyle.bluePrimary, bold: true),
      ),
      backgroundColor: MyStyle.orangeLight,
      centerTitle: true,
      toolbarHeight: 7.h,
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
      actions: action != null
          ? [Padding(padding: const EdgeInsets.only(right: 5), child: action)]
          : [],
    );
  }

  Widget buttonWidget({
    required String title,
    required Function() onTap,
    Color? color,
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: width ?? 90.w,
      height: height ?? 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? MyStyle.bluePrimary),
        onPressed: onTap,
        child: Text(
          title,
          style: MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary),
        ),
      ),
    );
  }
}
