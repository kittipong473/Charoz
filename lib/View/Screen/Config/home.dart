import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/Model/Api/FireStore/banner_model.dart';
import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View/Screen/Config/Dialog/banner_detail.dart';
import 'package:charoz/View/Screen/Product/Dialog/product_detail.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/banner_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bannerVM = Get.find<BannerViewModel>();
  final prodVM = Get.find<ProductViewModel>();
  final shopVM = Get.find<ShopViewModel>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    bannerVM.readShopProfile();
    bannerVM.readBannerList();
    prodVM.getProductSuggestList();
  }

  @override
  void dispose() {
    prodVM.clearSuggestData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildStatus(),
              SizedBox(height: 1.h),
              buildCarouselList(),
              SizedBox(height: 3.h),
              buildProfile(),
              SizedBox(height: 3.h),
              MyWidget().buildTitle(title: 'อาหารแนะนำ', padding: true),
              buildSuggestList(),
              SizedBox(height: 3.h),
              buildDetail(),
              buildAnnounce(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (shopVM.shopStatus == 'เปิดบริการ') ...[
          MyWidget()
              .showImage(path: MyImage.lotOpen, width: 15.w, height: 15.w),
          Text(
            'สถานะร้านค้า : ${shopVM.shopStatus}',
            style: MyStyle.textStyle(
                size: 20, color: MyStyle.greenPrimary, bold: true),
          ),
          MyWidget()
              .showImage(path: MyImage.lotOpen, width: 15.w, height: 15.w),
        ] else ...[
          MyWidget()
              .showImage(path: MyImage.lotClosed, width: 15.w, height: 15.w),
          Text(
            'สถานะร้านค้า : ${shopVM.shopStatus}',
            style: MyStyle.textStyle(
                size: 20, color: MyStyle.redPrimary, bold: true),
          ),
          MyWidget()
              .showImage(path: MyImage.lotClosed, width: 15.w, height: 15.w),
        ]
      ],
    );
  }

  Widget buildCarouselList() {
    return GetBuilder<BannerViewModel>(
      builder: (vm) => vm.bannerList.isEmpty
          ? MyWidget().showProgress()
          : CarouselSlider.builder(
              options: CarouselOptions(
                height: 16.h,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              itemCount: vm.bannerList.length,
              itemBuilder: (context, index, realIndex) =>
                  buildCarouselItem(vm.bannerList[index]),
            ),
    );
  }

  Widget buildCarouselItem(BannerModel banner) {
    return GestureDetector(
      onTap: () => BannerDetail(context).dialogBanner(path: banner.url!),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        width: 100.w,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        child: MyWidget()
            .showImage(path: banner.url!, fit: BoxFit.cover, radius: 10),
      ),
    );
  }

  Widget buildProfile() {
    return Container(
      width: 100.w,
      height: 20.h,
      color: Colors.black,
      child: GetBuilder<BannerViewModel>(
        builder: (vm) => vm.shopProfile == null
            ? MyWidget().showProgress()
            : MyWidget()
                .showImage(path: vm.shopProfile!.url!, fit: BoxFit.cover),
      ),
    );
  }

  Widget buildSuggestList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: GetBuilder<ProductViewModel>(
        builder: (vm) => vm.productSuggestList.isEmpty
            ? MyWidget().showProgress()
            : SizedBox(
                width: 100.w,
                height: 23.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: vm.productSuggestList.length,
                  itemBuilder: (context, index) =>
                      buildSuggestItem(prodVM.productSuggestList[index]),
                ),
              ),
      ),
    );
  }

  Widget buildSuggestItem(ProductModel product) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: product.status! ? Colors.white : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          prodVM.setProductModel(product);
          ProductDetail(context).dialogProduct();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 30.w,
              height: 12.h,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: MyWidget().showImage(
                        path: product.image!, fit: BoxFit.cover, radius: 10),
                  ),
                  if (product.suggest!) ...[
                    Positioned(
                      top: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15.sp,
                        child: MyWidget().showImage(path: MyImage.lotStar),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Column(
              children: [
                SizedBox(
                  width: 25.w,
                  child: Text(
                    product.name ?? '',
                    style:
                        MyStyle.textStyle(size: 14, color: MyStyle.bluePrimary),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${product.price?.toStringAsFixed(0) ?? 0.00}.-',
                  style:
                      MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetail() {
    return GetBuilder<ShopViewModel>(
      builder: (vm) => vm.shop == null
          ? MyWidget().showProgress()
          : Container(
              width: 100.w,
              color: Colors.yellow,
              padding: EdgeInsets.all(2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 60.w,
                    child: Text(vm.shop.detail,
                        style: MyStyle.textStyle(
                            size: 18, color: MyStyle.greenPrimary)),
                  ),
                  MyWidget().showImage(
                      path: MyImage.lotShopDetail, width: 20.w, height: 20.w),
                ],
              ),
            ),
    );
  }

  Widget buildAnnounce() {
    return GetBuilder<ShopViewModel>(
      builder: (vm) => vm.shop == null
          ? MyWidget().showProgress()
          : Container(
              width: 100.w,
              color: Colors.green.shade100,
              padding: EdgeInsets.all(2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyWidget().showImage(
                      path: MyImage.lotShopAnnounce, width: 20.w, height: 20.w),
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      vm.shop.announce,
                      style: MyStyle.textStyle(
                          size: 18, color: MyStyle.redPrimary),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
