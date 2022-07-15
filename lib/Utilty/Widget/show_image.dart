import 'package:cached_network_image/cached_network_image.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';

class ShowImage {
  Widget showImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: url,
        placeholder: (context, url) => const ShowProgress(),
        errorWidget: (context, url, error) => Image.asset(MyImage.error),
      ),
    );
  }

  Widget showBanner(String path) => showImage('${RouteApi.domainBanner}$path');
  Widget showNoti(String path) => showImage('${RouteApi.domainNoti}$path');
  Widget showProduct(String path) =>
      showImage('${RouteApi.domainProduct}$path');
  Widget showShop(String path) => showImage('${RouteApi.domainShop}$path');
  Widget showUser(String path) => showImage('${RouteApi.domainUser}$path');
}
