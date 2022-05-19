import 'package:charoz/Screen/Home/Provider/home_provider.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MaintenancePage extends StatefulWidget {
  final String status;
  const MaintenancePage({Key? key, required this.status}) : super(key: key);

  @override
  _MaintenancePageState createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    Provider.of<HomeProvider>(context, listen: false)
        .getMaintenance(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<HomeProvider>(
          builder: (context, provider, child) => provider.maintain == null
              ? const ShowProgress()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Center(
                    child: Column(
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
                          provider.maintain!.maintainName,
                          style: MyStyle().boldPrimary20(),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          provider.maintain!.maintainDetail,
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