import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/Model/Api/FireStore/banner_model.dart';
import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/View/Modal/modal_product.dart';
import 'package:charoz/View/Modal/modal_carousel.dart';
import 'package:charoz/Utility/Constant/my_image.dart';
import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View/Widget/show_image.dart';
import 'package:charoz/View/Widget/show_progress.dart';
import 'package:charoz/Utility/Variable/var_general.dart';
import 'package:charoz/View_Model/banner_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/shop_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final BannerViewModel bannerVM = Get.find<BannerViewModel>();
  final ProductViewModel prodVM = Get.find<ProductViewModel>();

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
                    buildProfile(),
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
    return GetBuilder<ShopViewModel>(
      builder: (vm) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (vm.shopStatus == 'เปิดบริการ') ...[
            Lottie.asset(MyImage.gifOpen, width: 15.w, height: 15.w),
            Text('สถานะร้านค้า : ${vm.shopStatus}',
                style: MyStyle().boldGreen18()),
            Lottie.asset(MyImage.gifOpen, width: 15.w, height: 15.w),
          ] else ...[
            Lottie.asset(MyImage.gifClosed, width: 15.w, height: 15.w),
            Text('สถานะร้านค้า : ${vm.shopStatus}',
                style: MyStyle().boldRed18()),
            Lottie.asset(MyImage.gifClosed, width: 15.w, height: 15.w),
          ]
        ],
      ),
    );
  }

  Widget buildCarouselList() {
    return GetBuilder<BannerViewModel>(
      builder: (vm) => vm.bannerList.isEmpty
          ? const ShowProgress()
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
      onTap: () => ModalCarousel().showModal(context, banner.url!),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        width: VariableGeneral.largeDevice ? 70.w : 100.w,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        child: ShowImage().showImage(banner.url!, BoxFit.cover),
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
            ? const ShowProgress()
            : ShowImage().showImage(vm.shopProfile!.url, BoxFit.cover),
      ),
    );
  }

  Widget buildSuggestList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: SizedBox(
        width: 100.w,
        height: 23.h,
        child: GetBuilder<ProductViewModel>(
          builder: (vm) => vm.productSuggestList.isEmpty
              ? const ShowProgress()
              : ListView.builder(
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
    return Card(
      color: product.status! ? Colors.white : Colors.grey.shade400,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          prodVM.setProductModel(product);
          ModalProduct().showModal(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: VariableGeneral.largeDevice ? 25.w : 30.w,
              height: 12.h,
              child: SizedBox(
                width: 30.w,
                height: 12.h,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ShowImage().showImage(product.image, BoxFit.cover),
                    ),
                    if (product.suggest!) ...[
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Column(
              children: [
                SizedBox(
                  width: 25.w,
                  child: Text(
                    product.name ?? '',
                    style: MyStyle().normalPrimary16(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'ราคา ${product.price?.toStringAsFixed(0) ?? 0.00}.-',
                  style: MyStyle().normalBlue16(),
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
          ? const ShowProgress()
          : Container(
              width: 100.w,
              color: Colors.yellow,
              padding: EdgeInsets.all(2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: VariableGeneral.largeDevice ? 70.w : 60.w,
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
              color: Colors.green.shade100,
              padding: EdgeInsets.all(2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Lottie.asset(MyImage.gifShopAnnounce,
                      width: 20.w, height: 20.w),
                  SizedBox(
                    width: VariableGeneral.largeDevice ? 70.w : 60.w,
                    child:
                        Text(vm.shop.announce, style: MyStyle().normalRed18()),
                  ),
                ],
              ),
            ),
    );
  }
}
