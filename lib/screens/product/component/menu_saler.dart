import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:charoz/screens/product/component/edit_product.dart';
import 'package:charoz/screens/product/model/product_model.dart';
import 'package:charoz/screens/product/provider/product_provider.dart';
import 'package:charoz/services/api/product_api.dart';
import 'package:charoz/services/route/route_api.dart';
import 'package:charoz/services/route/route_page.dart';
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

class MenuSaler extends StatefulWidget {
  const MenuSaler({Key? key}) : super(key: key);

  @override
  _MenuSalerState createState() => _MenuSalerState();
}

class _MenuSalerState extends State<MenuSaler> {
  final scrollController = ScrollController();
  List<ProductModel> productFoods = [];
  List<ProductModel> productSnacks = [];
  List<ProductModel> productDrinks = [];
  List<ProductModel> productSweets = [];
  bool scroll = true;
  bool load = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(listenScrolling);
    getData();
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
    productFoods = await ProductApi().getProductWhereType('อาหาร');
    productSnacks = await ProductApi().getProductWhereType('ออร์เดิฟ');
    productDrinks = await ProductApi().getProductWhereType('เครื่องดื่ม');
    productSweets = await ProductApi().getProductWhereType('ของหวาน');
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<ProductProvider>(
          builder: (context, pprovider, child) => load
              ? const ShowProgress()
              : GestureDetector(
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
                                buildProductList(
                                    productFoods, productFoods.length),
                              ] else if (MyVariable.menuType == 'ออร์เดิฟ') ...[
                                buildProductList(
                                    productSnacks, productSnacks.length),
                              ] else if (MyVariable.menuType ==
                                  'เครื่องดื่ม') ...[
                                buildProductList(
                                    productDrinks, productDrinks.length),
                              ] else if (MyVariable.menuType == 'ของหวาน') ...[
                                buildProductList(
                                    productSweets, productSweets.length),
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
          width: 80.w,
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
              addProduct(),
            ],
          )
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

  Widget addProduct() {
    return ActionChip(
      avatar: const Icon(
        Icons.add_rounded,
        color: Colors.white,
      ),
      backgroundColor: Colors.green,
      label: Text(
        'เพิ่มรายการ',
        style: MyStyle().boldWhite14(),
      ),
      onPressed: () => Navigator.pushNamed(context, RoutePage.routeAddProduct)
          .then((value) => getData()),
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
              style: MyStyle().boldPrimary16(),
            ),
            Text(
              '${product.productPrice}.-',
              style: MyStyle().boldBlue16(),
            ),
            Text(
              'สถานะ : ${product.productStatus}',
              style: MyStyle().boldBlack16(),
            ),
          ],
        ),
      ),
    );
  }

  void dialogProductDetail(BuildContext context, ProductModel product) {
    String? status;
    if (product.productStatus == 'หมด') {
      status = 'ขาย';
    } else {
      status = 'หมด';
    }
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) => SimpleDialog(
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
                Lottie.asset(MyImage.gifScoreRate, width: 30.sp, height: 30.sp),
                Text(
                  'ความอร่อย : ${product.productScore}',
                  style: MyStyle().boldGreen18(),
                ),
                Lottie.asset(MyImage.gifScoreRate, width: 30.sp, height: 30.sp),
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
                  fit: BoxFit.fill,
                  imageUrl: '${RouteApi.domainProduct}${product.productImage}',
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
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  ProductProvider()
                      .changeStatus(
                        status!,
                        product.productType,
                        product.productId,
                      )
                      .then((value) => getData());
                  Navigator.pop(context);
                },
                child: Text(
                  'เปลี่ยนสถานะ',
                  style: MyStyle().boldBlue16(),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProduct(
                        productId: product.productId,
                        productType: product.productType,
                        productName: product.productName,
                        productPrice: product.productPrice,
                        productDetail: product.productDetail,
                        productImage: product.productImage,
                        productSuggest: int.parse(product.productSuggest),
                      ),
                    ),
                  ).then((value) => getData());
                },
                child: Text(
                  'แก้ไข',
                  style: MyStyle().boldGreen16(),
                ),
              ),
              TextButton(
                onPressed: () async {
                  bool result = await ProductApi()
                      .deleteProductWhereId(id: product.productId);
                  if (result) {
                    MyWidget().toast('ลบรายการ ${product.productName} สำเร็จ');
                    getData();
                  } else {
                    MyWidget().toast(
                        'ลบรายการ ${product.productName} ล้มเหลว ลองใหม่อีกครั้ง');
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'ลบ',
                  style: MyStyle().boldRed16(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
