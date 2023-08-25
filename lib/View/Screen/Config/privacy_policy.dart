import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View/Widget/show_progress.dart';
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
        appBar: ScreenWidget().appBarTheme('ข้อกำหนดเงื่อนไขการให้บริการ'),
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: GetBuilder<UserViewModel>(
                    builder: (vm) => vm.privacyList.isEmpty
                        ? const ShowProgress()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var item in vm.privacyList) ...[
                                buildName(item.number!, item.name!),
                                SizedBox(height: 2.h),
                                buildDetail(item.detail!),
                                SizedBox(height: 2.h),
                              ],
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text buildName(int id, String name) {
    return Text('$id. $name', style: MyStyle().boldPrimary18());
  }

  Text buildDetail(String detail) {
    return Text(detail, style: MyStyle().normalBlack16());
  }
}
