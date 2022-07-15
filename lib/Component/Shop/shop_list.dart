import 'package:charoz/Component/Shop/shop_detail.dart';
import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShopList extends StatelessWidget {
  const ShopList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<ShopProvider>(
          builder: (context, sprovider, child) => sprovider.shopList == null
              ? const ShowProgress()
              : Stack(
                  children: [
                    Positioned.fill(
                      top: 8.h,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: 100.w,
                          height: 94.h,
                          child: ListView.builder(
                            itemCount: sprovider.shopList.length,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemBuilder: (context, index) => buildShopItem(
                                context, sprovider.shopList[index], index),
                          ),
                        ),
                      ),
                    ),
                    ScreenWidget().appBarTitle('ร้านค้าในระบบ'),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildShopItem(BuildContext context, ShopModel shop, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShopDetail(id: shop.shopId)));
        },
        child: Padding(
          padding: GlobalVariable.largeDevice
              ? const EdgeInsets.all(20)
              : const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: GlobalVariable.largeDevice ? 120 : 80,
                height: GlobalVariable.largeDevice ? 120 : 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(MyImage.shop),
                ),
              ),
              Text(
                shop.shopName,
                style: MyStyle().boldBlack16(),
              ),
              Icon(
                GlobalVariable.login
                    ? Icons.edit_rounded
                    : Icons.arrow_forward_ios_rounded,
                size: 25.sp,
                color: MyStyle.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
