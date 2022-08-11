import 'package:charoz/Component/Product/Dialog/product_detail.dart';
import 'package:charoz/Model_Main/product_model.dart';
import 'package:charoz/Provider/product_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchProduct extends SearchDelegate {
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
    return Consumer<ProductProvider>(
      builder: (_, provider, __) {
        List<ProductModel> suggestions = provider.productAlls.where((item) {
          final result = item.name.toLowerCase();
          final input = query.toLowerCase();
          return result.contains(input) ? true : false;
        }).toList();
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 2.h),
              Text(
                'Product list : ${suggestions.length} menu',
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
      },
    );
  }

  Widget buildItem(ProductModel product, BuildContext context) {
    return Card(
      elevation: 5,
      color: product.status == 0 ? Colors.grey.shade400 : Colors.white,
      child: ListTile(
        leading: SizedBox(
          width: 15.w,
          height: 15.w,
          child: ShowImage().showImage(product.image),
        ),
        title: Text(product.name, style: MyStyle().normalPrimary16()),
        subtitle: Text('${product.price} ฿', style: MyStyle().normalBlue16()),
        trailing: Text(product.status == 1 ? 'ขาย' : 'หมด',
            style: MyStyle().normalGreen14()),
        onTap: () {
          query = '';
          Navigator.pop(context);
          ProductDetail().dialogProduct(context, product);
        },
      ),
    );
  }
}
