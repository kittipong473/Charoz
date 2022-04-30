import 'package:charoz/screens/home/provider/home_provider.dart';
import 'package:charoz/utils/constant/my_image.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({Key? key}) : super(key: key);

  @override
  _MaintenancePageState createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<HomeProvider>(
          builder: (context, provider, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    MyImage.maintenance,
                    width: 80.w,
                    height: 40.w,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    provider.maintain!.maintainName,
                    style: MyStyle().boldPrimary20(),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    provider.maintain!.maintainDetail,
                    style: MyStyle().boldPrimary20(),
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
