import 'package:charoz/screens/home/component/section/assessment.dart';
import 'package:charoz/utils/constant/my_dialog.dart';
import 'package:charoz/utils/constant/my_image.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({Key? key}) : super(key: key);

  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  final formKey = GlobalKey<FormState>();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: GestureDetector(
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          buildImage(),
                          SizedBox(height: 5.h),
                          buildAnnounce(),
                          SizedBox(height: 3.h),
                          MyWidget().buildTitle(title: 'รายละเอียดผู้ประเมิน'),
                          SizedBox(height: 2.h),
                          buildAge(),
                          SizedBox(height: 2.h),
                          buildType(),
                          SizedBox(height: 5.h),
                          buildButton(context),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              MyWidget().backgroundTitle(),
              MyWidget().title('คำแนะนำจากลูกค้า'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Image.asset(
      MyImage.logo3,
      width: 40.w,
      height: 40.w,
    );
  }

  Widget buildAnnounce() {
    return SizedBox(
      width: 80.w,
      child: Text(
        'รบกวนลูกค้าถูกท่าน ช่วยกรอกความคิดเห็นหรือข้อเสนอแนะเพิ่มเติมเกี่ยวกับร้านค้านี้ เราจะนำคำติชมเหล่านี้ไปปรับปรุงและพัฒนาให้ร้านอาหารมีประสิทธิภาพดียิ่งขึ้น',
        style: MyStyle().boldGreen16(),
      ),
    );
  }

  Widget buildAge() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'อายุ : ',
          style: MyStyle().boldBlack16(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: 45.w,
          child: TextFormField(
            style: MyStyle().normalBlack16(),
            keyboardType: TextInputType.number,
            controller: ageController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก อายุของคุณ';
              } else if (value.length > 2) {
                return 'กรุณากรอก เลขอายุ ให้ถูกต้อง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              errorStyle: MyStyle().normalRed14(),
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

  Widget buildType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'อาชีพ : ',
          style: MyStyle().boldBlack16(),
        ),
        Container(
          width: 45.w,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyStyle.dark),
          ),
          child: DropdownButton(
            iconSize: 36,
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: MyStyle.dark,
            ),
            isExpanded: true,
            value: MyVariable.chooseJob,
            items: MyVariable.jobs.map(buildMenuItem).toList(),
            onChanged: (value) {
              setState(() {
                MyVariable.chooseJob = value as String;
              });
            },
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: MyStyle().normalBlack16(),
      ),
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
              if (formKey.currentState!.validate() && MyVariable.chooseJob != '--เลือกอาชีพ--') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Assessment(
                      age: ageController.text,
                      job: MyVariable.chooseJob,
                    ),
                  ),
                );
              } else {
                MyDialog().singleDialog(context, 'กรุณาเลือกอาชีพของท่าน');
              }
            },
            child: Text(
              'กรอกแบบประเมิน',
              style: MyStyle().boldWhite16(),
            ),
          ),
        ),
      ],
    );
  }
}
