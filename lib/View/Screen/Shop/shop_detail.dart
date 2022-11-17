import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/View/Dialog/carousel_detail.dart';
import 'package:charoz/View/Modal/edit_shop_admin.dart';
import 'package:charoz/View/Modal/edit_shop_manager.dart';
import 'package:charoz/Model/Service/Route/route_page.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/Util/Variable/var_data.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/show_progress.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final ShopViewModel shopVM = Get.find<ShopViewModel>();
final UserViewModel userVM = Get.find<UserViewModel>();

class ShopDetail extends StatelessWidget {
  const ShopDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        appBar: VariableGeneral.role == 'customer'
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
            VariableGeneral.role == 'manager' || VariableGeneral.role == 'admin'
                ? FloatingActionButton(
                    onPressed: () {
                      if (VariableGeneral.role == 'admin') {
                        EditShopAdmin()
                            .openModalEditShopAdmin(context, shopVM.shop);
                      } else if (VariableGeneral.role == 'manager') {
                        EditShopManager()
                            .openModalEditShopManager(context, shopVM.shop);
                      }
                    },
                    backgroundColor: MyStyle.bluePrimary,
                    child: const Icon(Icons.edit_location_alt_rounded,
                        color: Colors.white),
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
      itemCount: VariableData.carouselShopImage.length,
      itemBuilder: (context, index, realIndex) => buildShopImageItem(
          context, VariableData.carouselShopImage[index], index),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: MyStyle().boldBlack16()),
          Text(
              '${MyFunction().convertToOpenClose(shopVM.shop.open)} น. - ${MyFunction().convertToOpenClose(shopVM.shop.close)} น.',
              style: MyStyle().normalBlack16()),
        ],
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
      child: Column(
        children: [
          Text('ที่อยู่ตำแหน่งของร้านค้า', style: MyStyle().boldPrimary18()),
          SizedBox(height: 2.h),
          Text(
            shopVM.shop.address,
            style: MyStyle().normalBlack16(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildContact() {
    userVM.readManagerById(shopVM.shop.managerid);
    return SizedBox(
      width: 60.w,
      child: Column(
        children: [
          Text('ติดต่อกับร้านค้า', style: MyStyle().boldPrimary18()),
          SizedBox(height: 1.h),
          Text(
            'คุณ ${userVM.manager.firstname}',
            style: MyStyle().normalBlack16(),
          ),
          Text(
            'เบอร์โทร : ${userVM.manager.phone}',
            style: MyStyle().normalBlack16(),
          ),
        ],
      ),
    );
  }
}
