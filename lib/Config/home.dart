import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/Component/Product/Dialog/product_detail.dart';
import 'package:charoz/Component/Shop/Dialog/carousel_detail.dart';
import 'package:charoz/Model_Main/banner_model.dart';
import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Model_Main/product_model.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Future getData(BuildContext context) async {
    await Provider.of<ConfigProvider>(context, listen: false).readBannerList();
    await Provider.of<ProductProvider>(context, listen: false)
        .readProductSuggestList();
    await Provider.of<ProductProvider>(context, listen: false).readProductAllList();
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
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
    return Consumer<ShopProvider>(
      builder: (_, provider, __) => provider.shopStatus == null
          ? const ShowProgress()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (provider.shopStatus == 'เปิดบริการ') ...[
                  Lottie.asset(MyImage.gifOpen, width: 15.w, height: 15.w),
                  Text('สถานะร้านค้า : ${provider.shopStatus}',
                      style: MyStyle().boldGreen18()),
                  Lottie.asset(MyImage.gifOpen, width: 15.w, height: 15.w),
                ] else ...[
                  Lottie.asset(MyImage.gifClosed, width: 15.w, height: 15.w),
                  Text('สถานะร้านค้า : ${provider.shopStatus}',
                      style: MyStyle().boldRed18()),
                  Lottie.asset(MyImage.gifClosed, width: 15.w, height: 15.w),
                ]
              ],
            ),
    );
  }

  Widget buildCarouselList() {
    return Consumer<ConfigProvider>(
      builder: (_, provider, __) => provider.bannerList == null
          ? const ShowProgress()
          : CarouselSlider.builder(
              options: CarouselOptions(
                height: 16.h,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              itemCount: provider.bannerList.length,
              itemBuilder: (context, index, realIndex) =>
                  buildCarouselItem(context, provider.bannerList[index], index),
            ),
    );
  }

  Widget buildCarouselItem(
      BuildContext context, BannerModel banner, int index) {
    return InkWell(
      onTap: () => CarouselDetail().dialogCarousel(context, banner.url),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        width: MyVariable.largeDevice ? 70.w : 100.w,
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
      child: Consumer<ShopProvider>(
        builder: (_, provider, __) => provider.shop == null
            ? const ShowProgress()
            : ShowImage().showImage(provider.shop.image),
      ),
    );
  }

  Widget buildSuggestList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: SizedBox(
        width: 100.w,
        height: 25.h,
        child: Consumer<ProductProvider>(
          builder: (_, provider, __) => provider.productList == null
              ? const ShowProgress()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.productList.length,
                  itemBuilder: (context, index) => buildSuggestItem(
                      context, provider.productList[index], index),
                ),
        ),
      ),
    );
  }

  Widget buildSuggestItem(
      BuildContext context, ProductModel product, int index) {
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
            Text(
              MyFunction().cutWord10(product.name),
              style: MyStyle().normalPrimary16(),
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
    return Container(
      width: 100.w,
      color: Colors.yellow,
      padding: EdgeInsets.all(2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MyVariable.largeDevice ? 70.w : 60.w,
            child: Consumer<ShopProvider>(
              builder: (_, provider, __) => provider.shop == null
                  ? const ShowProgress()
                  : Text(provider.shop.detail,
                      style: MyStyle().normalPurple18()),
            ),
          ),
          Icon(Icons.store_mall_directory_rounded,
              color: Colors.purple.shade700, size: 35.sp),
        ],
      ),
    );
  }

  Widget buildAnnounce() {
    return Container(
      width: 100.w,
      color: Colors.green.shade200,
      padding: EdgeInsets.all(2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.campaign_rounded, color: Colors.red.shade700, size: 35.sp),
          SizedBox(
            width: MyVariable.largeDevice ? 70.w : 60.w,
            child: Consumer<ShopProvider>(
              builder: (_, provider, __) => provider.shop == null
                  ? const ShowProgress()
                  : Text(provider.shop.announce,
                      style: MyStyle().normalRed18()),
            ),
          ),
        ],
      ),
    );
  }
}
