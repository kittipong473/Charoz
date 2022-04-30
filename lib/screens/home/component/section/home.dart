import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/screens/home/model/banner_model.dart';
import 'package:charoz/screens/home/provider/home_provider.dart';
import 'package:charoz/screens/product/model/product_model.dart';
import 'package:charoz/screens/product/provider/product_provider.dart';
import 'package:charoz/screens/shop/provider/shop_provider.dart';
import 'package:charoz/services/route/route_api.dart';
import 'package:charoz/services/route/route_page.dart';
import 'package:charoz/utils/constant/my_function.dart';
import 'package:charoz/utils/constant/my_image.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:charoz/utils/show_progress.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  VideoPlayerController? videoPlayerController;
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  List<String> types = [];

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getProductSuggest();
    transformationController = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => transformationController.value = animation!.value);
  }

  void setVideo(String url) {
    videoPlayerController =
        VideoPlayerController.network('${RouteApi.domainVideo}$url')
          ..initialize().then((value) {
            videoPlayerController!.play();
            videoPlayerController!.setVolume(0.25);
            videoPlayerController!.setLooping(true);
          });
  }

  @override
  void dispose() {
    super.dispose();
    transformationController.dispose();
    animationController.dispose();
    if (types[1] == 'mp3' || types[1] == 'mp4') {
      videoPlayerController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer3<HomeProvider, ShopProvider, ProductProvider>(
          builder: (context, hprovider, sprovider, pprovider, child) {
            if (sprovider.shop == null ||
                sprovider.currentStatus == null ||
                pprovider.productsSuggest.isEmpty ||
                hprovider.banners.isEmpty) {
              return const ShowProgress();
            } else {
              types = sprovider.shop!.shopVideo.split(".");
              if (types[1] == 'mp3' || types[1] == 'mp4') {
                setVideo(sprovider.shop!.shopVideo);
              }
              return Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 7.h),
                          buildStatus(sprovider.currentStatus),
                          SizedBox(height: 1.h),
                          buildCarousel(hprovider),
                          SizedBox(height: 3.h),
                          buildVideo(types[1], sprovider.shop!.shopVideo),
                          SizedBox(height: 3.h),
                          MyWidget().buildTitlePadding(title: 'อาหารแนะนำ'),
                          buildSuggestList(pprovider),
                          SizedBox(height: 3.h),
                          MyWidget()
                              .buildTitlePadding(title: 'เลือกดูประเภทอาหาร'),
                          SizedBox(height: 2.h),
                          buildChip(),
                          SizedBox(height: 3.h),
                          buildDetail(sprovider.shop!.shopDetail),
                          buildAnnounce(sprovider.shop!.shopAnnounce),
                          SizedBox(height: 1.h),
                          buildShopData(),
                          SizedBox(height: 1.h),
                        ],
                      ),
                    ),
                  ),
                  MyWidget().backgroundTitle(),
                  MyWidget().title('Charoz Steak House'),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildStatus(String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (status == 'เปิดบริการ') ...[
          Lottie.asset(MyImage.gifOpen, width: 35.sp, height: 35.sp),
          Text('สถานะร้านค้า : $status', style: MyStyle().boldGreen18()),
          Lottie.asset(MyImage.gifOpen, width: 35.sp, height: 35.sp),
        ] else ...[
          Lottie.asset(MyImage.gifClosed, width: 35.sp, height: 35.sp),
          Text('สถานะร้านค้า : $status', style: MyStyle().boldRed18()),
          Lottie.asset(MyImage.gifClosed, width: 35.sp, height: 35.sp),
        ]
      ],
    );
  }

  Widget buildCarousel(HomeProvider hprovider) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 16.h,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      itemCount: hprovider.bannersLength,
      itemBuilder: (context, index, realIndex) =>
          buildImage(hprovider.banners[index], index),
    );
  }

  Widget buildImage(BannerModel banner, int index) {
    return InkWell(
      onTap: () => dialogCarouselDetail(banner),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: MyVariable.largeDevice ? 70.w : 100.w,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            '${RouteApi.domainBanner}${banner.bannerUrl}',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  void dialogCarouselDetail(BannerModel banner) {
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) => SimpleDialog(
        title: Column(
          children: [
            SizedBox(
              height: 25.h,
              child: InteractiveViewer(
                transformationController: transformationController,
                clipBehavior: Clip.none,
                panEnabled: false,
                minScale: 1,
                maxScale: 4,
                // onInteractionEnd: (details) => resetAnimation(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl: '${RouteApi.domainBanner}${banner.bannerUrl}',
                    placeholder: (context, url) => const ShowProgress(),
                    errorWidget: (context, url, error) =>
                        Image.asset(MyImage.error),
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'เลื่อนนิ้วเพื่อ zoom เข้า zoom ออก',
              style: MyStyle().normalBlack16(),
            ),
            SizedBox(height: 3.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyStyle.colorBackGround,
              ),
              width: 20.w,
              height: 20.w,
              child: Lottie.asset(MyImage.gifZoom),
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: transformationController.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    animationController.forward(from: 0);
  }

  Widget buildVideo(String type, String img) {
    return Container(
      width: 100.w,
      height: 20.h,
      color: Colors.black,
      child: type == 'mp3' || type == 'mp4'
          ? videoPlayerController == null
              ? const ShowProgress()
              : VideoPlayer(videoPlayerController!)
          : CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: '${RouteApi.domainVideo}$img',
              placeholder: (context, url) => const ShowProgress(),
              errorWidget: (context, url, error) => Image.asset(MyImage.error),
            ),
    );
  }

  Widget buildSuggestList(ProductProvider pprovider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 100.w,
        height: 27.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: pprovider.productsSuggestLength,
          itemBuilder: (context, index) =>
              buildSuggestItem(pprovider.productsSuggest[index], index),
        ),
      ),
    );
  }

  Widget buildSuggestItem(ProductModel product, int index) {
    return Card(
      color:
          product.productStatus == 'หมด' ? Colors.grey.shade400 : Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => dialogProductDetail(context, product),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MyVariable.largeDevice ? 23.w : 30.w,
              height: 12.h,
              child: SizedBox(
                width: 30.w,
                height: 12.h,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
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
                      left: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15.sp,
                        child: Lottie.asset(MyImage.gifStar),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              MyFunction().cutWord10(product.productName),
              style: MyStyle().boldPrimary16(),
            ),
            Text(
              '${product.productPrice}.-',
              style: MyStyle().boldBlue16(),
            ),
            Text(
              'สถานะ : ${product.productStatus}',
              style: MyStyle().boldBlack16(),
            ),
          ],
        ),
      ),
    );
  }

  void dialogProductDetail(BuildContext context, ProductModel product) {
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) => SimpleDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (product.productType == 'อาหาร') ...[
                  Lottie.asset(MyImage.gifName, width: 25.sp, height: 25.sp),
                ] else if (product.productType == 'ของหวาน') ...[
                  Lottie.asset(MyImage.gifSweet, width: 25.sp, height: 25.sp),
                ] else if (product.productType == 'เครื่องดื่ม') ...[
                  Lottie.asset(MyImage.gifDrink, width: 25.sp, height: 25.sp),
                ],
                Text(
                  product.productName,
                  style: MyStyle().boldPrimary16(),
                ),
                if (product.productType == 'อาหาร') ...[
                  Lottie.asset(MyImage.gifName, width: 25.sp, height: 25.sp),
                ] else if (product.productType == 'ของหวาน') ...[
                  Lottie.asset(MyImage.gifSweet, width: 25.sp, height: 25.sp),
                ] else if (product.productType == 'เครื่องดื่ม') ...[
                  Lottie.asset(MyImage.gifDrink, width: 25.sp, height: 25.sp),
                ],
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(MyImage.gifScoreRate, width: 30.sp, height: 30.sp),
                Text(
                  'ความอร่อย : ${product.productScore}',
                  style: MyStyle().boldPrimary16(),
                ),
                Lottie.asset(MyImage.gifScoreRate, width: 30.sp, height: 30.sp),
              ],
            ),
            Text(
              'ราคา : ${product.productPrice} บาท',
              style: MyStyle().boldBlue18(),
            ),
            Text(
              'ประเภท : ${product.productType}',
              style: MyStyle().boldPrimary18(),
            ),
            Text(
              'สถานะ : ${product.productStatus}',
              style: MyStyle().boldBlue18(),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              width: 60.w,
              height: 60.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: '${RouteApi.domainProduct}${product.productImage}',
                  placeholder: (context, url) => const ShowProgress(),
                  errorWidget: (context, url, error) =>
                      Image.asset(MyImage.error),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              width: 60.w,
              child: Text(
                product.productDetail,
                style: MyStyle().normalBlack16(),
              ),
            ),
          ],
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'ตกลง',
              style: MyStyle().boldBlue18(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChip() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            chip('อาหาร', Icons.fastfood_rounded, 0),
            chip('ออร์เดิฟ', Icons.rice_bowl_rounded, 1),
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            chip('เครื่องดื่ม', Icons.nightlife_rounded, 2),
            chip('ของหวาน', Icons.icecream_rounded, 3),
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
        style: MyStyle().boldWhite16(),
      ),
      onPressed: () {
        setState(() {
          MyVariable.indexPage = 1;
          MyVariable.menuIndex = index;
          MyVariable.menuType = title;
        });
        Navigator.pushNamedAndRemoveUntil(
            context, RoutePage.routeHomeService, (route) => false);
      },
    );
  }

  Widget buildDetail(String announce) {
    return Container(
      width: 100.w,
      color: Colors.yellow,
      padding: EdgeInsets.all(2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MyVariable.largeDevice ? 70.w : 60.w,
            child: Text(
              announce,
              style: MyStyle().boldPurple18(),
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

  Widget buildAnnounce(String announce) {
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
            child: Text(
              announce,
              style: MyStyle().boldRed18(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShopData() {
    return SizedBox(
      width: 50.w,
      height: 20.w,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, RoutePage.routeShopDetail),
        child: Stack(
          children: [
            Positioned.fill(
              child: Lottie.asset(MyImage.gifButton),
            ),
            Positioned(
              top: MyVariable.largeDevice ? 45 : 28,
              left: MyVariable.largeDevice ? 60 : 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.store_mall_directory_rounded,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'ดูข้อมูลร้านอาหาร',
                    style: MyStyle().boldWhite16(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
