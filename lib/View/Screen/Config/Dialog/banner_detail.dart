import 'package:charoz/View/Widget/my_widget.dart';
import 'package:flutter/material.dart';

class BannerDetail {
  final BuildContext context;
  BannerDetail(this.context);

  void dialogBanner({required String path}) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        titlePadding: const EdgeInsets.all(0),
        title: MyWidget().showImage(path: path, fit: BoxFit.contain),
      ),
    );
  }
}
