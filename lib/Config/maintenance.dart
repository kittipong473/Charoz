import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Center(
            child: Consumer<ConfigProvider>(
              builder: (context, provider, child) => provider.maintenance == null
                  ? const ShowProgress()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          MyImage.maintenance,
                          width: 100.w,
                          height: 60.w,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          provider.maintenance!.name,
                          style: MyStyle().boldPrimary20(),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          provider.maintenance!.detail,
                          style: MyStyle().boldPrimary18(),
                        ),
                        Text(
                          provider.maintenance!.id,
                          style: MyStyle().boldPrimary18(),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
