import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:charoz/Screen/Product/Component/edit_product.dart';
import 'package:charoz/Screen/Product/Model/product_model.dart';
import 'package:charoz/Screen/Product/Provider/product_provider.dart';
import 'package:charoz/Screen/Shop/Component/edit_shop_admin.dart';
import 'package:charoz/Screen/Shop/Component/edit_shop_saler.dart';
import 'package:charoz/Screen/Shop/Model/shop_model.dart';
import 'package:charoz/Screen/Shop/Model/time_model.dart';
import 'package:charoz/Screen/User/Component/login_phone.dart';
import 'package:charoz/Service/Api/product_api.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Widget/search.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyWidget {
  Future toast(String title) async {
    return Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Positioned backgroundTitle() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 8.h,
        decoration: const BoxDecoration(
          color: MyStyle.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }

  Positioned backgroundTitleSearch() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 14.h,
        decoration: const BoxDecoration(
          color: MyStyle.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }

  Positioned title(String title) {
    return Positioned(
      top: 4.h,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: MyStyle().boldWhite18(),
          ),
        ],
      ),
    );
  }

  Widget buildTitle({required String title}) {
    return Row(
      children: [
        Text(
          title,
          style: MyStyle().boldDark18(),
        ),
      ],
    );
  }

  Widget buildTitlePadding({required String title}) {
    return Padding(
      padding: MyVariable.largeDevice
          ? const EdgeInsets.symmetric(horizontal: 40)
          : const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: MyStyle().boldDark18(),
          ),
        ],
      ),
    );
  }

  Positioned backPage(BuildContext context) {
    return Positioned(
      top: MyVariable.largeDevice ? 30 : 20,
      left: MyVariable.largeDevice ? 30 : 10,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
          size: 20.sp,
        ),
      ),
    );
  }

  Positioned editShop(BuildContext context, ShopModel shop, TimeModel time) {
    return Positioned(
      top: MyVariable.largeDevice ? 60 : 20,
      right: MyVariable.largeDevice ? 30 : 10,
      child: IconButton(
        onPressed: () {
          if (MyVariable.role == "saler") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditShopSaler(
                  shopId: shop.shopId,
                  shopName: shop.shopName,
                  shopAnnounce: shop.shopAnnounce,
                  shopDetail: shop.shopDetail,
                  timeType: time.timeChoose,
                  timeWeekdayOpen: time.timeWeekdayOpen,
                  timeWeekdayClose: time.timeWeekdayClose,
                  timeWeekendOpen: time.timeWeekendOpen,
                  timeWeekendClose: time.timeWeekendClose,
                  shopVideo: shop.shopVideo,
                ),
              ),
            );
          } else if (MyVariable.role == "admin") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditShopAdmin(
                  id: shop.shopId,
                  address: shop.shopAddress,
                  lat: shop.shopLat,
                  lng: shop.shopLng,
                ),
              ),
            );
          }
        },
        icon: Icon(
          Icons.edit_location_alt_rounded,
          color: Colors.white,
          size: MyVariable.largeDevice ? 30 : 20,
        ),
      ),
    );
  }

  Positioned createNoti(BuildContext context) {
    return Positioned(
      top: MyVariable.largeDevice ? 60 : 20,
      right: MyVariable.largeDevice ? 30 : 10,
      child: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutePage.routeNotiCreate);
        },
        icon: Icon(
          Icons.notification_add_rounded,
          color: Colors.white,
          size: MyVariable.largeDevice ? 30 : 20,
        ),
      ),
    );
  }

  Positioned loginIcon(BuildContext context) {
    return Positioned(
      top: MyVariable.largeDevice ? 60 : 20,
      right: MyVariable.largeDevice ? 30 : 10,
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPhone(),
            ),
          );
        },
        icon: Icon(
          Icons.login_rounded,
          color: Colors.white,
          size: 20.sp,
        ),
      ),
    );
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

  void dialogProductDetail(BuildContext context, ProductModel product) {
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
          children: [
            if (MyVariable.role == 'manager') ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      String status = '';
                      if (product.productStatus == 'ขาย') {
                        status = 'หมด';
                      } else if (product.productStatus == 'หมด') {
                        status = 'ขาย';
                      }
                      ProductApi()
                          .changeProductStatusWhereId(
                              id: product.productId, status: status)
                          .then((value) {
                        MyWidget().toast('เปลี่ยนสถานะเป็น $status');
                        Navigator.pop(context);
                        Provider.of<ProductProvider>(context, listen: false)
                            .getAllProduct();
                      });
                    },
                    child: Text(
                      'เปลี่ยนสถานะ',
                      style: MyStyle().boldBlue16(),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProduct(product: product),
                      ),
                    ),
                    child: Text(
                      'แก้ไข',
                      style: MyStyle().boldGreen16(),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ProductApi()
                          .deleteProductWhereId(id: product.productId)
                          .then((value) {
                        MyWidget().toast('ลบรายการ ${product.productName}');
                        Navigator.pop(context);
                        Provider.of<ProductProvider>(context, listen: false)
                            .getAllProduct();
                      });
                    },
                    child: Text(
                      'ลบ',
                      style: MyStyle().boldRed16(),
                    ),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }

  // Widget buildQRcode() {
  //   return Column(
  //     children: [
  //       QrImage(
  //         data: controller.text,
  //         size: 200,
  //         backgroundColor: Colors.white,
  //       ),
  //       const SizedBox(height: 40),
  //       TextField(
  //         controller: controller,
  //         decoration: InputDecoration(
  //           hintText: "Enter the Data",
  //           suffixIcon: IconButton(
  //             icon: const Icon(Icons.send_rounded),
  //             onPressed: () => setState(() {}),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget buildOpenScanner() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const Scanner(),
  //         ),
  //       );
  //     },
  //     child: const Text('Open Scanner'),
  //   );
  // }
}
