import 'package:charoz/Config/maintenance.dart';
import 'package:charoz/Model/address_model.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Api/address_api.dart';
import 'package:charoz/Service/Api/config_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    if (MyVariable.accountUid != "") {
      MyVariable.login = true;
      await Provider.of<UserProvider>(context, listen: false)
          .getUserWhereToken();
    } else {
      MyVariable.login = false;
    }

    // String maintenance = await ConfigApi().getOnlyStatusWhereShop(shopid: 1);
    int maintenance = 2;

    if (maintenance == 0 || maintenance == 1) {
      Future.delayed(Duration.zero, () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MaintenancePage(status: maintenance)),
            (route) => false);
      });
    } else if (maintenance == 2) {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routePageNavigation, (route) => false);
      });
    } else {
      DialogAlert().doubleDialog(
          context, 'เซิฟเวอร์มีปัญหา', 'กรุณาเข้าใช้งานในภายหลัง');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.light,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                MyImage.logo3,
                width: 50.w,
                height: 50.w,
              ),
              SizedBox(height: 3.h),
              Lottie.asset(MyImage.gifSplash, width: 40.w, height: 40.w),
            ],
          ),
        ),
      ),
    );
  }
}
