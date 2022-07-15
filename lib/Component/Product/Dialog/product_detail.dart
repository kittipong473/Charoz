import 'package:animations/animations.dart';
import 'package:charoz/Component/Product/Modal/edit_product.dart';
import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Service/Api/PHP/product_api.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductDetail {
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  int count = 1;

  void dialogProduct(BuildContext context, ProductModel product) {
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
              Text(product.productName, style: MyStyle().boldPrimary18()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(MyImage.gifScoreRate,
                      width: 30.sp, height: 30.sp),
                  Text(
                    'ความอร่อย : ${product.productScore}',
                    style: MyStyle().normalGreen18(),
                  ),
                  Lottie.asset(MyImage.gifScoreRate,
                      width: 30.sp, height: 30.sp),
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
                child: ShowImage().showProduct(product.productImage),
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
            if (GlobalVariable.role == 'manager') ...[
              buttonManager(product, context)
            ] else if (GlobalVariable.role == 'customer') ...[
              buttonCustomer(product, context, setState)
            ],
          ],
        ),
      ),
    );
  }

  Widget buttonManager(ProductModel product, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () async {
            int? status;
            if (product.productStatus == 1) {
              status = 0;
            } else if (product.productStatus == 0) {
              status = 1;
            }
            bool statusApi = await ProductApi()
                .editStatusWhereProduct(id: product.productId, status: status!);
            if (statusApi) {
              Provider.of<ProductProvider>(context, listen: false)
                  .getAllProductWhereType(
                      GlobalVariable.productTypes[GlobalVariable.indexProductChip]);
              MyFunction().toast('เปลี่ยนสถานะเรียบร้อย');
              Navigator.pop(context);
            } else {
              DialogAlert().doubleDialog(context, 'เปลี่ยนสถานะล้มเหลว',
                  'กรุณาลองใหม่อีกครั้งในภายหลัง');
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
            bool status =
                await ProductApi().deleteProductWhereId(id: product.productId);
            if (status) {
              Provider.of<ProductProvider>(context, listen: false)
                  .deleteProductWhereId(product.productId);
              MyFunction().toast('ลบรายการ ${product.productName}');
              Navigator.pop(context);
            } else {
              DialogAlert().deleteFailedDialog(context);
            }
          },
          child: Text('ลบ', style: MyStyle().boldRed16()),
        ),
      ],
    );
  }

  Widget buttonCustomer(
      ProductModel product, BuildContext context, Function setState) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => setState(() {
                if (count > 1) {
                  count--;
                }
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
                if (count < 10) {
                  count++;
                }
              }),
              icon: Icon(
                Icons.add_circle_rounded,
                size: 25.sp,
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        product.productStatus == 1 ?
        TextButton(
          onPressed: () {
            Provider.of<OrderProvider>(context,listen: false).addOrderToCart(product.productId, count);
            MyFunction().toast('เพิ่มรายการ ${product.productName} เรียบร้อย');
            Navigator.pop(context);
          },
          child: Text('เพิ่มลงในตะกร้า', style: MyStyle().boldBlue16()),
        )
        : Text('ขออภัย อาหารหมดสต็อก', style: MyStyle().boldRed16()),
      ],
    );
  }
}
