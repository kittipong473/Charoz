import 'package:charoz/Provider/config_provider.dart';
import 'package:charoz/Service/Database/Firebase/config_crud.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Provider.of<ConfigProvider>(context, listen: false).getAllTest();
    ConfigCRUD().readStatusFromAS();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        appBar: ScreenWidget().appBarTheme('firebase test'),
        body: SingleChildScrollView(
          child: Consumer<ConfigProvider>(
            builder: (_, provider, __) => provider.testList == null
                ? const ShowProgress()
                : Column(
                    children: [
                      Container(),
                      // for (var item in provider.testList) ...[
                      //   ListTile(
                      //     leading: CachedNetworkImage(
                      //       width: 50,
                      //       height: 50,
                      //       fit: BoxFit.cover,
                      //       imageUrl: item.url,
                      //       placeholder: (context, url) => const ShowProgress(),
                      //       errorWidget: (context, url, error) =>
                      //           Image.asset(MyImage.error),
                      //     ),
                      //     title: Text(item.name),
                      //     subtitle: Text(item.time),
                      //     onTap: () => print(item.id),
                      //   ),
                      // FutureBuilder(
                      //     future: BannerCRUD().readData(),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.hasError) {
                      //         return const Text('something wrong');
                      //       } else if (snapshot.hasData) {
                      //         final testList = snapshot.data! as List<TestModel>;
                      //         return ListView.builder(
                      //             shrinkWrap: true,
                      //             itemCount: testList.length,
                      //             itemBuilder: (context, index) {
                      //               return ListTile(
                      //                 leading: Text(testList[index].number.toString()),
                      //                 title: Text(testList[index].name),
                      //                 // subtitle: Text(tests.doc),
                      //               );
                      //             });
                      //       } else {
                      //         return const ShowProgress();
                      //       }
                      //     }),
                      // SizedBox(height: 50),
                      // StreamBuilder<List<TestModel>>(
                      //     stream: BannerCRUD().readRealData(),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.hasError) {
                      //         return Text('something wrong');
                      //       } else if (snapshot.hasData) {
                      //         List<TestModel> testList = snapshot.data!;
                      //         return ListView.builder(
                      //             shrinkWrap: true,
                      //             itemCount: testList.length,
                      //             itemBuilder: (context, index) {
                      //               return ListTile(
                      //                 leading: Text(testList[index].number.toString()),
                      //                 title: Text(testList[index].name),
                      //                 subtitle: Text(testList[index].url),
                      //               );
                      //             });
                      //       } else {
                      //         return const ShowProgress();
                      //       }
                      //     }),
                      // SizedBox(height: 50),
                      // FutureBuilder<TestModel?>(
                      //     future: BannerCRUD().readOnlyData(),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.hasError) {
                      //         return Text('something wrong');
                      //       } else if (snapshot.hasData) {
                      //         TestModel test = snapshot.data!;
                      //         return Column(
                      //           children: [
                      //             Text(test.name),
                      //             Text(test.number.toString()),
                      //             Text(test.url),
                      //           ],
                      //         );
                      //       } else {
                      //         return const ShowProgress();
                      //       }
                      //     }),
                      // TextFormField(
                      //   controller: nameController,
                      //   decoration: InputDecoration(
                      //     hintText: 'name',
                      //   ),
                      // ),
                      // TextFormField(
                      //   controller: numberController,
                      //   decoration: InputDecoration(
                      //     hintText: 'number',
                      //   ),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     BannerCRUD().addData(
                      //       TestModel(
                      //           name: nameController.text,
                      //           url: 'path',
                      //           number: int.parse(numberController.text),
                      //           created: '02-08-2022'),
                      //     );
                      //   },
                      //   child: Text('Insert'),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     print(BannerCRUD().editData(nameController.text));
                      //   },
                      //   child: Text('edit'),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     print(BannerCRUD().deleteData());
                      //   },
                      //   child: Text('delete'),
                      // ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
