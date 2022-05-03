import 'dart:async';

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:charoz/screens/product/model/product_model.dart';
import 'package:charoz/screens/product/provider/product_provider.dart';
import 'package:charoz/screens/user/provider/user_provider.dart';
import 'package:charoz/services/route/route_api.dart';
import 'package:charoz/utils/constant/my_function.dart';
import 'package:charoz/utils/constant/my_image.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:charoz/utils/search.dart';
import 'package:charoz/utils/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuCustomer extends StatefulWidget {
  const MenuCustomer({Key? key}) : super(key: key);

  @override
  _MenuCustomerState createState() => _MenuCustomerState();
}

class _MenuCustomerState extends State<MenuCustomer> {
  final scrollController = ScrollController();
  List<ProductModel> favorites = [];
  bool data = false;
  bool scroll = true;
  double countScore = 0.0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(listenScrolling);
    if (MyVariable.login) {
      getData();
    }
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

  Future getData() async {
    String string = await Provider.of<UserProvider>(context, listen: false)
        .convertFavorite();
    if (string != 'null') {
      favorites = await Provider.of<ProductProvider>(context, listen: false)
          .getProductWhereFavorite(string);
      data = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<ProductProvider>(
          builder: (context, pprovider, child) => GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Column(
                      children: [
                        SizedBox(height: 15.h),
                        buildChip(),
                        if (MyVariable.menuType == 'อาหาร') ...[
                          buildProductList(pprovider.productsFood,
                              pprovider.productsFoodLength),
                        ] else if (MyVariable.menuType == 'ออร์เดิฟ') ...[
                          buildProductList(pprovider.productsSnack,
                              pprovider.productsSnackLength),
                        ] else if (MyVariable.menuType == 'เครื่องดื่ม') ...[
                          buildProductList(pprovider.productsDrink,
                              pprovider.productsDrinkLength),
                        ] else if (MyVariable.menuType == 'ของหวาน') ...[
                          buildProductList(pprovider.productsSweet,
                              pprovider.productsSweetLength),
                        ] else if (MyVariable.login) ...[
                          if (favorites.isNotEmpty) ...[
                            buildFavoriteList(favorites),
                          ] else ...[
                            buildFavoriteEmpty(),
                          ],
                        ],
                      ],
                    )),
                MyWidget().backgroundTitleSearch(),
                MyWidget().title('รายการเมนูอาหาร'),
                buildSearch(context),
              ],
            ),
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

  Positioned buildSearch(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Positioned(
      top: 8.h,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          height: 5.h,
          child: TypeAheadField<ProductModel?>(
            debounceDuration: const Duration(milliseconds: 500),
            textFieldConfiguration: TextFieldConfiguration(
              cursorColor: Colors.black,
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'ค้นหารายการอาหาร...',
                hintStyle: MyStyle().normalGrey16(),
                labelStyle: MyStyle().normalBlack16(),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: MyStyle.primary,
                ),
                border: InputBorder.none,
              ),
            ),
            suggestionsCallback: ProductSearch.getSuggestion,
            itemBuilder: (context, ProductModel? suggestion) {
              final product = suggestion!;
              return Container(
                color: product.productStatus == 'หมด'
                    ? Colors.black26
                    : Colors.white,
                child: ListTile(
                  leading: SizedBox(
                    width: 15.w,
                    height: 15.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            '${RouteApi.domainProduct}${product.productImage}',
                        placeholder: (context, url) => const ShowProgress(),
                        errorWidget: (context, url, error) =>
                            Image.asset(MyImage.error),
                      ),
                    ),
                  ),
                  title: Text(
                    product.productName,
                    style: MyStyle().normalBlack14(),
                  ),
                  subtitle: Text(
                    product.productPrice,
                    style: MyStyle().normalBlack14(),
                  ),
                  trailing: Text(
                    product.productStatus,
                    style: MyStyle().normalBlack14(),
                  ),
                ),
              );
            },
            noItemsFoundBuilder: (context) => Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              height: 5.h,
              child: const Center(
                child: Text(
                  'ไม่พบรายการที่คุณเลือก',
                ),
              ),
            ),
            onSuggestionSelected: (ProductModel? product) =>
                dialogProductDetail(context, product!),
          ),
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
              chip('อาหาร', 0),
              chip('ออร์เดิฟ', 1),
              chip('เครื่องดื่ม', 2),
              chip('ของหวาน', 3),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (MyVariable.login) ...[
                chipFav(4),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget chip(String title, int index) {
    return ActionChip(
      backgroundColor: MyVariable.menuIndex == index
          ? MyStyle.primary
          : Colors.grey.shade300,
      label: Text(
        title,
        style: MyVariable.menuIndex == index
            ? MyStyle().boldWhite14()
            : MyStyle().boldBlack14(),
      ),
      onPressed: () {
        setState(() {
          MyVariable.menuIndex = index;
          MyVariable.menuType = title;
        });
      },
    );
  }

  Widget chipFav(int index) {
    return ActionChip(
      avatar: Icon(
        Icons.star_outlined,
        color: MyVariable.menuIndex == index ? Colors.white : Colors.black,
      ),
      backgroundColor: MyVariable.menuIndex == index
          ? MyStyle.primary
          : Colors.grey.shade300,
      label: Text(
        'รายการโปรด',
        style: MyVariable.menuIndex == index
            ? MyStyle().boldWhite16()
            : MyStyle().boldBlack16(),
      ),
      onPressed: () {
        setState(() {
          MyVariable.menuIndex = index;
          MyVariable.menuType = 'รายการโปรด';
        });
      },
    );
  }

  Widget buildProductList(List<ProductModel> products, int length) {
    return Flexible(
      child: GridView.builder(
        shrinkWrap: true,
        controller: scrollController,
        padding: MyVariable.largeDevice
            ? const EdgeInsets.only(top: 10)
            : const EdgeInsets.only(top: 0),
        itemCount: length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 2 / 3, maxCrossAxisExtent: 160),
        itemBuilder: (context, index) {
          return buildProductItem(products[index], index);
        },
      ),
    );
  }

  Widget buildProductItem(ProductModel product, int index) {
    bool isFav = false;
    isFav = Provider.of<ProductProvider>(context, listen: false)
        .checkFavorite(product.productId, favorites);
    bool isSug = false;
    if (product.productSuggest == '1') {
      isSug = true;
    }
    return Consumer<UserProvider>(
      builder: (context, uprovider, child) => Card(
        color: product.productStatus == 'หมด'
            ? Colors.grey.shade400
            : Colors.white,
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => dialogProductDetail(context, product),
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
                      if (MyVariable.login) ...[
                        isFav
                            ? Positioned(
                                top: 5,
                                right: 5,
                                child: InkWell(
                                  onTap: () {
                                    favorites.remove(product);
                                    setState(() {
                                      isFav = false;
                                    });
                                    uprovider.removeFavorite(product.productId);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15.sp,
                                    child: Lottie.asset(MyImage.gifFavorite),
                                  ),
                                ),
                              )
                            : Positioned(
                                top: 5,
                                right: 5,
                                child: InkWell(
                                  onTap: () {
                                    favorites.add(product);
                                    setState(() {
                                      isFav = true;
                                    });
                                    uprovider.addFavorite(product.productId);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15.sp,
                                    child: Icon(
                                      Icons.favorite_border_rounded,
                                      size: 15.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                      if (isSug) ...[
                        Positioned(
                          top: 5,
                          left: 5,
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
      ),
    );
  }

  Widget buildFavoriteList(List<ProductModel> products) {
    return Flexible(
      child: GridView.builder(
        shrinkWrap: true,
        controller: scrollController,
        padding: MyVariable.largeDevice
            ? const EdgeInsets.only(top: 10)
            : const EdgeInsets.only(top: 0),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 2 / 3, maxCrossAxisExtent: 160),
        itemBuilder: (context, index) {
          return buildFavoriteItem(products[index], index);
        },
      ),
    );
  }

  Widget buildFavoriteItem(ProductModel product, int index) {
    bool isSug = false;
    if (product.productSuggest == '1') {
      isSug = true;
    }
    return Card(
      color:
          product.productStatus == 'หมด' ? Colors.grey.shade400 : Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => dialogProductDetail(context, product),
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
                    if (isSug) ...[
                      Positioned(
                        top: 5,
                        left: 5,
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
              style: MyStyle().boldPrimary14(),
            ),
            Text(
              'ราคา : ${product.productPrice} บาท',
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

  Widget buildFavoriteEmpty() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          Text(
            'ไม่มีรายการโปรดที่เพิ่มไว้',
            style: MyStyle().boldBlue18(),
          ),
          SizedBox(height: 3.h),
          SizedBox(
            width: 80.w,
            child: Text(
              'กรุณาเพิ่มรายการโปรด โดยการกดที่รูปหัวใจของแต่ละรายการอาหาร',
              style: MyStyle().boldBlue18(),
            ),
          ),
        ],
      ),
    );
  }

  void dialogProductDetail(BuildContext context, ProductModel product) {
    // countScore = 0;
    // Timer.periodic(const Duration(milliseconds: 1000), (_) {
    //   if (countScore < double.parse(product.productScore)) {
    //     print(countScore);
    //     setState(() => countScore = countScore + 0.1);
    //   }
    // });
    // countScorePlus(double.parse(product.productScore));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.productName,
                    style: MyStyle().boldPrimary18(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(MyImage.gifScoreRate,
                      width: 30.sp, height: 30.sp),
                  Text(
                    'ความอร่อย : ${product.productScore}',
                    style: MyStyle().boldGreen18(),
                  ),
                  Lottie.asset(MyImage.gifScoreRate,
                      width: 30.sp, height: 30.sp),
                ],
              ),
              Text(
                'ราคา : ${product.productPrice} บาท',
                style: MyStyle().boldBlue18(),
              ),
              Text(
                'ประเภท : ${product.productType}',
                style: MyStyle().boldPrimary18(),
              ),
              Text(
                'สถานะ : ${product.productStatus}',
                style: MyStyle().boldBlue18(),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 60.w,
                height: 60.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        '${RouteApi.domainProduct}${product.productImage}',
                    placeholder: (context, url) => const ShowProgress(),
                    errorWidget: (context, url, error) =>
                        Image.asset(MyImage.error),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 60.w,
                child: Text(
                  product.productDetail,
                  style: MyStyle().normalBlack16(),
                ),
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }
}
