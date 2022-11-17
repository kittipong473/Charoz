import 'package:animations/animations.dart';
import 'package:charoz/View/Modal/edit_product.dart';
import 'package:charoz/Model/Data/product_model.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/product_crud.dart';
import 'package:charoz/Util/Constant/my_image.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/Util/Variable/var_data.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Widget/show_image.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductDetail {
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  int count = 1;

  final ProductViewModel prodVM = Get.find<ProductViewModel>();
  final OrderViewModel orderVM = Get.find<OrderViewModel>();

  void dialogProduct(BuildContext context, ProductModel product) {
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(getImageFoodName(product.type),
                    width: 10.w, height: 10.w),
                Text(product.name, style: MyStyle().boldPrimary18()),
                Lottie.asset(getImageFoodName(product.type),
                    width: 10.w, height: 10.w),
              ],
            ),
            Text('ราคา : ${product.price.toStringAsFixed(0)} บาท',
                style: MyStyle().normalBlue18()),
            SizedBox(height: 3.h),
            SizedBox(
              width: 60.w,
              height: 60.w,
              child: ShowImage().showImage(product.image),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              width: 60.w,
              child: Text(
                product.detail,
                style: MyStyle().normalBlack16(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        children: [
          if (VariableGeneral.role == 'manager') ...[
            buttonManager(dialogContext, product)
          ] else if (VariableGeneral.role == 'customer') ...[
            buttonCustomer(dialogContext, product)
          ],
        ],
      ),
    );
  }

  Widget buttonManager(BuildContext context, ProductModel product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () async {
            int? statusProduct;
            if (product.status == 1) {
              statusProduct = 0;
            } else if (product.status == 0) {
              statusProduct = 1;
            }
            bool status = await ProductCRUD()
                .updateStatusProduct(product.id, statusProduct!);
            if (status) {
              prodVM.readProductAllList();
              prodVM.readProductTypeList(
                  VariableData.productTypes[VariableGeneral.indexProductChip]);
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
            bool status = await ProductCRUD().deleteProduct(product.id);
            if (status) {
              prodVM.readProductAllList();
              prodVM.readProductTypeList(
                  VariableData.productTypes[VariableGeneral.indexProductChip]);
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
        product.status == 1
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

  String getImageFoodName(String type) {
    if (type == 'อาหาร') {
      return MyImage.gifFood;
    } else if (type == 'ทานเล่น') {
      return MyImage.gifSnack;
    } else if (type == 'เครื่องดื่ม') {
      return MyImage.gifDrink;
    } else if (type == 'ของหวาน') {
      return MyImage.gifSweet;
    } else {
      return MyImage.error;
    }
  }
}
