import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/View/Modal/modal_product.dart';
import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:charoz/View/Widget/show_image.dart';
import 'package:charoz/View_Model/product_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchProduct extends SearchDelegate {
  final ProductViewModel prodVM = Get.find<ProductViewModel>();

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () => close(context, null),
      );

  @override
  List<Widget> buildActions(BuildContext context) => [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: IconButton(
            onPressed: () => query = '',
            icon: const Icon(Icons.cancel_rounded),
          ),
        )
      ];

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductModel> suggestions = prodVM.productList.where((item) {
      final name = item.name.toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input) ? true : false;
    }).toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 2.h),
          Text(
            'รายการทั้งหมด : ${suggestions.length} menu',
            style: MyStyle().normalGrey16(),
          ),
          SizedBox(
            width: 100.w,
            height: 82.h,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: suggestions.length,
              itemBuilder: (context, index) =>
                  buildItem(suggestions[index], context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(ProductModel product, BuildContext context) {
    return Card(
      elevation: 5,
      color: product.status! ? Colors.white : Colors.grey.shade400,
      child: ListTile(
        leading: SizedBox(
          width: 15.w,
          height: 15.w,
          child: ShowImage().showImage(product.image, BoxFit.cover),
        ),
        title: Text(product.name ?? '', style: MyStyle().normalPrimary16()),
        subtitle: Text('${product.price} ฿', style: MyStyle().normalBlue16()),
        trailing: Text(product.status! ? 'ขาย' : 'หมด',
            style: MyStyle().normalGreen14()),
        onTap: () {
          query = '';
          Get.back();
          prodVM.setProductModel(product);
          ModalProduct().showModal(context);
        },
      ),
    );
  }
}
