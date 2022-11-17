import 'package:cached_network_image/cached_network_image.dart';
import 'package:charoz/Util/Constant/my_image.dart';
import 'package:charoz/Util/Constant/my_style.dart';
import 'package:charoz/View/Widget/show_progress.dart';
import 'package:flutter/material.dart';

class ShowImage {
  Widget showImage(String url) {
    return ClipRRect(
      borderRadius: MyStyle().borderRadius(10),
      child: url == ''
          ? Image.asset(MyImage.image)
          : CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: url,
              placeholder: (context, url) => const ShowProgress(),
              errorWidget: (context, url, error) => Image.asset(MyImage.error),
            ),
    );
  }

  Widget showCircleImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: url,
        placeholder: (context, url) => const ShowProgress(),
        errorWidget: (context, url, error) => Image.asset(MyImage.error),
      ),
    );
  }
}
