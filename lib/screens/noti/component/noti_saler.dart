import 'package:charoz/screens/home/provider/suggest_provider.dart';
import 'package:charoz/screens/noti/component/suggest_detail.dart';
import 'package:charoz/screens/home/model/suggestion_model.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:charoz/utils/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotiSaler extends StatefulWidget {
  const NotiSaler({Key? key}) : super(key: key);

  @override
  _NotiSalerState createState() => _NotiSalerState();
}

class _NotiSalerState extends State<NotiSaler> {
  @override
  void initState() {
    super.initState();
    Provider.of<SuggestProvider>(context, listen: false).getAllSuggest();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<SuggestProvider>(
          builder: (context, sprovider, child) => sprovider.suggests.isEmpty
              ? const ShowProgress()
              : Stack(
                  children: [
                    Positioned.fill(
                      top: 6.h,
                      child: SingleChildScrollView(
                        child: Container(
                          width: 100.w,
                          height: 86.h,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(color: Colors.black),
                            // itemCount: 50,
                            itemCount: sprovider.suggestsLength,
                            itemBuilder: (context, index) => buildSuggestItem(
                                sprovider.suggests[index], index),
                            // buildTesttItem(index),
                          ),
                        ),
                      ),
                    ),
                    MyWidget().backgroundTitle(),
                    MyWidget().title('ตารางคะแนนของลูกค้า'),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildSuggestItem(SuggestionModel suggest, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuggestDetail(id: suggest.suggestId),
          ),
        );
      },
      child: Padding(
        padding: MyVariable.largeDevice
            ? const EdgeInsets.all(10)
            : const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 35.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'อายุ : ${suggest.suggestAge}',
                    style: MyStyle().boldBlue16(),
                  ),
                  Text(
                    'อาชีพ : ${suggest.suggestJob}',
                    style: MyStyle().boldBlue16(),
                  ),
                ],
              ),
            ),
            Text(
              '${suggest.suggestTotal}/25 คะแนน',
              style: MyStyle().boldPrimary16(),
            ),
            Column(
              children: [
                Text(
                  'กรอก ณ วันที่',
                  style: MyStyle().normalBlack14(),
                ),
                Text(
                  suggest.created,
                  style: MyStyle().normalBlue14(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTesttItem(int index) {
    return Padding(
      padding: MyVariable.largeDevice
          ? const EdgeInsets.all(10)
          : const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 35.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'อายุ : 123',
                  style: MyStyle().boldBlue16(),
                ),
                Text(
                  'อาชีพ : tester',
                  style: MyStyle().boldBlue16(),
                ),
              ],
            ),
          ),
          Text(
            '25/25 คะแนน',
            style: MyStyle().boldPrimary16(),
          ),
          Column(
            children: [
              Text(
                'กรอก ณ วันที่',
                style: MyStyle().normalBlack14(),
              ),
              Text(
                '28-04-2022 11:42',
                style: MyStyle().normalBlue14(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
