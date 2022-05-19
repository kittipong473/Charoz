import 'package:charoz/Screen/Suggestion/Provider/suggest_provider.dart';
import 'package:charoz/Service/Api/suggest_api.dart';
import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Utilty/Constant/my_dialog.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:charoz/Utilty/Constant/my_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SuggestAnswer extends StatefulWidget {
  final String age;
  final String job;
  const SuggestAnswer({
    Key? key,
    required this.age,
    required this.job,
  }) : super(key: key);

  @override
  _SuggestAnswerState createState() => _SuggestAnswerState();
}

class _SuggestAnswerState extends State<SuggestAnswer> {
  List<int> scores = [0, 0, 0, 0, 0];
  TextEditingController detailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    Provider.of<SuggestProvider>(context, listen: false).getAssessment();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<SuggestProvider>(
          builder: (context, sprovider, child) => sprovider.assessments.isEmpty
              ? const ShowProgress()
              : GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  behavior: HitTestBehavior.opaque,
                  child: Stack(
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
                                buildQuestion(
                                    sprovider.assessments[0]!.assessName),
                                buildScore(context, 0),
                                SizedBox(height: 3.h),
                                buildQuestion(
                                    sprovider.assessments[1]!.assessName),
                                buildScore(context, 1),
                                SizedBox(height: 3.h),
                                buildQuestion(
                                    sprovider.assessments[2]!.assessName),
                                buildScore(context, 2),
                                SizedBox(height: 3.h),
                                buildQuestion(
                                    sprovider.assessments[3]!.assessName),
                                buildScore(context, 3),
                                SizedBox(height: 3.h),
                                buildQuestion(
                                    sprovider.assessments[4]!.assessName),
                                buildScore(context, 4),
                                SizedBox(height: 3.h),
                                buildDetail(),
                                SizedBox(height: 5.h),
                                buildButton(context),
                                SizedBox(height: 2.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                      MyWidget().backgroundTitle(),
                      MyWidget().title('แบบประเมินความพึงพอใจ'),
                      MyWidget().backPage(context),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Row buildQuestion(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: MyStyle().boldBlue16(),
        ),
      ],
    );
  }

  Row buildScore(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Radio(
                activeColor: MyStyle.primary,
                value: 5,
                groupValue: scores[index],
                onChanged: (value) {
                  setState(() {
                    scores[index] = value as int;
                  });
                }),
            Text(
              '5',
              style: MyStyle().boldPrimary16(),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
                activeColor: MyStyle.primary,
                value: 4,
                groupValue: scores[index],
                onChanged: (value) {
                  setState(() {
                    scores[index] = value as int;
                  });
                }),
            Text(
              '4',
              style: MyStyle().boldPrimary16(),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
                activeColor: MyStyle.primary,
                value: 3,
                groupValue: scores[index],
                onChanged: (value) {
                  setState(() {
                    scores[index] = value as int;
                  });
                }),
            Text(
              '3',
              style: MyStyle().boldPrimary16(),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
                activeColor: MyStyle.primary,
                value: 2,
                groupValue: scores[index],
                onChanged: (value) {
                  setState(() {
                    scores[index] = value as int;
                  });
                }),
            Text(
              '2',
              style: MyStyle().boldPrimary16(),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
                activeColor: MyStyle.primary,
                value: 1,
                groupValue: scores[index],
                onChanged: (value) {
                  setState(() {
                    scores[index] = value as int;
                  });
                }),
            Text(
              '1',
              style: MyStyle().boldPrimary16(),
            ),
          ],
        ),
      ],
    );
  }

  Row buildDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 85.w,
          child: TextFormField(
            style: MyStyle().normalBlack16(),
            maxLines: 3,
            controller: detailController,
            decoration: InputDecoration(
              labelStyle: MyStyle().boldBlack16(),
              labelText: 'ข้อเสนอแนะ (ถ้ามี) :',
              prefixIcon: const Icon(
                Icons.border_color_rounded,
                color: MyStyle.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyStyle.dark),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyStyle.light),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80.w,
          height: 5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyStyle.blue),
            onPressed: () {
              bool ans = true;
              for (var i = 0; i < scores.length; i++) {
                if (scores[i] == 0) {
                  ans = false;
                }
              }
              if (ans) {
                processAssessment();
              } else {
                MyDialog().singleDialog(context, 'กรุณาระบุคะแนนให้ครบทุกข้อ');
              }
            },
            child: Text(
              'ส่งแบบประเมิน',
              style: MyStyle().boldWhite16(),
            ),
          ),
        ),
      ],
    );
  }

  Future processAssessment() async {
    String age = widget.age;
    String job = widget.job;
    String score = scores.toString();
    int sum = 0;
    for (var i = 0; i < scores.length; i++) {
      sum = sum + scores[i];
    }
    String total = sum.toString();
    String detail =
        detailController.text.isEmpty ? 'null' : detailController.text;
    String time = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

    bool status = await SuggestApi().insertSuggest(
      age: age,
      job: job,
      score: score,
      total: total,
      detail: detail,
      time: time,
    );
    if (status) {
      Navigator.pushNamed(context, RoutePage.routeSuggestComplete);
    } else {
      MyDialog().doubleDialog(
          context, 'เพิ่มข้อมูลล้มเหลว', 'กรูณาลองใหม่อีกครั้งในภายหลัง');
    }
  }
}
