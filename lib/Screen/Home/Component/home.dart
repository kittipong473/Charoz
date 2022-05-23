import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:charoz/Screen/Home/Model/banner_model.dart';
import 'package:charoz/Screen/Home/Provider/home_provider.dart';
import 'package:charoz/Screen/Product/Model/product_model.dart';
import 'package:charoz/Screen/Product/Provider/product_provider.dart';
import 'package:charoz/Screen/Shop/Provider/shop_provider.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_function.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
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
  VideoPlayerController? videoPlayerController;
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  List<String> types = [];

  void getData() {
    Provider.of<ShopProvider>(context, listen: false).getShopWhereId();
    Provider.of<ShopProvider>(context, listen: false).getTimeWhereId();
    Provider.of<ProductProvider>(context, listen: false).getProductSuggest();
    Provider.of<HomeProvider>(context, listen: false).getAllBanner();
  }

  void getVideo() {
    transformationController = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => transformationController.value = animation!.value);
  }

  void setVideo(String url) {
    videoPlayerController =
        VideoPlayerController.network('${RouteApi.domainVideo}$url')
          ..initialize().then(
            (value) {
              videoPlayerController!.play();
              videoPlayerController!.setVolume(0.25);
              videoPlayerController!.setLooping(true);
            },
          );
  }

  @override
  void dispose() {
    super.dispose();
    // transformationController.dispose();
    // animationController.dispose();
    // if (types[1] == 'mp3' || types[1] == 'mp4') {
    //   videoPlayerController!.dispose();
    // }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    // getVideo();
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
                    buildCarousel(),
                    SizedBox(height: 3.h),
                    buildVideo(),
                    SizedBox(height: 3.h),
                    MyWidget().buildTitlePadding(title: 'อาหารแนะนำ'),
                    buildSuggestList(),
                    SizedBox(height: 3.h),
                    MyWidget().buildTitlePadding(title: 'เลือกดูประเภทอาหาร'),
                    SizedBox(height: 2.h),
                    buildChip(),
                    SizedBox(height: 3.h),
                    buildDetail(),
                    buildAnnounce(),
                    SizedBox(height: 3.h),
                    buildShopData(),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ),
            MyWidget().backgroundTitle(),
            MyWidget().title('Charoz Steak House'),
          ],
        ),
      ),
    );
  }

  Widget buildStatus() {
    return Consumer<ShopProvider>(
      builder: (_, value, __) => value.currentStatus == null
          ? const ShowProgress()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (value.currentStatus == 'เปิดบริการ') ...[
                  Lottie.asset(MyImage.gifOpen, width: 30.sp, height: 30.sp),
                  Text('สถานะร้านค้า : ${value.currentStatus}',
                      style: MyStyle().boldGreen18()),
                  Lottie.asset(MyImage.gifOpen, width: 30.sp, height: 30.sp),
                ] else ...[
                  Lottie.asset(MyImage.gifClosed, width: 30.sp, height: 30.sp),
                  Text('สถานะร้านค้า : ${value.currentStatus}',
                      style: MyStyle().boldRed18()),
                  Lottie.asset(MyImage.gifClosed, width: 30.sp, height: 30.sp),
                ]
              ],
            ),
    );
  }

  Widget buildCarousel() {
    return Consumer<HomeProvider>(
      builder: (_, value, __) => value.banners.isEmpty
          ? const ShowProgress()
          : CarouselSlider.builder(
              options: CarouselOptions(
                height: 16.h,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              itemCount: value.bannersLength,
              itemBuilder: (context, index, realIndex) =>
                  buildImage(value.banners[index], index),
            ),
    );
  }

  Widget buildImage(BannerModel banner, int index) {
    return InkWell(
      onTap: () => dialogCarouselDetail(banner.bannerUrl),
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

  void dialogCarouselDetail(String path) {
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
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
                        fit: BoxFit.fill,
                        imageUrl: '${RouteApi.domainBanner}$path',
                        placeholder: (context, url) => const ShowProgress(),
                        errorWidget: (context, url, error) =>
                            Image.asset(MyImage.error),
                      )),
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
        height: 27.h,
        child: Consumer<ProductProvider>(
          builder: (_, value, __) => value.productsSuggest.isEmpty
              ? const ShowProgress()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.productsSuggestLength,
                  itemBuilder: (context, index) =>
                      buildSuggestItem(value.productsSuggest[index], index),
                ),
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
        onTap: () => MyWidget().dialogProductDetail(context, product),
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
            ),
            Text(
              MyFunction().cutWord13(product.productName),
              style: MyStyle().boldPrimary14(),
            ),
            Text(
              '${product.productPrice}.-',
              style: MyStyle().boldBlue14(),
            ),
            Text(
              'สถานะ : ${product.productStatus}',
              style: MyStyle().boldBlack14(),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            chip('อาหาร', Icons.fastfood_rounded, 0),
            SizedBox(width: 20.w),
            chip('ออร์เดิฟ', Icons.rice_bowl_rounded, 1),
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            chip('เครื่องดื่ม', Icons.nightlife_rounded, 2),
            SizedBox(width: 20.w),
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
                      style: MyStyle().boldPurple18(),
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
                      style: MyStyle().boldRed18(),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShopData() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RoutePage.routeShopDetail),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyStyle.light,
          boxShadow: [MyStyle().boxShadow(color: MyStyle.primary)],
        ),
        child: Text(
          'ดูข้อมูลร้านอาหาร',
          style: TextStyle(
            color: MyStyle.dark,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            shadows: [MyStyle().textShadow()],
          ),
        ),
      ),
    );
  }
}
