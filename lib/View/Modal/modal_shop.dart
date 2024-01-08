import 'package:charoz/Model/Utility/my_image.dart';
import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ModalShop {
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  Future<void> showModal(BuildContext context, String path) {
    transformationController = TransformationController();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        color: MyStyle.backgroundColor,
        width: 100.w,
        height: 85.h,
        child: Column(
          children: [
            MyWidget().buildModalHeader(title: 'รายละเอียดรูปภาพ'),
            SizedBox(
              height: 25.h,
              child: InteractiveViewer(
                transformationController: transformationController,
                clipBehavior: Clip.none,
                panEnabled: false,
                minScale: 1,
                maxScale: 4,
                onInteractionEnd: (details) => resetAnimation(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(path, fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'เลื่อนนิ้วเพื่อ zoom เข้า zoom ออก',
              style: MyStyle.textStyle(size: 16, color: MyStyle.blackPrimary),
            ),
            SizedBox(height: 3.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyStyle.backgroundColor,
              ),
              width: 20.w,
              height: 20.w,
              child: MyWidget().showImage(path: MyImage.lotZoom),
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: transformationController.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    animationController.forward(from: 0);
  }
}
