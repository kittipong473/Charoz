import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Routes/route_page.dart';
import 'package:charoz/Service/Library/preference.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final userVM = Get.find<UserViewModel>();
  final shopVM = Get.find<ShopViewModel>();
  final prodVM = Get.find<ProductViewModel>();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future checkLogin() async {
    await Preferences().init();
    String? id = Preferences().getUserID();
    if (id != null) {
      bool status = await userVM.getUserPreference(context, id);
      if (status) {
        userVM.setIsLogin(true);
        initData();
      } else {
        userVM.setIsLogin(false);
        Preferences().removeUserID();
        initData();
        DialogAlert(context).dialogStatus(
          type: 2,
          title: 'คุณถูกระงับการใช้งาน',
          body: 'โปรดติดต่อสอบถามผู้ดูแลระบบเมื่อมีข้อสงสัย',
        );
      }
    } else {
      userVM.setIsLogin(false);
      initData();
    }
  }

  void initData() async {
    await shopVM.readShopModel();
    await prodVM.readProductAllList();
    Get.offNamed(RoutePage.routePageNavigation);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Charoz Application\nยินดีต้อนรับ',
                style: MyStyle.textStyle(
                    size: 20, color: MyStyle.orangePrimary, bold: true),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              MyWidget()
                  .showImage(path: MyImage.imgLogo3, width: 50.w, height: 50.w),
              SizedBox(height: 5.h),
              MyWidget().showImage(
                  path: MyImage.lotSplash, width: 40.w, height: 40.w),
            ],
          ),
        ),
      ),
    );
  }
}
