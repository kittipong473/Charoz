import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View/Modal/add_product.dart';
import 'package:charoz/Service/Routes/route_page.dart';
import 'package:charoz/View/Screen/Product/Dialog/product_detail.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View/Widget/search_product.dart';
import 'package:charoz/View_Model/order_vm.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final prodVM = Get.find<ProductViewModel>();
  final userVM = Get.find<UserViewModel>();
  final orderVM = Get.find<OrderViewModel>();
  int indexChip = 0;

  @override
  void initState() {
    super.initState();
    prodVM.getProductTypeList(0);
  }

  @override
  void dispose() {
    prodVM.clearProductData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        body: Column(
          children: [
            buildSearch(),
            buildChip(),
            buildProductList(),
          ],
        ),
        floatingActionButton: buildFloatingButton(),
      ),
    );
  }

  FloatingActionButton? buildFloatingButton() {
    if (userVM.role == 2) {
      return FloatingActionButton(
        backgroundColor: MyStyle.bluePrimary,
        child: const Icon(Icons.add_rounded, color: Colors.white),
        onPressed: () => AddProduct().openModalAddProduct(context),
      );
    } else if (userVM.role == 1 && orderVM.basketList.isNotEmpty) {
      return FloatingActionButton(
        backgroundColor: MyStyle.bluePrimary,
        child: const Icon(Icons.shopping_cart_rounded, color: Colors.white),
        onPressed: () => Get.toNamed(RoutePage.routeOrderCart),
      );
    } else {
      return null;
    }
  }

  Widget buildChip() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < prodVM.datatypeProduct.length; i++) ...[
                chip(prodVM.datatypeProduct[i], i),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget chip(String title, int index) {
    return ActionChip(
      elevation: 3,
      backgroundColor:
          indexChip == index ? MyStyle.orangePrimary : Colors.grey.shade300,
      label: Text(
        title,
        style: indexChip == index
            ? MyStyle.textStyle(size: 16, color: MyStyle.whitePrimary)
            : MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
      ),
      onPressed: () {
        setState(() => indexChip = index);
        prodVM.getProductTypeList(index);
      },
    );
  }

  Widget buildSearch() {
    return GestureDetector(
      onTap: () => showSearch(context: context, delegate: SearchProduct()),
      child: Container(
        height: 7.h,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: MyStyle.orangePrimary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded, size: 20.sp),
            SizedBox(width: 3.w),
            Text('ค้นหารายการอาหาร...',
                style: MyStyle.textStyle(size: 16, color: MyStyle.greyPrimary)),
          ],
        ),
      ),
    );
  }

  Widget buildProductList() {
    return GetBuilder<ProductViewModel>(
      builder: (vm) => Expanded(
        child: vm.productTypeList.isEmpty
            ? MyWidget().showEmptyData(
                title:
                    'ไม่มีรายการ ${prodVM.datatypeProduct[indexChip]} ในขณะนี้',
                body: 'กรุณารอรายการได้ในภายหลัง')
            : GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 0),
                itemCount: vm.productTypeList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 3 / 4, maxCrossAxisExtent: 140),
                itemBuilder: (context, index) =>
                    buildProductItem(vm.productTypeList[index]),
              ),
      ),
    );
  }

  Widget buildProductItem(ProductModel product) {
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
      decoration: BoxDecoration(
        color: product.status! ? Colors.white : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [MyStyle.boxShadow()],
      ),
      child: GestureDetector(
        onTap: () {
          prodVM.setProductModel(product);
          ProductDetail(context).dialogProduct();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 30.w,
              height: 12.h,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: MyWidget().showImage(
                        path: product.image!, fit: BoxFit.cover, radius: 10),
                  ),
                  if (product.suggest!) ...[
                    Positioned(
                      top: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15.sp,
                        child: MyWidget().showImage(path: MyImage.lotStar),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Column(
              children: [
                SizedBox(
                  width: 25.w,
                  child: Text(
                    product.name ?? '',
                    style:
                        MyStyle.textStyle(size: 14, color: MyStyle.bluePrimary),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${product.price?.toStringAsFixed(0) ?? 0.00}.-',
                  style:
                      MyStyle.textStyle(size: 16, color: MyStyle.orangePrimary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
