import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:charoz/View/Widget/screen_widget.dart';
import 'package:charoz/View/Widget/show_progress.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class QuestionAnswer extends StatefulWidget {
  const QuestionAnswer({Key? key}) : super(key: key);

  @override
  State<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  final userVM = Get.find<UserViewModel>();

  @override
  void initState() {
    super.initState();
    userVM.initQuestionList();
  }

  @override
  void dispose() {
    userVM.clearQuestionList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.backgroundColor,
        appBar: ScreenWidget().appBarTheme('คำถามเกี่ยวกับแอพพลิเคชั่น'),
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: GetBuilder<UserViewModel>(
                    builder: (vm) => vm.questionList.isEmpty
                        ? const ShowProgress()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var item in vm.questionList) ...[
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
