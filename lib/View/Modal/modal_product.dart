import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/Service/Library/console_log.dart';
import 'package:charoz/View/Dialog/dialog_alert.dart';
import 'package:charoz/View/Modal/edit_product.dart';
import 'package:charoz/Service/Firebase/product_crud.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ModalProduct {
  final prodVM = Get.find<ProductViewModel>();
  final orderVM = Get.find<OrderViewModel>();
  final userVM = Get.find<UserViewModel>();
  int count = 1;

  Future<void> showModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        color: MyStyle.backgroundColor,
        width: 100.w,
        height: 85.h,
        child: GetBuilder<ProductViewModel>(
          builder: (vm) => vm.product == null
              ? MyWidget().showProgress()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyWidget().buildModalHeader(title: 'รายละเอียดอาหาร'),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     MyWidget().showImage(
                    //         path: getImageFoodName(vm.product.type ?? 0),
                    //         width: 10.w,
                    //         height: 10.w),
                    //     Text(
                    //       vm.product.name ?? '',
                    //       style: MyStyle.textStyle(
                    //           size: 18, color: MyStyle.orangePrimary),
                    //     ),
                    //     MyWidget().showImage(
                    //         path: getImageFoodName(vm.product.type ?? 0),
                    //         width: 10.w,
                    //         height: 10.w),
                    //   ],
                    // ),
                    SizedBox(height: 1.h),
                    // Text(
                    //   'ราคา : ${vm.product.price?.toStringAsFixed(0) ?? 0.00} บาท',
                    //   style: MyStyle.textStyle(
                    //       size: 18, color: MyStyle.bluePrimary),
                    // ),
                    SizedBox(height: 3.h),
                    // SizedBox(
                    //   width: 60.w,
                    //   height: 60.w,
                    //   child: MyWidget().showImage(
                    //       path: prodVM.product.image, fit: BoxFit.cover),
                    // ),
                    SizedBox(height: 5.h),
                    // SizedBox(
                    //   width: 60.w,
                    //   child: Text(
                    //     vm.product.detail ?? '',
                    //     style: MyStyle.textStyle(
                    //         size: 16, color: MyStyle.blackPrimary),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    if (userVM.role == 3) ...[
                      // buttonManager(dialogContext, product)
                    ] else if (userVM.role == 1) ...[
                      // buttonCustomer(dialogContext, product)
                    ],
                  ],
                ),
        ),
      ),
    );
  }

  Widget buttonManager(BuildContext context, ProductModel product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () async {
            bool status = await ProductCRUD()
                .updateStatusProduct(id: product.id!, status: !product.status!);
            if (status) {
              prodVM.readProductAllList();
              ConsoleLog.toast(text: 'เปลี่ยนสถานะเรียบร้อย');
              Get.back();
            } else {
              DialogAlert(context).dialogStatus(
                  type: 2,
                  title: 'เปลี่ยนสถานะล้มเหลว',
                  body: 'กรุณาลองใหม่อีกครั้งในภายหลัง');
            }
          },
          child: Text(
            'เปลี่ยนสถานะ',
            style: MyStyle.textStyle(size: 16, color: MyStyle.bluePrimary),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            EditProduct().openModalEditProduct(context, product);
          },
          child: Text(
            'แก้ไข',
            style: MyStyle.textStyle(size: 16, color: MyStyle.greenPrimary),
          ),
        ),
        TextButton(
          onPressed: () async {
            bool status = await ProductCRUD().deleteProduct(id: product.id!);
            if (status) {
              prodVM.readProductAllList();
              ConsoleLog.toast(text: 'ลบรายการอาหารเรียบร้อย');
              Get.back();
            } else {
              DialogAlert(context).dialogApi();
            }
          },
          child: Text(
            'ลบ',
            style: MyStyle.textStyle(
                size: 16, color: MyStyle.redPrimary, bold: true),
          ),
        ),
      ],
    );
  }

  Widget buttonCustomer(BuildContext context, ProductModel product) {
    return Column(
      children: [
        StatefulBuilder(
          builder: (_, setState) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => setState(() {
                  if (count > 1) count--;
                }),
                icon: Icon(
                  Icons.remove_circle_rounded,
                  size: 25.sp,
                  color: Colors.red,
                ),
              ),
              Text(
                'จำนวน : $count',
                style: MyStyle.textStyle(size: 18, color: MyStyle.blackPrimary),
              ),
              IconButton(
                onPressed: () => setState(() {
                  if (count < 10) count++;
                }),
                icon: Icon(
                  Icons.add_circle_rounded,
                  size: 25.sp,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3.h),
        product.status!
            ? TextButton(
                onPressed: () {
                  orderVM.addProductToCart(product, count);
                  ConsoleLog.toast(
                      text: 'เพิ่มรายการ ${product.name} เรียบร้อย');
                  Get.back();
                },
                child: Text(
                  'เพิ่มลงในตะกร้า',
                  style: MyStyle.textStyle(
                      size: 16, color: MyStyle.bluePrimary, bold: true),
                ),
              )
            : Text(
                'ขออภัย อาหารหมดสต็อก',
                style: MyStyle.textStyle(
                    size: 16, color: MyStyle.redPrimary, bold: true),
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
