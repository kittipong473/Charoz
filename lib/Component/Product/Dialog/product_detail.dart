import 'package:animations/animations.dart';
import 'package:charoz/Component/Product/Modal/edit_product.dart';
import 'package:charoz/Model_Main/product_model.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Service/Database/Firebase/product_crud.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/my_variable.dart';
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
      builder: (dialogContext) => SimpleDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(product.name, style: MyStyle().boldPrimary18()),
            Text('${product.price.toStringAsFixed(0)} ฿',
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
          if (MyVariable.role == 'manager') ...[
            buttonManager(dialogContext, product)
          ] else if (MyVariable.role == 'customer') ...[
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
              Provider.of<ProductProvider>(context, listen: false)
                  .readProductAllList();
              Provider.of<ProductProvider>(context, listen: false)
                  .readProductTypeList(
                      MyVariable.productTypes[MyVariable.indexProductChip]);
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
            bool status = await ProductCRUD().deleteProduct(product.id);
            if (status) {
              Provider.of<ProductProvider>(context, listen: false)
                  .readProductAllList();
              Provider.of<ProductProvider>(context, listen: false)
                  .readProductTypeList(
                      MyVariable.productTypes[MyVariable.indexProductChip]);
              MyFunction().toast('ลบรายการอาหารเรียบร้อย');
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
        ),
        SizedBox(height: 3.h),
        product.status == 1
            ? TextButton(
                onPressed: () {
                  Provider.of<OrderProvider>(context, listen: false)
                      .addOrderToCart(product.id, count);
                  MyFunction().toast('เพิ่มรายการ ${product.name} เรียบร้อย');
                  Navigator.pop(context);
                },
                child: Text('เพิ่มลงในตะกร้า', style: MyStyle().boldBlue16()),
              )
            : Text('ขออภัย อาหารหมดสต็อก', style: MyStyle().boldRed16()),
      ],
    );
  }
}
