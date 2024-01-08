import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Library/console_log.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductDetail {
  final BuildContext context;
  ProductDetail(this.context);

  final userVM = Get.find<UserViewModel>();
  final orderVM = Get.find<OrderViewModel>();
  int count = 1;

  void dialogProduct() {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        backgroundColor: MyStyle.backgroundColor,
        titlePadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        title: GetBuilder<ProductViewModel>(
          builder: (vm) => vm.product == null
              ? MyWidget().showProgress()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyWidget().showImage(
                          path: getImageFoodName(vm.product?.type ?? 0),
                          width: 10.w,
                          height: 10.w,
                        ),
                        Text(
                          vm.product?.name ?? '',
                          style: MyStyle.textStyle(
                              size: 18, color: MyStyle.bluePrimary),
                        ),
                        MyWidget().showImage(
                          path: getImageFoodName(vm.product?.type ?? 0),
                          width: 10.w,
                          height: 10.w,
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'ราคา : ${vm.product?.price?.toStringAsFixed(0) ?? 0.00} บาท',
                      style: MyStyle.textStyle(
                          size: 18, color: MyStyle.orangePrimary),
                    ),
                    SizedBox(height: 3.h),
                    MyWidget().showImage(
                      path: vm.product?.image ?? MyImage.imgError,
                      fit: BoxFit.contain,
                      radius: 10,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      vm.product!.detail ?? '',
                      style: MyStyle.textStyle(
                          size: 16, color: MyStyle.blackPrimary),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),
                    if (userVM.role == 1) ...[
                      SizedBox(height: 3.h),
                      buildOrder(),
                      SizedBox(height: 5.h),
                      MyWidget().buttonWidget(
                        title: 'เพิ่มลงตะกร้า',
                        width: 60.w,
                        onTap: () {
                          orderVM.addProductToCart(vm.product!, count);
                          ConsoleLog.toast(
                              text:
                                  'เพิ่มรายการ ${vm.product!.name} เรียบร้อย');
                          Get.back();
                        },
                      ),
                      SizedBox(height: 1.h),
                    ] else if (userVM.role == 3) ...[
                      SizedBox(height: 1.h),
                      buildEdit(),
                      SizedBox(height: 1.h),
                    ],
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildOrder() {
    return StatefulBuilder(
      builder: (_, setState) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => setState(() {
              if (count > 1) count--;
            }),
            child: const Icon(Icons.remove_circle_rounded,
                color: MyStyle.redPrimary, size: 45),
          ),
          Text(
            count.toString(),
            style: MyStyle.textStyle(size: 30, color: MyStyle.orangeDark),
          ),
          GestureDetector(
            onTap: () => setState(() {
              if (count < 10) count++;
            }),
            child: const Icon(Icons.add_circle_rounded,
                color: MyStyle.greenPrimary, size: 45),
          ),
        ],
      ),
    );
  }

  Widget buildEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyWidget().buttonWidget(
          title: 'เปลี่ยนสถานะ',
          onTap: () {},
          color: MyStyle.orangePrimary,
          width: 60.w,
        ),
        const SizedBox(height: 10),
        MyWidget().buttonWidget(
          title: 'แก้ไขรายการ',
          onTap: () {},
          color: MyStyle.greenPrimary,
          width: 60.w,
        ),
        const SizedBox(height: 10),
        MyWidget().buttonWidget(
          title: 'ลบรายการ',
          onTap: () {},
          color: MyStyle.redPrimary,
          width: 60.w,
        ),
      ],
    );
  }

  String getImageFoodName(int type) {
    if (type == 0) {
      return MyImage.lotFood;
    } else if (type == 1) {
      return MyImage.lotSnack;
    } else if (type == 2) {
      return MyImage.lotDrink;
    } else if (type == 3) {
      return MyImage.lotSweet;
    } else {
      return MyImage.imgError;
    }
  }
}
