import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/Component/Shop/Dialog/carousel_detail.dart';
import 'package:charoz/Component/Shop/Modal/edit_shop_admin.dart';
import 'package:charoz/Component/Shop/Modal/edit_shop_manager.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Provider/user_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShopDetail extends StatelessWidget {
  const ShopDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        appBar: MyVariable.role == 'customer'
            ? ScreenWidget().appBarTheme('รายละเอียดร้านอาหาร')
            : null,
        body: Stack(
          children: [
            Positioned.fill(
              top: 2.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildShopImageList(),
                    SizedBox(height: 3.h),
                    buildTime(),
                    SizedBox(height: 3.h),
                    buildAddress(),
                    SizedBox(height: 3.h),
                    buildContact(),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton:
            MyVariable.role == 'manager' || MyVariable.role == 'admin'
                ? Consumer<ShopProvider>(
                    builder: (_, provider, __) => FloatingActionButton(
                      onPressed: () {
                        if (MyVariable.role == 'admin') {
                          EditShopAdmin()
                              .openModalEditShopAdmin(context, provider.shop);
                        } else if (MyVariable.role == 'manager') {
                          EditShopManager()
                              .openModalEditShopManager(context, provider.shop);
                        }
                      },
                      backgroundColor: MyStyle.bluePrimary,
                      child: const Icon(Icons.edit_location_alt_rounded,
                          color: Colors.white),
                    ),
                  )
                : FloatingActionButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, RoutePage.routeShopMap),
                    backgroundColor: MyStyle.bluePrimary,
                    child: const Icon(Icons.location_pin, color: Colors.white),
                  ),
      ),
    );
  }

  Widget buildShopImageList() {
    return CarouselSlider.builder(
      options: CarouselOptions(height: 30.h, autoPlay: true),
      itemCount: MyVariable.carouselShopImage.length,
      itemBuilder: (context, index, realIndex) => buildShopImageItem(
          context, MyVariable.carouselShopImage[index], index),
    );
  }

  Widget buildShopImageItem(BuildContext context, String shopimage, int index) {
    return InkWell(
      onTap: () => CarouselDetail().dialogShop(context, shopimage),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(shopimage, fit: BoxFit.fill),
        ),
      ),
    );
  }

  Widget buildTime() {
    return SizedBox(
      width: 80.w,
      child: Column(
        children: [
          Text('ตารางเวลาเปิด-ปิดของร้านค้า', style: MyStyle().boldPrimary18()),
          SizedBox(height: 2.h),
          fragmentShopOpen('วันจันทร์'),
          fragmentShopOpen('วันอังคาร'),
          fragmentShopOpen('วันพุธ'),
          fragmentShopOpen('วันพฤหัสบดี'),
          fragmentShopOpen('วันศุกร์'),
          fragmentShopOpen('วันเสาร์'),
          fragmentShopClose('วันอาทิตย์'),
        ],
      ),
    );
  }

  Widget fragmentShopOpen(String day) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Consumer<ShopProvider>(
        builder: (_, provider, __) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(day, style: MyStyle().boldBlack16()),
            Text(
                '${MyFunction().convertToOpenClose(provider.shop.open)} น. - ${MyFunction().convertToOpenClose(provider.shop.close)} น.',
                style: MyStyle().normalBlack16()),
          ],
        ),
      ),
    );
  }

  Widget fragmentShopClose(String day) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: MyStyle().boldBlack16()),
          Text('ปิดบริการ', style: MyStyle().normalBlack16()),
        ],
      ),
    );
  }

  Widget buildAddress() {
    return SizedBox(
      width: 60.w,
      child: Consumer<ShopProvider>(
        builder: (_, provider, __) => Column(
          children: [
            Text('ที่อยู่ตำแหน่งของร้านค้า', style: MyStyle().boldPrimary18()),
            SizedBox(height: 2.h),
            Text(
              provider.shop.address,
              style: MyStyle().normalBlack16(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContact() {
    return SizedBox(
      width: 60.w,
      child: Consumer2<ShopProvider, UserProvider>(
        builder: (context, sprovider, uprovider, __) {
          Provider.of<UserProvider>(context, listen: false)
              .readManagerById(sprovider.shop.managerid);
          if (uprovider.manager == null) {
            return const ShowProgress();
          } else {
            return Column(
              children: [
                Text('ติดต่อกับร้านค้า', style: MyStyle().boldPrimary18()),
                SizedBox(height: 1.h),
                Text(
                  'คุณ ${uprovider.manager.firstname} ${uprovider.manager.lastname}',
                  style: MyStyle().normalBlack16(),
                ),
                Text(
                  'เบอร์โทร : ${uprovider.manager.phone}',
                  style: MyStyle().normalBlack16(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
