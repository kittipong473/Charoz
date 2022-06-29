import 'package:cached_network_image/cached_network_image.dart';
import 'package:charoz/Model/product_model.dart';
import 'package:charoz/Provider/order_provider.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_detail.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
    return Consumer<OrderProvider>(
      builder: (_, provider, __) {
        List<ProductModel> suggestions = provider.productAlls.where((item) {
          final result = item.productName.toLowerCase();
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
                  itemBuilder: (context, index) {
                    final suggestion = suggestions[index];
                    return Card(
                      elevation: 5,
                      color: suggestion.productStatus == 0
                          ? Colors.grey.shade400
                          : Colors.white,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            width: 15.w,
                            height: 15.w,
                            fit: BoxFit.cover,
                            imageUrl:
                                '${RouteApi.domainProduct}${suggestion.productImage}',
                            placeholder: (context, url) => const ShowProgress(),
                            errorWidget: (context, url, error) =>
                                Image.asset(MyImage.error),
                          ),
                        ),
                        title: Text(
                          suggestion.productName,
                          style: MyStyle().normalPrimary16(),
                        ),
                        subtitle: Text(
                          '${suggestion.productPrice} ฿',
                          style: MyStyle().normalBlue16(),
                        ),
                        trailing: Text(
                          suggestion.productStatus == 1 ? 'ขาย' : 'หมด',
                          style: MyStyle().normalGreen14(),
                        ),
                        onTap: () {
                          query = '';
                          Navigator.pop(context);
                          DialogDetail().dialogProduct(context, suggestion);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
