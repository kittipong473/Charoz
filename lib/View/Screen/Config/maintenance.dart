import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Charoz Application',
                style: MyStyle.textStyle(
                    size: 20, color: MyStyle.orangePrimary, bold: true),
              ),
              SizedBox(height: 5.h),
              MyWidget().showImage(
                  path: MyImage.lotMaintenance, width: 250, height: 250),
              SizedBox(height: 5.h),
              Text(
                '',
                style: MyStyle.textStyle(
                    size: 20, color: MyStyle.orangePrimary, bold: true),
              ),
              SizedBox(height: 3.h),
              Text(
                '',
                style:
                    MyStyle.textStyle(size: 20, color: MyStyle.orangePrimary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
