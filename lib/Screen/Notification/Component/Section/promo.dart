import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:charoz/Screen/Notification/Model/noti_model.dart';
import 'package:charoz/Screen/Notification/Provider/noti_provider.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Promo extends StatefulWidget {
  const Promo({Key? key}) : super(key: key);

  @override
  _PromoState createState() => _PromoState();
}

class _PromoState extends State<Promo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<NotiProvider>(
          builder: (_, value, __) => value.notiPromos.isNotEmpty
              ? ListView.builder(
                  itemCount: value.notiPromosLength,
                  itemBuilder: (context, index) =>
                      buildPromotionItem(value.notiPromos[index], index),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ไม่มีโปรโมชั่นในขณะนี้',
                        style: MyStyle().boldPrimary20(),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'กรุณารอช่วงโปรโมชั่นในภายหลัง',
                        style: MyStyle().boldPrimary20(),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget buildPromotionItem(NotiModel promo, int index) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5.0,
      child: InkWell(
        onTap: () => dialogPromoDetail(context, promo),
        child: Padding(
          padding: MyVariable.largeDevice
              ? const EdgeInsets.all(20)
              : const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MyVariable.largeDevice ? 120 : 80,
                height: MyVariable.largeDevice ? 120 : 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: promo.notiImage == 'null'
                      ? Image.asset(
                          MyImage.image,
                          fit: BoxFit.contain,
                        )
                      : CachedNetworkImage(
                          imageUrl: '${RouteApi.domainPromo}${promo.notiImage}',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const ShowProgress(),
                          errorWidget: (context, url, error) =>
                              Image.asset(MyImage.error),
                        ),
                ),
              ),
              Text(
                promo.notiName,
                style: MyStyle().boldBlack16(),
              ),
              Column(
                children: [
                  Text(
                    'สิ้นสุดโปรโมชั่น',
                    style: MyStyle().normalBlack14(),
                  ),
                  SizedBox(
                    width: 22.w,
                    child: Text(
                      promo.notiEnd,
                      style: MyStyle().normalBlue16(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogPromoDetail(BuildContext context, NotiModel promo) {
    // int index = 0;
    // if (promo.notiRefer == 'อาหาร') {
    //   index = 0;
    // } else if (promo.notiRefer == 'เครื่องดื่ม') {
    //   index = 1;
    // } else {
    //   index = 2;
    // }
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
            Text(
              promo.notiName,
              style: MyStyle().boldPrimary20(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 40.w,
              height: 40.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: '${RouteApi.domainPromo}${promo.notiImage}',
                  placeholder: (context, url) => const ShowProgress(),
                  errorWidget: (context, url, error) =>
                      Image.asset(MyImage.error),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 60.w,
              child: Text(
                promo.notiDetail,
                style: MyStyle().normalBlack16(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'เริ่มต้น : ${promo.notiStart}',
              style: MyStyle().boldBlue16(),
            ),
            const SizedBox(height: 10),
            Text(
              'สิ้นสุด : ${promo.notiEnd}',
              style: MyStyle().boldBlue16(),
            ),
            const SizedBox(height: 10),
          ],
        ),
        // children: [
        //   TextButton(
        //     onPressed: () {
        //       setState(() {
        //         MyVariable.indexPage = 1;
        //         MyVariable.menuIndex = index;
        //         MyVariable.menuType = promo.notiType;
        //       });
        //       Navigator.pop(context);
        //       Navigator.pushNamedAndRemoveUntil(
        //           context, RoutePage.routeHomeService, (route) => false);
        //     },
        //     child: Text(
        //       'เริ่มสั่งอาหาร',
        //       style: MyStyle().boldBlue18(),
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
