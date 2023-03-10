import 'package:animations/animations.dart';
import 'package:charoz/View/Modal/edit_product.dart';
import 'package:charoz/Model/Data/product_model.dart';
import 'package:charoz/Service/Firebase/product_crud.dart';
import 'package:charoz/Model/Util/Constant/my_image.dart';
import 'package:charoz/Model/Util/Constant/my_style.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/Model/Util/Variable/var_general.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View/Widget/show_image.dart';
import 'package:charoz/View/Widget/show_progress.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ModalProduct {
  final ProductViewModel prodVM = Get.find<ProductViewModel>();
  final OrderViewModel orderVM = Get.find<OrderViewModel>();
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
              ? const ShowProgress()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ScreenWidget().buildModalHeader('รายละเอียดอาหาร'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(getImageFoodName(vm.product.type ?? 0),
                            width: 10.w, height: 10.w),
                        Text(vm.product.name ?? '',
                            style: MyStyle().boldPrimary18()),
                        Lottie.asset(getImageFoodName(vm.product.type ?? 0),
                            width: 10.w, height: 10.w),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                        'ราคา : ${vm.product.price?.toStringAsFixed(0) ?? 0.00} บาท',
                        style: MyStyle().normalBlue18()),
                    SizedBox(height: 3.h),
                    SizedBox(
                      width: 60.w,
                      height: 60.w,
                      child: ShowImage()
                          .showImage(prodVM.product.image, BoxFit.cover),
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      width: 60.w,
                      child: Text(
                        vm.product.detail ?? '',
                        style: MyStyle().normalBlack16(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (VariableGeneral.role == 3) ...[
                      // buttonManager(dialogContext, product)
                    ] else if (VariableGeneral.role == 1) ...[
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
                .updateStatusProduct(product.id!, !product.status!);
            if (status) {
              prodVM.readProductAllList();
              MyFunction().toast('เปลี่ยนสถานะเรียบร้อย');
              Get.back();
            } else {
              MyDialog(context).doubleDialog(
                  'เปลี่ยนสถานะล้มเหลว', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
            }
          },
          child: Text('เปลี่ยนสถานะ', style: MyStyle().boldBlue16()),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            EditProduct().openModalEditProduct(context, product);
          },
          child: Text('แก้ไข', style: MyStyle().boldGreen16()),
        ),
        TextButton(
          onPressed: () async {
            bool status = await ProductCRUD().deleteProduct(product.id!);
            if (status) {
              prodVM.readProductAllList();
              MyFunction().toast('ลบรายการอาหารเรียบร้อย');
              Get.back();
            } else {
              MyDialog(context).deleteFailedDialog();
            }
          },
          child: Text('ลบ', style: MyStyle().boldRed16()),
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
              Text('จำนวน : $count', style: MyStyle().boldBlack18()),
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
                  MyFunction().toast('เพิ่มรายการ ${product.name} เรียบร้อย');
                  Get.back();
                },
                child: Text('เพิ่มลงในตะกร้า', style: MyStyle().boldBlue16()),
              )
            : Text('ขออภัย อาหารหมดสต็อก', style: MyStyle().boldRed16()),
      ],
    );
  }

  String getImageFoodName(int type) {
    if (type == 0) {
      return MyImage.gifFood;
    } else if (type == 1) {
      return MyImage.gifSnack;
    } else if (type == 2) {
      return MyImage.gifDrink;
    } else if (type == 3) {
      return MyImage.gifSweet;
    } else {
      return MyImage.error;
    }
  }
}
