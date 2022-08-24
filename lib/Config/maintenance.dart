import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Center(
            child: Consumer<ConfigProvider>(
              builder: (context, provider, child) =>
                  provider.maintenance == null
                      ? const ShowProgress()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Charoz Application',
                                style: MyStyle().boldPrimary20()),
                            SizedBox(height: 5.h),
                            Lottie.asset(
                              MyImage.gifMaintenance,
                              width: 250,
                              height: 250,
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              provider.maintenance!.name,
                              style: MyStyle().boldPrimary20(),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              provider.maintenance!.detail,
                              style: MyStyle().normalPrimary18(),
                              textAlign: TextAlign.center,
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
