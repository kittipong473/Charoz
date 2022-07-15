import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Api/PHP/config_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Function/load_data.dart';
import 'package:charoz/Utilty/global_variable.dart';
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
    loadData();
    super.initState();
  }

  Future loadData() async {
    await checkLoginStatus();
    await LoadData().getDataByRole(context);

    int maintenance = await ConfigApi().getOnlyStatusWhereShop(shopid: 1);
    // int maintenance = 1;

    if (maintenance == 0 || maintenance == 1) {
      Provider.of<ConfigProvider>(context, listen: false)
          .getMaintenance(maintenance);
      Future.delayed(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routeMaintenancePage, (route) => false);
      });
    } else if (maintenance == 2) {
      Provider.of<UserProvider>(context, listen: false)
          .checkUserPinSetting(context);
      Future.delayed(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routePageNavigation, (route) => false);
      });
    } else {
      DialogAlert().doubleDialog(
          context, 'เซิฟเวอร์มีปัญหา', 'กรุณาเข้าใช้งานในภายหลัง');
    }
  }

  Future checkLoginStatus() async {
    if (GlobalVariable.accountUid != "") {
      await Provider.of<UserProvider>(context, listen: false)
          .getUserWhereToken();
    } else {
      GlobalVariable.login = false;
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
