import 'package:charoz/screens/shop/model/shop_model.dart';
import 'package:charoz/screens/shop/model/time_model.dart';
import 'package:charoz/screens/shop/provider/shop_provider.dart';
import 'package:charoz/services/route/route_page.dart';
import 'package:charoz/utils/constant/my_image.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShopManage extends StatefulWidget {
  const ShopManage({Key? key}) : super(key: key);

  @override
  _ShopManageState createState() => _ShopManageState();
}

class _ShopManageState extends State<ShopManage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<ShopProvider>(
          builder: (context, sprovider, child) => Stack(
            children: [
              Positioned.fill(
                top: 50,
                child: SingleChildScrollView(
                  child: Container(
                    width: 100.w,
                    height: 85.h,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      itemCount: sprovider.shopsLength,
                      itemBuilder: (context, index) => buildShopItem(
                          sprovider.shops[index], sprovider.time, index),
                    ),
                  ),
                ),
              ),
              MyWidget().backgroundTitle(),
              MyWidget().title('ร้านค้าที่ดูแล'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShopItem(ShopModel shop, TimeModel time, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RoutePage.routeShopDetail);
        },
        child: Padding(
          padding: MyVariable.largeDevice
              ? const EdgeInsets.all(20)
              : const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MyVariable.largeDevice ? 120 : 80,
                height: MyVariable.largeDevice ? 120 : 80,
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
                Icons.edit_rounded,
                size: MyVariable.largeDevice ? 50 : 30,
                color: MyStyle.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
