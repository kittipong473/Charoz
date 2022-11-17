import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/View/Dialog/product_detail.dart';
import 'package:charoz/View/Dialog/carousel_detail.dart';
import 'package:charoz/Model/Data/banner_model.dart';
import 'package:charoz/Model/Data/product_model.dart';
import 'package:charoz/Util/Constant/my_image.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View/Widget/show_image.dart';
import 'package:charoz/View/Widget/show_progress.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View_Model/config_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final ConfigViewModel confVM = Get.find<ConfigViewModel>();
final ProductViewModel prodVM = Get.find<ProductViewModel>();
final ShopViewModel shopVM = Get.find<ShopViewModel>();

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  void getData() async {
    confVM.readBannerList();
    prodVM.readProductSuggestList();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Stack(
          children: [
            Positioned.fill(
              top: 1.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildStatus(),
                    SizedBox(height: 1.h),
                    buildCarouselList(),
                    SizedBox(height: 3.h),
                    buildVideo(),
                    SizedBox(height: 3.h),
                    ScreenWidget().buildTitlePadding('อาหารแนะนำ'),
                    buildSuggestList(),
                    SizedBox(height: 3.h),
                    buildDetail(),
                    buildAnnounce(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (shopVM.shopStatus == 'เปิดบริการ') ...[
          Lottie.asset(MyImage.gifOpen, width: 15.w, height: 15.w),
          Text('สถานะร้านค้า : ${shopVM.shopStatus}',
              style: MyStyle().boldGreen18()),
          Lottie.asset(MyImage.gifOpen, width: 15.w, height: 15.w),
        ] else ...[
          Lottie.asset(MyImage.gifClosed, width: 15.w, height: 15.w),
          Text('สถานะร้านค้า : ${shopVM.shopStatus}',
              style: MyStyle().boldRed18()),
          Lottie.asset(MyImage.gifClosed, width: 15.w, height: 15.w),
        ]
      ],
    );
  }

  Widget buildCarouselList() {
    return GetBuilder<ConfigViewModel>(
      builder: (vm) => vm.bannerList.isEmpty
          ? const ShowProgress()
          : CarouselSlider.builder(
              options: CarouselOptions(
                height: 16.h,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              itemCount: confVM.bannerList.length,
              itemBuilder: (context, index, realIndex) =>
                  buildCarouselItem(context, vm.bannerList[index]),
            ),
    );
  }

  Widget buildCarouselItem(BuildContext context, BannerModel banner) {
    return GestureDetector(
      onTap: () => CarouselDetail().dialogCarousel(context, banner.url),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        width: VariableGeneral.largeDevice! ? 70.w : 100.w,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        child: ShowImage().showImage(banner.url),
      ),
    );
  }

  Widget buildVideo() {
    return Container(
      width: 100.w,
      height: 20.h,
      color: Colors.black,
      child: GetBuilder<ShopViewModel>(
        builder: (vm) => vm.shop == null
            ? const ShowProgress()
            : ShowImage().showImage(vm.shop.image),
      ),
    );
  }

  Widget buildSuggestList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: SizedBox(
        width: 100.w,
        height: 25.h,
        child: GetBuilder<ProductViewModel>(
          builder: (vm) => vm.productList.isEmpty
              ? const ShowProgress()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: vm.productList.length,
                  itemBuilder: (context, index) =>
                      buildSuggestItem(context, prodVM.productList[index]),
                ),
        ),
      ),
    );
  }

  Widget buildSuggestItem(BuildContext context, ProductModel product) {
    return Card(
      color: product.status == 0 ? Colors.grey.shade400 : Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => ProductDetail().dialogProduct(context, product),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 30.w,
              height: 25.w,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ShowImage().showImage(product.image),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15.sp,
                      child: Lottie.asset(MyImage.gifStar),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 25.w,
              child: Text(
                product.name,
                style: MyStyle().normalPrimary16(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              'ราคา ${product.price.toStringAsFixed(0)}.-',
              style: MyStyle().normalBlue16(),
            ),
            Text(
              'สถานะ : ${product.status == 0 ? 'หมด' : 'ขาย'}',
              style: MyStyle().normalBlack14(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetail() {
    return GetBuilder<ShopViewModel>(
      builder: (vm) => vm.shop == null
          ? const ShowProgress()
          : Container(
              width: 100.w,
              color: Colors.yellow,
              padding: EdgeInsets.all(2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: VariableGeneral.largeDevice! ? 70.w : 60.w,
                    child:
                        Text(vm.shop.detail, style: MyStyle().normalPurple18()),
                  ),
                  Lottie.asset(MyImage.gifShopDetail,
                      width: 20.w, height: 20.w),
                ],
              ),
            ),
    );
  }

  Widget buildAnnounce() {
    return GetBuilder<ShopViewModel>(
      builder: (vm) => vm.shop == null
          ? const ShowProgress()
          : Container(
              width: 100.w,
              color: Colors.green.shade200,
              padding: EdgeInsets.all(2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Lottie.asset(MyImage.gifShopAnnounce,
                      width: 20.w, height: 20.w),
                  SizedBox(
                    width: VariableGeneral.largeDevice! ? 70.w : 60.w,
                    child:
                        Text(vm.shop.announce, style: MyStyle().normalRed18()),
                  ),
                ],
              ),
            ),
    );
  }
}
