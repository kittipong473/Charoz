import 'package:cached_network_image/cached_network_image.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';

class ShowImage {
  Widget bannerImage(String path) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: '${RouteApi.domainBanner}$path',
      placeholder: (context, url) => const ShowProgress(),
      errorWidget: (context, url, error) => Image.asset(MyImage.error),
    );
  }

  Widget notiImage(String path) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: '${RouteApi.domainNoti}$path',
      placeholder: (context, url) => const ShowProgress(),
      errorWidget: (context, url, error) => Image.asset(MyImage.error),
    );
  }

  Widget productImage(String path) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: '${RouteApi.domainProduct}$path',
      placeholder: (context, url) => const ShowProgress(),
      errorWidget: (context, url, error) => Image.asset(MyImage.error),
    );
  }

  Widget shopImage(String path) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: '${RouteApi.domainShop}$path',
      placeholder: (context, url) => const ShowProgress(),
      errorWidget: (context, url, error) => Image.asset(MyImage.error),
    );
  }

  Widget userImage(String path) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: '${RouteApi.domainShop}$path',
      placeholder: (context, url) => const ShowProgress(),
      errorWidget: (context, url, error) => Image.asset(MyImage.person),
    );
  }
}
