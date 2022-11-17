import 'package:charoz/View/Modal/add_product.dart';
import 'package:charoz/View/Dialog/product_detail.dart';
import 'package:charoz/Model/Data/product_model.dart';
import 'package:charoz/Model/Service/Route/route_page.dart';
import 'package:charoz/Util/Constant/my_image.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/Util/Variable/var_data.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View/Widget/search_product.dart';
import 'package:charoz/View/Widget/show_image.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductViewModel prodVM = Get.find<ProductViewModel>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    await prodVM.readProductAllList();
    await prodVM.readProductTypeList(
        VariableData.productTypes[VariableGeneral.indexProductChip]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Stack(
          children: [
            Positioned.fill(
              top: 10.h,
              child: Column(
                children: [
                  buildChip(),
                  buildProductList(),
                ],
              ),
            ),
            buildSearch(),
          ],
        ),
        floatingActionButton: buildFloatingButton(),
      ),
    );
  }

  FloatingActionButton? buildFloatingButton() {
    if (VariableGeneral.role == 'manager') {
      return FloatingActionButton(
        backgroundColor: MyStyle.bluePrimary,
        child: const Icon(Icons.add_rounded, color: Colors.white),
        onPressed: () => AddProduct().openModalAddProduct(context),
      );
    } else if (VariableGeneral.role == 'customer') {
      return FloatingActionButton(
        backgroundColor: MyStyle.bluePrimary,
        child: const Icon(Icons.shopping_cart_rounded, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, RoutePage.routeOrderCart),
      );
    } else {
      return null;
    }
  }

  Widget buildChip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              chip(VariableData.productTypes[0], 0),
              chip(VariableData.productTypes[1], 1),
              chip(VariableData.productTypes[2], 2),
              chip(VariableData.productTypes[3], 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget chip(String title, int index) {
    return ActionChip(
      backgroundColor: VariableGeneral.indexProductChip == index
          ? MyStyle.primary
          : Colors.grey.shade300,
      label: Text(
        title,
        style: VariableGeneral.indexProductChip == index
            ? MyStyle().normalWhite16()
            : MyStyle().normalBlack16(),
      ),
      onPressed: () {
        setState(() => VariableGeneral.indexProductChip = index);
        getData();
      },
    );
  }

  Positioned buildSearch() {
    return Positioned(
      top: 2.h,
      left: 2.w,
      right: 2.w,
      child: InkWell(
        onTap: () => showSearch(context: context, delegate: SearchProduct()),
        child: Container(
          height: 7.h,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: MyStyle.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.search_rounded, size: 20.sp, color: MyStyle.primary),
              SizedBox(width: 3.w),
              Text('ค้นหารายการอาหาร...', style: MyStyle().normalGrey16()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductList() {
    return SizedBox(
      width: 100.w,
      height: 68.h,
      child: prodVM.productList == null
          ? ScreenWidget().showEmptyData(
              'ไม่มีรายการ ${VariableData.productTypes[VariableGeneral.indexProductChip]} ในขณะนี้',
              'กรุณารอรายการได้ในภายหลัง')
          : GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 0),
              itemCount: prodVM.productList.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 2 / 3, maxCrossAxisExtent: 160),
              itemBuilder: (context, index) =>
                  buildProductItem(prodVM.productList[index]),
            ),
    );
  }

  Widget buildProductItem(ProductModel product) {
    return Card(
      color: product.status == 0 ? Colors.grey.shade400 : Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => ProductDetail().dialogProduct(context, product),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: VariableGeneral.largeDevice! ? 25.w : 30.w,
              height: 12.h,
              child: SizedBox(
                width: 30.w,
                height: 12.h,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ShowImage().showImage(product.image),
                    ),
                    if (product.suggest == 1) ...[
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
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 25.w,
              child: Text(
                product.name,
                style: MyStyle().normalPrimary16(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              'ราคา ${product.price.toStringAsFixed(0)}.-',
              style: MyStyle().normalBlue16(),
            ),
            Text(
              'สถานะ : ${product.status == 0 ? 'หมด' : 'ขาย'}',
              style: MyStyle().normalBlack14(),
            ),
          ],
        ),
      ),
    );
  }
}
