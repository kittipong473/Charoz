import 'package:cached_network_image/cached_network_image.dart';
import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Function/dialog_detail.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/search_product.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
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
    Provider.of<OrderProvider>(context, listen: false).getAllProduct();
    scrollController.addListener(listenScrolling);
    super.initState();
  }

  Future getData() async {
    Provider.of<OrderProvider>(context, listen: false).getAllProductWhereType(
        MyVariable.productTypes[MyVariable.indexProductChip]);
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
        floatingActionButton: FloatingActionButton(
          child: scroll
              ? const Icon(Icons.arrow_downward_rounded)
              : const Icon(Icons.arrow_upward_rounded),
          onPressed: scroll ? scrollDown : scrollUp,
        ),
      ),
    );
  }

  Widget buildProductList() {
    return SizedBox(
      width: 100.w,
      height: MyVariable.role == 'manager' ? 65.h : 70.h,
      child: Consumer<OrderProvider>(
        builder: (_, provider, __) => provider.productLists == null
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ไม่มีรายการอาหารในขณะนี้',
                        style: MyStyle().boldPrimary20()),
                    SizedBox(height: 3.h),
                    Text('กรุณารอรายการได้ในภายหลัง',
                        style: MyStyle().boldPrimary20()),
                  ],
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                controller: scrollController,
                padding: MyVariable.largeDevice
                    ? const EdgeInsets.only(top: 10)
                    : const EdgeInsets.only(top: 0),
                itemCount: provider.productLists.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 2 / 3, maxCrossAxisExtent: 160),
                itemBuilder: (context, index) =>
                    buildProductItem(provider.productLists[index], index),
              ),
      ),
    );
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
          if (MyVariable.role == 'manager') ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                chipAddProduct(),
              ],
            ),
          ],
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
        setState(() {
          MyVariable.indexProductChip = index;
          getData();
        });
      },
    );
  }

  Widget chipAddProduct() {
    return ActionChip(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: MyStyle.bluePrimary,
      label: Row(
        children: [
          Icon(
            Icons.add_rounded,
            size: 20.sp,
            color: Colors.white,
          ),
          Text(
            'เพิ่มรายการ',
            style: MyStyle().boldWhite14(),
          ),
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(context, RoutePage.routeAddProduct);
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

  Widget buildProductItem(ProductModel product, int index) {
    return Card(
      color: product.productStatus == 0 ? Colors.grey.shade400 : Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => DialogDetail().dialogProduct(context, product),
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:
                              '${RouteApi.domainProduct}${product.productImage}',
                          placeholder: (context, url) => const ShowProgress(),
                          errorWidget: (context, url, error) =>
                              Image.asset(MyImage.error),
                        ),
                      ),
                    ),
                    if (product.productSuggest == 0) ...[
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
}
