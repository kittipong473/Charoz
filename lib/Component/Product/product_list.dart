import 'package:charoz/Component/Product/Modal/add_product.dart';
import 'package:charoz/Component/Product/Dialog/product_detail.dart';
import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/global_variable.dart';
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
  final scrollController = ScrollController();
  bool scroll = true;
  double countScore = 0.0;

  @override
  void initState() {
    getData();
    scrollController.addListener(listenScrolling);
    super.initState();
  }

  Future getData() async {
    Provider.of<ProductProvider>(context, listen: false).getAllProductWhereType(
        GlobalVariable.productTypes[GlobalVariable.indexProductChip]);
  }

  void listenScrolling() {
    if (scrollController.position.atEdge) {
      final isTop = scrollController.position.pixels == 0;
      if (isTop) {
        setState(() {
          scroll = true;
        });
      } else {
        setState(() {
          scroll = false;
        });
      }
    }
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
              top: 16.h,
              child: RefreshIndicator(
                onRefresh: getData,
                child: Column(
                  children: [
                    buildChip(),
                    buildProductList(),
                  ],
                ),
              ),
            ),
            ScreenWidget().appBarTitleLarge('รายการเมนูอาหาร'),
            buildSearch(),
          ],
        ),
        floatingActionButton: GlobalVariable.role == 'manager'
            ? FloatingActionButton(
                backgroundColor: MyStyle.bluePrimary,
                child: const Icon(Icons.add_rounded, color: Colors.white),
                onPressed: () => AddProduct().openModalAddProduct(context),
              )
            : FloatingActionButton(
                backgroundColor: MyStyle.bluePrimary,
                child: scroll
                    ? const Icon(Icons.arrow_downward_rounded,
                        color: Colors.white)
                    : const Icon(Icons.arrow_upward_rounded,
                        color: Colors.white),
                onPressed: scroll ? scrollDown : scrollUp,
              ),
      ),
    );
  }

  void scrollUp() {
    double start = 0;
    scrollController.animateTo(start,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void scrollDown() {
    double end = scrollController.position.maxScrollExtent;
    scrollController.animateTo(end,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  Widget buildChip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              chip(GlobalVariable.productTypes[0], 0),
              chip(GlobalVariable.productTypes[1], 1),
              chip(GlobalVariable.productTypes[2], 2),
              chip(GlobalVariable.productTypes[3], 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget chip(String title, int index) {
    return ActionChip(
      backgroundColor: GlobalVariable.indexProductChip == index
          ? MyStyle.primary
          : Colors.grey.shade300,
      label: Text(
        title,
        style: GlobalVariable.indexProductChip == index
            ? MyStyle().normalWhite16()
            : MyStyle().normalBlack16(),
      ),
      onPressed: () {
        setState(() => GlobalVariable.indexProductChip = index);
        getData();
      },
    );
  }

  Positioned buildSearch() {
    return Positioned(
      top: 8.h,
      left: 10.w,
      right: 10.w,
      child: InkWell(
        onTap: () => showSearch(context: context, delegate: SearchProduct()),
        child: Container(
          height: 5.h,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
      height: 70.h,
      child: Consumer<ProductProvider>(
        builder: (_, provider, __) => provider.productList == null
            ? ScreenWidget().showEmptyData(
                'ไม่มีรายการ ${GlobalVariable.productTypes[GlobalVariable.indexProductChip]} ในขณะนี้',
                'กรุณารอรายการได้ในภายหลัง')
            : GridView.builder(
                shrinkWrap: true,
                controller: scrollController,
                padding: const EdgeInsets.only(top: 0),
                itemCount: provider.productList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 2 / 3, maxCrossAxisExtent: 160),
                itemBuilder: (context, index) =>
                    buildProductItem(provider.productList[index], index),
              ),
      ),
    );
  }

  Widget buildProductItem(ProductModel product, int index) {
    return Card(
      color: product.productStatus == 0 ? Colors.grey.shade400 : Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => ProductDetail().dialogProduct(context, product),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: GlobalVariable.largeDevice ? 25.w : 30.w,
              height: 12.h,
              child: SizedBox(
                width: 30.w,
                height: 12.h,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ShowImage().showProduct(product.productImage),
                    ),
                    if (product.productSuggest == 1) ...[
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
              MyFunction().cutWord10(product.productName),
              style: MyStyle().normalPrimary16(),
            ),
            Text(
              'ราคา ${product.productPrice.toStringAsFixed(0)}.-',
              style: MyStyle().normalBlue16(),
            ),
            Text(
              'สถานะ : ${product.productStatus == 0 ? 'หมด' : 'ขาย'}',
              style: MyStyle().normalBlack14(),
            ),
          ],
        ),
      ),
    );
  }
}
