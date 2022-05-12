import 'package:charoz/screens/home/provider/home_provider.dart';
import 'package:charoz/screens/home/provider/suggest_provider.dart';
import 'package:charoz/screens/product/provider/product_provider.dart';
import 'package:charoz/screens/shop/provider/shop_provider.dart';
import 'package:charoz/screens/user/provider/user_provider.dart';
import 'package:charoz/services/route/route_page.dart';
import 'package:charoz/utils/constant/my_dialog.dart';
import 'package:charoz/utils/constant/my_image.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
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
  String? maintenance;
  bool load1 = false, load2 = false, load3 = false, load4 = false;

  @override
  void initState() {
    super.initState();
    getDataPreference();
  }

  Future getDataPreference() async {
    Provider.of<HomeProvider>(context, listen: false).getDeviceInfo();
    load1 =
        await Provider.of<SuggestProvider>(context, listen: false).initial();
    load2 = await Provider.of<HomeProvider>(context, listen: false).initial();
    load3 = await Provider.of<ShopProvider>(context, listen: false).initial();
    load4 =
        await Provider.of<ProductProvider>(context, listen: false).initial();
    maintenance = await Provider.of<HomeProvider>(context, listen: false)
        .getMaintenance(MyVariable.maintainStatus.toString());

    if (MyVariable.accountUid != "") {
      MyVariable.login = true;
      await Provider.of<UserProvider>(context, listen: false)
          .getUserWhereToken();
    } else {
      MyVariable.login = false;
    }

    if (maintenance == '0' || maintenance == '1') {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutePage.routeMaintenance, (route) => false);
    } else if (maintenance == '2' &&
        load1 == true &&
        load2 == true &&
        load3 == true &&
        load4 == true) {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutePage.routeHomeService, (route) => false);
    } else {
      MyDialog().doubleDialog(
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
