import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:charoz/Component/Address/edit_location.dart';
import 'package:charoz/Model/address_model.dart';
import 'package:charoz/Model/noti_model.dart';
import 'package:charoz/Model/user_model.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Service/Api/address_api.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:charoz/Component/Product/edit_product.dart';
import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Service/Api/product_api.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/show_toast.dart';

class DialogDetail {
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  void dialogCarousel(BuildContext context, String path) {
    transformationController = TransformationController();
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
                  onInteractionEnd: (details) => resetAnimation(),
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

  void dialogShop(BuildContext context, String path) {
    transformationController = TransformationController();
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
                  onInteractionEnd: (details) => resetAnimation(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(path, fit: BoxFit.fill),
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

  void dialogProduct(BuildContext context, ProductModel product) {
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
            Text(product.productName, style: MyStyle().boldPrimary18()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(MyImage.gifScoreRate, width: 30.sp, height: 30.sp),
                Text(
                  'ความอร่อย : ${product.productScore}',
                  style: MyStyle().normalGreen18(),
                ),
                Lottie.asset(MyImage.gifScoreRate, width: 30.sp, height: 30.sp),
              ],
            ),
            Text('ราคา : ${product.productPrice.toStringAsFixed(0)} ฿',
                style: MyStyle().normalBlue18()),
            Text('ประเภท : ${product.productType}',
                style: MyStyle().normalBlue18()),
            SizedBox(height: 3.h),
            SizedBox(
              width: 60.w,
              height: 60.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
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
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 3.h),
          ],
        ),
        children: [
          if (MyVariable.role == 'manager') ...[
            modalButtonManager(product, context)
          ] else if (MyVariable.role == 'customer') ...[
            modalButtonCustomer(product, context)
          ],
        ],
      ),
    );
  }

  Widget modalButtonManager(ProductModel product, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            int? status;
            if (product.productStatus == 1) {
              status = 0;
            } else if (product.productStatus == 0) {
              status = 1;
            }
            ProductApi()
                .editProductStatusWhereId(
                    id: product.productId, status: status!)
                .then((value) {
              ShowToast().toast('เปลี่ยนสถานะเป็น $status');
              Navigator.pop(context);
              // Provider.of<OrderProvider>(context, listen: false)
              //     .getAllEachProduct();
            });
          },
          child: Text(
            'เปลี่ยนสถานะ',
            style: MyStyle().boldBlue16(),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProduct(product: product),
            ),
          ),
          child: Text(
            'แก้ไข',
            style: MyStyle().boldGreen16(),
          ),
        ),
        TextButton(
          onPressed: () {
            ProductApi()
                .deleteProductWhereId(id: product.productId)
                .then((value) {
              ShowToast().toast('ลบรายการ ${product.productName}');
              Navigator.pop(context);
              // Provider.of<OrderProvider>(context, listen: false)
              //     .getAllEachProduct();
            });
          },
          child: Text(
            'ลบ',
            style: MyStyle().boldRed16(),
          ),
        ),
      ],
    );
  }

  Widget modalButtonCustomer(ProductModel product, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [],
    );
  }

  void dialogNoti(BuildContext context, NotiModel noti) {
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                noti.notiName,
                style: MyStyle().boldPrimary20(),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 50.w,
                height: 50.w,
                child: Image.asset(MyImage.welcome),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 60.w,
                child: Text(
                  noti.notiDetail,
                  style: MyStyle().normalBlack16(),
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'เริ่มต้น : ${MyFunction().convertNotiTime(noti.notiStart)}',
                style: MyStyle().boldBlue16(),
              ),
              SizedBox(height: 1.h),
              Text(
                'สิ้นสุด : ${MyFunction().convertNotiTime(noti.notiEnd)}',
                style: MyStyle().boldBlue16(),
              ),
              SizedBox(height: 1.h),
            ],
          ),
          // children: [
          //   if (MyVariable.role == 'admin') ...[
          //     TextButton(
          //       onPressed: () async {
          //         bool result =
          //             await NotiApi().deleteNotiWhereId(id: noti.notiId);
          //         if (result) {
          //           ShowToast().toast('ลบรายการแจ้งเตือนสำเร็จ');
          //           Provider.of<NotiProvider>(context, listen: false)
          //               .getAllNoti();
          //         } else {
          //           ShowToast()
          //               .toast('ลบรายการแจ้งเตือนล้มเหลว ลองใหม่อีกครั้ง');
          //         }
          //         Navigator.pop(context);
          //       },
          //       child: Text(
          //         'ลบรายการ',
          //         style: MyStyle().boldPrimary18(),
          //       ),
          //     ),
          //   ] else ...[
          //     TextButton(
          //       onPressed: () => Navigator.pop(context),
          //       child: Text(
          //         'ตกลง',
          //         style: MyStyle().boldBlue18(),
          //       ),
          //     ),
          //   ],
          // ],
        ),
      ),
    );
  }

  void dialogUserDetail(BuildContext context, UserModel user) {
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
            SizedBox(
              width: 40.w,
              height: 40.w,
              child: Image.asset(
                MyImage.person,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'เบอร์โทร : ${user.userPhone}',
              style: MyStyle().boldBlue18(),
            ),
            const SizedBox(height: 20),
            Text(
              'ชื่อ : ${user.userFirstName}',
              style: MyStyle().boldBlack16(),
            ),
            const SizedBox(height: 10),
            Text(
              'นามสกุล : ${user.userLastName}',
              style: MyStyle().boldBlack16(),
            ),
            const SizedBox(height: 10),
            Text(
              'วันเกิด : ${user.userBirth}',
              style: MyStyle().boldBlack16(),
            ),
            const SizedBox(height: 10),
            Text(
              'อีเมลล์ : ${user.userEmail}',
              style: MyStyle().boldBlack16(),
            ),
            const SizedBox(height: 10),
            Text(
              'ตำแหน่ง : ${user.userRole}',
              style: MyStyle().boldBlack16(),
            ),
            const SizedBox(height: 10),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'เปลี่ยนสถานะ',
                  style: MyStyle().boldPrimary16(),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'ดูข้อมูลที่อยู่',
                  style: MyStyle().boldGreen16(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void dialogManageAddress(BuildContext context, AddressModel address) {
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
            Text('จัดการที่อยู่', style: MyStyle().normalPrimary18()),
            SizedBox(height: 3.h),
            Text('ประเภทที่อยู่ : ${address.addressName}',
                style: MyStyle().normalBlack16()),
            SizedBox(height: 1.h),
            Text(
              'ข้อมูลที่อยู่ : ${address.addressDetail}',
              style: MyStyle().normalBlack16(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: Text('แก้ไขข้อมูล',
                    style: MyStyle().boldGreen16()),
              ),
              TextButton(
                onPressed: () async {
                  
                },
                child: Text(
                  'ลบข้อมูล',
                  style: MyStyle().boldRed16(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
