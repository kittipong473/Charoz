import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/Component/Product/Dialog/product_detail.dart';
import 'package:charoz/Component/Shop/Dialog/carousel_detail.dart';
import 'package:charoz/Model/banner_model.dart';
import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // VideoPlayerController? videoPlayerController;
  // late AnimationController animationController;
  Animation<Matrix4>? animation;
  List<String> types = [];

  @override
  void initState() {
    getData();
    // getVideo();
    super.initState();
  }

  Future getData() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .getProductSuggest();
  }

  // void getVideo() {
  //   transformationController = TransformationController();
  //   animationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 200),
  //   )..addListener(() => transformationController.value = animation!.value);
  // }

  // void setVideo(String url) {
  //   videoPlayerController =
  //       VideoPlayerController.network('${RouteApi.domainVideo}$url')
  //         ..initialize().then(
  //           (value) {
  //             videoPlayerController!.play();
  //             videoPlayerController!.setVolume(0.25);
  //             videoPlayerController!.setLooping(true);
  //           },
  //         );
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   transformationController.dispose();
  //   animationController.dispose();
  //   if (types[1] == 'mp3' || types[1] == 'mp4') {
  //     videoPlayerController!.dispose();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer3<ShopProvider, ConfigProvider, ProductProvider>(
          builder: (_, sprovider, cprovider, oprovider, __) =>
              sprovider.shop == null ||
                      sprovider.shopStatus == null ||
                      cprovider.bannerList == null ||
                      oprovider.productList == null
                  ? const ShowProgress()
                  : Stack(
                      children: [
                        Positioned.fill(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 8.h),
                                buildStatus(sprovider.shopStatus),
                                SizedBox(height: 1.h),
                                buildCarouselList(cprovider.bannerList),
                                SizedBox(height: 3.h),
                                buildVideo(sprovider.shop.shopImage),
                                SizedBox(height: 3.h),
                                ScreenWidget().buildTitlePadding('อาหารแนะนำ'),
                                buildSuggestList(oprovider.productList),
                                SizedBox(height: 3.h),
                                ScreenWidget()
                                    .buildTitlePadding('เลือกดูประเภทอาหาร'),
                                SizedBox(height: 2.h),
                                buildChip(),
                                SizedBox(height: 3.h),
                                buildDetail(sprovider.shop.shopDetail),
                                buildAnnounce(sprovider.shop.shopAnnounce),
                              ],
                            ),
                          ),
                        ),
                        ScreenWidget().appBarTitle('Charoz Steak House'),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget buildStatus(String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (status == 'เปิดบริการ') ...[
          Lottie.asset(MyImage.gifOpen, width: 30.sp, height: 30.sp),
          Text('สถานะร้านค้า : $status', style: MyStyle().boldGreen18()),
          Lottie.asset(MyImage.gifOpen, width: 30.sp, height: 30.sp),
        ] else ...[
          Lottie.asset(MyImage.gifClosed, width: 30.sp, height: 30.sp),
          Text('สถานะร้านค้า : $status', style: MyStyle().boldRed18()),
          Lottie.asset(MyImage.gifClosed, width: 30.sp, height: 30.sp),
        ]
      ],
    );
  }

  Widget buildCarouselList(List bannerList) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 16.h,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      itemCount: bannerList.length,
      itemBuilder: (context, index, realIndex) =>
          buildCarouselItem(bannerList[index], index),
    );
  }

  Widget buildCarouselItem(BannerModel banner, int index) {
    return InkWell(
      onTap: () => CarouselDetail().dialogCarousel(context, banner.bannerUrl),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        width: GlobalVariable.largeDevice ? 70.w : 100.w,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        child: ShowImage().showBanner(banner.bannerUrl),
      ),
    );
  }

  Widget buildVideo(String path) {
    return Container(
      width: 100.w,
      height: 20.h,
      color: Colors.black,
      child:
          // type == 'mp3' || type == 'mp4'
          //     ? videoPlayerController == null
          //         ? const ShowProgress()
          //         : VideoPlayer(videoPlayerController!)
          //     :
          ShowImage().showShop(path),
    );
  }

  Widget buildSuggestList(List productList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 100.w,
        height: 25.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: (context, index) =>
              buildSuggestItem(productList[index], index),
        ),
      ),
    );
  }

  Widget buildSuggestItem(ProductModel product, int index) {
    return Card(
      color: product.productStatus == 0 ? Colors.grey.shade400 : Colors.white,
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
                    child: ShowImage().showProduct(product.productImage),
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
              MyFunction().cutWord10(product.productName),
              style: MyStyle().normalPrimary16(),
            ),
            Text(
              'ราคา ${product.productPrice.toStringAsFixed(0)}.-',
              style: MyStyle().normalBlue16(),
            ),
            Text(
              'สถานะ : ${product.productStatus == 0 ? 'หมด' : 'ขาย'}',
              style: MyStyle().normalBlack14(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChip() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            chip(GlobalVariable.productTypes[0], Icons.fastfood_rounded, 0),
            chip(GlobalVariable.productTypes[1], Icons.rice_bowl_rounded, 1),
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            chip(GlobalVariable.productTypes[2], Icons.nightlife_rounded, 2),
            chip(GlobalVariable.productTypes[3], Icons.icecream_rounded, 3),
          ],
        ),
      ],
    );
  }

  Widget chip(String title, IconData icon, int index) {
    return ActionChip(
      avatar: Icon(
        icon,
        color: Colors.white,
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 3.w),
      backgroundColor: MyStyle.primary,
      label: Text(
        title,
        style: MyStyle().normalWhite16(),
      ),
      onPressed: () {
        setState(() {
          GlobalVariable.indexPageNavigation = 1;
          GlobalVariable.indexProductChip = index;
        });
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routePageNavigation, (route) => false);
      },
    );
  }

  Widget buildDetail(String detail) {
    return Container(
      width: 100.w,
      color: Colors.yellow,
      padding: EdgeInsets.all(2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: GlobalVariable.largeDevice ? 70.w : 60.w,
            child: Text(detail, style: MyStyle().normalPurple18()),
          ),
          Icon(Icons.description_rounded,
              color: Colors.purple.shade700, size: 35.sp),
        ],
      ),
    );
  }

  Widget buildAnnounce(String announce) {
    return Container(
      width: 100.w,
      color: Colors.green.shade200,
      padding: EdgeInsets.all(2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.campaign_rounded, color: Colors.red.shade700, size: 35.sp),
          SizedBox(
            width: GlobalVariable.largeDevice ? 70.w : 60.w,
            child: Text(announce, style: MyStyle().normalRed18()),
          ),
        ],
      ),
    );
  }
}
