import 'package:cached_network_image/cached_network_image.dart';
import 'package:charoz/Screen/Product/Model/product_model.dart';
import 'package:charoz/Service/Api/product_api.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Constant/my_function.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Snack extends StatefulWidget {
  final List<ProductModel> productSnacks;
  const Snack({Key? key, required this.productSnacks}) : super(key: key);

  @override
  State<Snack> createState() => _SnackState();
}

class _SnackState extends State<Snack> {
  final scrollController = ScrollController();
  bool scroll = true;
  List<ProductModel> productModels = [];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(listenScrolling);
    productModels = widget.productSnacks;
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

  Future refreshList() async {
    productModels = await ProductApi().getProductWhereType('ออร์เดิฟ');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: productModels.isNotEmpty
            ? RefreshIndicator(
                onRefresh: refreshList,
                child: GridView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  padding: MyVariable.largeDevice
                      ? const EdgeInsets.only(top: 10)
                      : const EdgeInsets.only(top: 0),
                  itemCount: productModels.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 2 / 3, maxCrossAxisExtent: 160),
                  itemBuilder: (context, index) {
                    return buildProductItem(productModels[index], index);
                  },
                ),
              )
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ไม่มีรายการ "อาหาร" ในขณะนี้',
                      style: MyStyle().boldPrimary20(),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'กรุณารอรายการได้ในภายหลัง',
                      style: MyStyle().boldPrimary20(),
                    ),
                  ],
                ),
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

  Widget buildProductItem(ProductModel product, int index) {
    return Card(
      color:
          product.productStatus == 'หมด' ? Colors.grey.shade400 : Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => MyWidget().dialogProductDetail(context, product),
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
                    if (product.productSuggest == '1') ...[
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
              MyFunction().cutWord13(product.productName),
              style: MyStyle().boldPrimary14(),
            ),
            Text(
              '${product.productPrice}.-',
              style: MyStyle().boldBlue14(),
            ),
            Text(
              'สถานะ : ${product.productStatus}',
              style: MyStyle().boldBlack14(),
            ),
          ],
        ),
      ),
    );
  }
}
