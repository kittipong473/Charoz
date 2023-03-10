import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/View/Modal/edit_shop_admin.dart';
import 'package:charoz/View/Modal/edit_shop_manager.dart';
import 'package:charoz/Service/Initial/route_page.dart';
import 'package:charoz/Model/Util/Constant/my_style.dart';
import 'package:charoz/Model/Util/Variable/var_data.dart';
import 'package:charoz/View/Modal/modal_shop.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/Model/Util/Variable/var_general.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:charoz/View_Model/time_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShopDetail extends StatefulWidget {
  const ShopDetail({Key? key}) : super(key: key);

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  final ShopViewModel shopVM = Get.find<ShopViewModel>();
  final UserViewModel userVM = Get.find<UserViewModel>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    userVM.readManagerById(shopVM.shop.managerid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        appBar: VariableGeneral.role == 1
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
            VariableGeneral.role == 3 || VariableGeneral.role == 0
                ? FloatingActionButton(
                    onPressed: () {
                      if (VariableGeneral.role == 0) {
                        EditShopAdmin()
                            .openModalEditShopAdmin(context, shopVM.shop);
                      } else if (VariableGeneral.role == 3) {
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
      onTap: () => ModalShop().showModal(context, shopimage),
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
      child: GetBuilder<TimeViewModel>(
        builder: (vm) => Column(
          children: [
            Text('ตารางเวลาเปิด-ปิดของร้านค้า',
                style: MyStyle().boldPrimary18()),
            SizedBox(height: 2.h),
            fragmentShop('วันจันทร์', vm.time.mon),
            fragmentShop('วันอังคาร', vm.time.tue),
            fragmentShop('วันพุธ', vm.time.wed),
            fragmentShop('วันพฤหัสบดี', vm.time.thu),
            fragmentShop('วันศุกร์', vm.time.fri),
            fragmentShop('วันเสาร์', vm.time.sat),
            fragmentShop('วันอาทิตย์', vm.time.sun),
          ],
        ),
      ),
    );
  }

  Widget fragmentShop(String dayThai, String? dayValue) {
    if (dayValue == null) {
      return Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dayThai, style: MyStyle().boldBlack16()),
            Text('ปิดบริการ', style: MyStyle().normalBlack16()),
          ],
        ),
      );
    } else {
      List<String> periodTime = MyFunction().convertToList(dayValue);
      return Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dayThai, style: MyStyle().boldBlack16()),
            Text(
                '${periodTime[0].substring(0, 5)} น. - ${periodTime[1].substring(0, 5)} น.',
                style: MyStyle().normalBlack16()),
          ],
        ),
      );
    }
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
    return SizedBox(
      width: 60.w,
      child: GetBuilder<UserViewModel>(
        builder: (vm) => Column(
          children: [
            Text('ติดต่อกับร้านค้า', style: MyStyle().boldPrimary18()),
            SizedBox(height: 1.h),
            Text(
              'คุณ ${vm.manager?.firstname ?? ''}',
              style: MyStyle().normalBlack16(),
            ),
            Text(
              'เบอร์โทร : ${vm.manager?.phone ?? ''}',
              style: MyStyle().normalBlack16(),
            ),
          ],
        ),
      ),
    );
  }
}
