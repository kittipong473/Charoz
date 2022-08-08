import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConfigProvider>(context, listen: false).readPrivacyList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        appBar: ScreenWidget().appBarTheme('ข้อกำหนดเงื่อนไขการให้บริการ'),
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Consumer<ConfigProvider>(
                  builder: (_, cprovider, __) => cprovider.privacyList == null
                      ? const ShowProgress()
                      : Padding(
                          padding: EdgeInsets.all(5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var item in cprovider.privacyList) ...[
                                buildName(item.number, item.name),
                                SizedBox(height: 2.h),
                                buildDetail(item.detail),
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
    return Text('$id. $name', style: MyStyle().boldPrimary16());
  }

  Text buildDetail(String detail) {
    return Text(detail, style: MyStyle().normalBlack14());
  }
}
