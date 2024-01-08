import 'package:charoz/Model/Utility/my_style.dart';
import 'package:charoz/View/Widget/my_widget.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final userVM = Get.find<UserViewModel>();

  @override
  void initState() {
    super.initState();
    userVM.initPrivacyList();
  }

  @override
  void dispose() {
    userVM.clearPrivacyList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        appBar: MyWidget().appBarTheme(title: 'ข้อกำหนดเงื่อนไขการให้บริการ'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: GetBuilder<UserViewModel>(
              builder: (vm) => vm.privacyList.isEmpty
                  ? MyWidget().showProgress()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var item in vm.privacyList) ...[
                          SizedBox(height: 2.h),
                          Text(
                            '${item.number}. ${item.name}',
                            style: MyStyle.textStyle(
                                size: 18,
                                color: MyStyle.orangePrimary,
                                bold: true),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            item.detail ?? '-',
                            style: MyStyle.textStyle(
                                size: 16, color: MyStyle.blackPrimary),
                          ),
                          SizedBox(height: 2.h),
                        ],
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
