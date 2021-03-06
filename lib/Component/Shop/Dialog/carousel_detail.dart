import 'package:animations/animations.dart';
import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/show_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarouselDetail {
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  void dialogCarousel(BuildContext context, String path) {
    transformationController = TransformationController();
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          title: Column(
            children: [
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
                    child: ShowImage().showBanner(path),
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                'เลื่อนนิ้วเพื่อ zoom เข้า zoom ออก',
                style: MyStyle().normalBlack16(),
              ),
              SizedBox(height: 3.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyStyle.colorBackGround,
                ),
                width: 20.w,
                height: 20.w,
                child: Lottie.asset(MyImage.gifZoom),
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  void dialogShop(BuildContext context, String path) {
    transformationController = TransformationController();
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          title: Column(
            children: [
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
                style: MyStyle().normalBlack16(),
              ),
              SizedBox(height: 3.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyStyle.colorBackGround,
                ),
                width: 20.w,
                height: 20.w,
                child: Lottie.asset(MyImage.gifZoom),
              ),
              SizedBox(height: 3.h),
            ],
          ),
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
