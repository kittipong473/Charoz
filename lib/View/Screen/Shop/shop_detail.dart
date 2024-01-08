import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View/Modal/edit_shop_admin.dart';
import 'package:charoz/Service/Routes/route_page.dart';
import 'package:charoz/View/Modal/modal_shop.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/banner_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
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
  final bannerVM = Get.find<BannerViewModel>();
  final shopVM = Get.find<ShopViewModel>();
  final userVM = Get.find<UserViewModel>();
  List<String> dayTitle = [
    'จันทร์',
    'อังคาร',
    'พุธ',
    'พฤหัสบดี',
    'ศุกร์',
    'เสาร์',
    'อาทิตย์'
  ];
  List<String> dayValue = [];

  @override
  void initState() {
    super.initState();
    bannerVM.initCarouselList();
    userVM.readManagerById(shopVM.shop.managerid);
    dayValue = [
      shopVM.shop.mon ?? 'ปิดบริการ',
      shopVM.shop.tue ?? 'ปิดบริการ',
      shopVM.shop.wed ?? 'ปิดบริการ',
      shopVM.shop.thu ?? 'ปิดบริการ',
      shopVM.shop.fri ?? 'ปิดบริการ',
      shopVM.shop.sat ?? 'ปิดบริการ',
      shopVM.shop.sun ?? 'ปิดบริการ'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: userVM.role != 1
            ? null
            : MyWidget().appBarTheme(title: 'รายละเอียดร้านอาหาร'),
        backgroundColor: MyStyle.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 3.h),
              buildShopImageList(),
              SizedBox(height: 3.h),
              Text('ตารางเวลาเปิด-ปิดของร้านค้า',
                  style: MyStyle.textStyle(
                      size: 18, color: MyStyle.orangePrimary, bold: true)),
              SizedBox(height: 2.h),
              buildTimeList(),
              buildAddress(),
              SizedBox(height: 3.h),
              buildContact(),
              SizedBox(height: 2.h),
            ],
          ),
        ),
        floatingActionButton: userVM.role <= 2
            ? FloatingActionButton(
                onPressed: () => Get.toNamed(RoutePage.routeShopMap),
                backgroundColor: MyStyle.bluePrimary,
                child: const Icon(Icons.location_pin, color: Colors.white),
              )
            : FloatingActionButton(
                onPressed: () => EditShopAdmin()
                    .openModalEditShopAdmin(context, shopVM.shop),
                backgroundColor: MyStyle.bluePrimary,
                child: const Icon(Icons.edit_location_alt_rounded,
                    color: Colors.white),
              ),
      ),
    );
  }

  Widget buildShopImageList() {
    return CarouselSlider.builder(
      options: CarouselOptions(height: 30.h, autoPlay: true),
      itemCount: bannerVM.shopImageList.length,
      itemBuilder: (context, index, realIndex) =>
          buildShopImageItem(bannerVM.shopImageList[index], index),
    );
  }

  Widget buildShopImageItem(String shopimage, int index) {
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

  Widget buildTimeList() {
    return SizedBox(
      height: 48.h,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
        separatorBuilder: (_, __) => const Divider(
          color: MyStyle.blackPrimary,
        ),
        itemCount: 7,
        itemBuilder: (_, index) =>
            buildTimeItem(dayTitle[index], dayValue[index]),
      ),
    );
  }

  Widget buildTimeItem(String title, String value) {
    if (value == 'ปิดบริการ') {
      return Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
            Text(value,
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
          ],
        ),
      );
    } else {
      List<String> periodTime = MyFunction().convertToList(value: value);
      return Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
            Text(
                '${periodTime[0].substring(0, 5)} น. - ${periodTime[1].substring(0, 5)} น.',
                style:
                    MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary)),
          ],
        ),
      );
    }
  }

  Widget buildAddress() {
    return Column(
      children: [
        Text('ที่อยู่ตำแหน่งของร้านค้า',
            style: MyStyle.textStyle(
                size: 18, color: MyStyle.orangePrimary, bold: true)),
        SizedBox(height: 2.h),
        SizedBox(
          width: 70.w,
          child: Text(
            shopVM.shop.address,
            style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget buildContact() {
    return GetBuilder<UserViewModel>(
      builder: (vm) => vm.manager == null
          ? MyWidget().showProgress()
          : Column(
              children: [
                Text('ติดต่อกับร้านค้า',
                    style: MyStyle.textStyle(
                        size: 18, color: MyStyle.orangePrimary, bold: true)),
                SizedBox(height: 1.h),
                Text(
                  'คุณ ${vm.manager?.firstname ?? ''}',
                  style:
                      MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
                ),
                Text(
                  'เบอร์โทร : ${vm.manager?.phone ?? ''}',
                  style:
                      MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
                ),
              ],
            ),
    );
  }
}
