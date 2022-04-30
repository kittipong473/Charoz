import 'package:charoz/screens/home/provider/suggest_provider.dart';
import 'package:charoz/utils/constant/my_image.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:charoz/utils/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SuggestDetail extends StatefulWidget {
  final String id;
  const SuggestDetail({Key? key, required this.id}) : super(key: key);

  @override
  _SuggestDetailState createState() => _SuggestDetailState();
}

class _SuggestDetailState extends State<SuggestDetail> {
  @override
  void initState() {
    super.initState();
    Provider.of<SuggestProvider>(context, listen: false)
        .getSuggestWhereId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<SuggestProvider>(
          builder: (context, sprovider, child) =>
              sprovider.scores == null || sprovider.suggest == null
                  ? const ShowProgress()
                  : Stack(
                      children: [
                        Positioned.fill(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: MyVariable.largeDevice
                                  ? const EdgeInsets.symmetric(horizontal: 40)
                                  : const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  buildImage(),
                                  SizedBox(height: 3.h),
                                  buildAge(sprovider.suggest!.suggestAge),
                                  SizedBox(height: 2.h),
                                  buildJob(sprovider.suggest!.suggestJob),
                                  SizedBox(height: 6.h),
                                  buildQuestion(
                                      sprovider.assessments[0]!.assessName),
                                  SizedBox(height: 1.h),
                                  buildScore(sprovider.scores[0]),
                                  SizedBox(height: 3.h),
                                  buildQuestion(
                                      sprovider.assessments[1]!.assessName),
                                  SizedBox(height: 1.h),
                                  buildScore(sprovider.scores[1]),
                                  SizedBox(height: 3.h),
                                  buildQuestion(
                                      sprovider.assessments[2]!.assessName),
                                  SizedBox(height: 1.h),
                                  buildScore(sprovider.scores[2]),
                                  SizedBox(height: 3.h),
                                  buildQuestion(
                                      sprovider.assessments[3]!.assessName),
                                  SizedBox(height: 1.h),
                                  buildScore(sprovider.scores[3]),
                                  SizedBox(height: 3.h),
                                  buildQuestion(
                                      sprovider.assessments[4]!.assessName),
                                  SizedBox(height: 1.h),
                                  buildScore(sprovider.scores[4]),
                                  SizedBox(height: 3.h),
                                  buildDetail(sprovider.suggest!.suggestDetail),
                                  SizedBox(height: 2.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                        MyWidget().backgroundTitle(),
                        MyWidget().title('รายละเอียดคะแนน'),
                        MyWidget().backPage(context),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          MyImage.person,
          width: MyVariable.largeDevice ? 150 : 100,
          height: MyVariable.largeDevice ? 150 : 100,
        ),
      ],
    );
  }

  Widget buildAge(String age) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'อายุ : ',
          style: MyStyle().boldBlack18(),
        ),
        Text(
          age,
          style: MyStyle().normalPrimary18(),
        ),
      ],
    );
  }

  Widget buildJob(String job) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'อาชีพ : ',
          style: MyStyle().boldBlack18(),
        ),
        SizedBox(
          width: 60.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                job,
                style: MyStyle().normalPrimary18(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildQuestion(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: MyStyle().boldBlue18(),
        ),
      ],
    );
  }

  Widget buildScore(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$title คะแนน',
          style: MyStyle().boldPrimary18(),
        ),
      ],
    );
  }

  Widget buildDetail(String title) {
    String text = title == 'null' ? 'ไม่มี' : title;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'ข้อเสนอแนะ : $text',
            style: MyStyle().normalBlack16(),
          ),
        ),
      ],
    );
  }
}
