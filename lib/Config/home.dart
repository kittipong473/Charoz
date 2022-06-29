import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/Model/banner_model.dart';
import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/shop_provider.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Function/dialog_detail.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
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

  void getData() {
    Provider.of<ConfigProvider>(context, listen: false).getAllBanner();
    Provider.of<ShopProvider>(context, listen: false).getShopWhereId();
    Provider.of<ShopProvider>(context, listen: false).getTimeWhereId();
    Provider.of<OrderProvider>(context, listen: false).getProductSuggest();
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
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    buildStatus(),
                    SizedBox(height: 1.h),
                    buildCarouselList(),
                    SizedBox(height: 3.h),
                    buildVideo(),
                    SizedBox(height: 3.h),
                    ScreenWidget().buildTitlePadding('อาหารแนะนำ'),
                    buildSuggestList(),
                    SizedBox(height: 3.h),
                    ScreenWidget().buildTitlePadding('เลือกดูประเภทอาหาร'),
                    SizedBox(height: 2.h),
                    buildChip(),
                    SizedBox(height: 3.h),
                    buildDetail(),
                    buildAnnounce(),
                  ],
                ),
              ),
            ),
            ScreenWidget().appBarTitle('Charoz Steak House'),
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
                  Lottie.asset(MyImage.gifOpen, width: 30.sp, height: 30.sp),
                  Text('สถานะร้านค้า : ${provider.shopStatus}',
                      style: MyStyle().boldGreen18()),
                  Lottie.asset(MyImage.gifOpen, width: 30.sp, height: 30.sp),
                ] else ...[
                  Lottie.asset(MyImage.gifClosed, width: 30.sp, height: 30.sp),
                  Text('สถานะร้านค้า : ${provider.shopStatus}',
                      style: MyStyle().boldRed18()),
                  Lottie.asset(MyImage.gifClosed, width: 30.sp, height: 30.sp),
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
                  buildCarouselItem(provider.bannerList[index], index),
            ),
    );
  }

  Widget buildCarouselItem(BannerModel banner, int index) {
    return InkWell(
      onTap: () => DialogDetail().dialogCarousel(context, banner.bannerUrl),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: MyVariable.largeDevice ? 70.w : 100.w,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: '${RouteApi.domainBanner}${banner.bannerUrl}',
            placeholder: (context, url) => const ShowProgress(),
            errorWidget: (context, url, error) => Image.asset(MyImage.error),
          ),
        ),
      ),
    );
  }

  Widget buildVideo() {
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
          Consumer<ShopProvider>(
        builder: (_, value, __) => value.shop == null
            ? const ShowProgress()
            : CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: '${RouteApi.domainVideo}${value.shop.shopVideo}',
                placeholder: (context, url) => const ShowProgress(),
                errorWidget: (context, url, error) =>
                    Image.asset(MyImage.error),
              ),
      ),
    );
  }

  Widget buildSuggestList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 100.w,
        height: 25.h,
        child: Consumer<OrderProvider>(
          builder: (_, value, __) => value.productsSuggest == null
              ? const ShowProgress()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.productsSuggest.length,
                  itemBuilder: (context, index) =>
                      buildSuggestItem(value.productsSuggest[index], index),
                ),
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
        onTap: () => DialogDetail().dialogProduct(context, product),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            '${RouteApi.domainProduct}${product.productImage}',
                        placeholder: (context, url) => const ShowProgress(),
                        errorWidget: (context, url, error) =>
                            Image.asset(MyImage.error),
                      ),
                    ),
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
            chip(MyVariable.productTypes[0], Icons.fastfood_rounded, 0),
            chip(MyVariable.productTypes[1], Icons.rice_bowl_rounded, 1),
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            chip(MyVariable.productTypes[2], Icons.nightlife_rounded, 2),
            chip(MyVariable.productTypes[3], Icons.icecream_rounded, 3),
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
          MyVariable.indexPageNavigation = 1;
          MyVariable.indexProductChip = index;
        });
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routePageNavigation, (route) => false);
      },
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
              builder: (_, value, __) => value.shop == null
                  ? const ShowProgress()
                  : Text(
                      value.shop.shopDetail,
                      style: MyStyle().normalPurple18(),
                    ),
            ),
          ),
          Icon(
            Icons.description_rounded,
            color: Colors.purple.shade700,
            size: 35.sp,
          ),
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
          Icon(
            Icons.campaign_rounded,
            color: Colors.red.shade700,
            size: 35.sp,
          ),
          SizedBox(
            width: MyVariable.largeDevice ? 70.w : 60.w,
            child: Consumer<ShopProvider>(
              builder: (context, value, child) => value.shop == null
                  ? const ShowProgress()
                  : Text(
                      value.shop.shopAnnounce,
                      style: MyStyle().normalRed18(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
