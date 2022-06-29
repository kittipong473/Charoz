import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShopList extends StatefulWidget {
  const ShopList({Key? key}) : super(key: key);

  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    Provider.of<ShopProvider>(context, listen: false).getAllShop();
  }

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
                      top: 6.h,
                      child: SingleChildScrollView(
                        child: Container(
                          width: 100.w,
                          height: 94.h,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            itemCount: sprovider.shopList.length,
                            itemBuilder: (context, index) =>
                                buildShopItem(sprovider.shopList[index], index),
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

  Widget buildShopItem(ShopModel shop, int index) {
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
                MyVariable.login
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