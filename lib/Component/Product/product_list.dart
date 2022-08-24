import 'package:charoz/Component/Product/Modal/add_product.dart';
import 'package:charoz/Component/Product/Dialog/product_detail.dart';
import 'package:charoz/Model_Main/product_model.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/search_product.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .readProductAllList();
    await Provider.of<ProductProvider>(context, listen: false)
        .readProductTypeList(
            MyVariable.productTypes[MyVariable.indexProductChip]);
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
    if (MyVariable.role == 'manager') {
      return FloatingActionButton(
        backgroundColor: MyStyle.bluePrimary,
        child: const Icon(Icons.add_rounded, color: Colors.white),
        onPressed: () => AddProduct().openModalAddProduct(context),
      );
    } else if (MyVariable.role == 'customer') {
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
              chip(MyVariable.productTypes[0], 0),
              chip(MyVariable.productTypes[1], 1),
              chip(MyVariable.productTypes[2], 2),
              chip(MyVariable.productTypes[3], 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget chip(String title, int index) {
    return ActionChip(
      backgroundColor: MyVariable.indexProductChip == index
          ? MyStyle.primary
          : Colors.grey.shade300,
      label: Text(
        title,
        style: MyVariable.indexProductChip == index
            ? MyStyle().normalWhite16()
            : MyStyle().normalBlack16(),
      ),
      onPressed: () {
        setState(() => MyVariable.indexProductChip = index);
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
      child: Consumer<ProductProvider>(
        builder: (_, provider, __) => provider.productList == null
            ? ScreenWidget().showEmptyData(
                'ไม่มีรายการ ${MyVariable.productTypes[MyVariable.indexProductChip]} ในขณะนี้',
                'กรุณารอรายการได้ในภายหลัง')
            : GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 0),
                itemCount: provider.productList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 2 / 3, maxCrossAxisExtent: 160),
                itemBuilder: (context, index) =>
                    buildProductItem(provider.productList[index]),
              ),
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
              width: MyVariable.largeDevice ? 25.w : 30.w,
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
            Text(
              MyFunction().cutWord10(product.name),
              style: MyStyle().normalPrimary16(),
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
