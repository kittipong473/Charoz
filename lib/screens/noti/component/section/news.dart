import 'package:animations/animations.dart';
import 'package:charoz/screens/noti/model/noti_model.dart';
import 'package:charoz/screens/noti/provider/noti_provider.dart';
import 'package:charoz/services/api/noti_api.dart';
import 'package:charoz/utils/constant/my_image.dart';
import 'package:charoz/utils/constant/my_style.dart';
import 'package:charoz/utils/constant/my_variable.dart';
import 'package:charoz/utils/constant/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class News extends StatefulWidget {
  final List<NotiModel> notiNews;
  const News({Key? key, required this.notiNews}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<NotiModel> notiModels = [];

  @override
  void initState() {
    super.initState();
    notiModels = widget.notiNews;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: notiModels.isNotEmpty
            ? ListView.builder(
                itemCount: notiModels.length,
                itemBuilder: (context, index) =>
                    buildPromotionItem(notiModels[index], index),
              )
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ไม่มีข่าวสารในขณะนี้',
                      style: MyStyle().boldPrimary20(),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'กรุณารอข่าวสารได้ในภายหลัง',
                      style: MyStyle().boldPrimary20(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildPromotionItem(NotiModel noti, int index) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5.0,
      child: InkWell(
        onTap: () => dialogPromoDetail(context, noti),
        child: Padding(
          padding: MyVariable.largeDevice
              ? const EdgeInsets.all(20)
              : const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.campaign_rounded,
                size: 30.sp,
                color: MyStyle.primary,
              ),
              Text(
                noti.notiName,
                style: MyStyle().boldBlack16(),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: MyStyle.primary,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogPromoDetail(BuildContext context, NotiModel noti) {
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                noti.notiName,
                style: MyStyle().boldPrimary20(),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 50.w,
                height: 50.w,
                child: Image.asset(MyImage.welcome),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 60.w,
                child: Text(
                  noti.notiDetail,
                  style: MyStyle().normalBlack16(),
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'เริ่มต้น : ${noti.notiStart}',
                style: MyStyle().boldBlue16(),
              ),
              SizedBox(height: 1.h),
              Text(
                'สิ้นสุด : ${noti.notiEnd}',
                style: MyStyle().boldBlue16(),
              ),
              SizedBox(height: 1.h),
            ],
          ),
          children: [
            if (MyVariable.role == 'admin') ...[
              TextButton(
                onPressed: () async {
                  bool result =
                      await NotiApi().deleteNotiWhereId(id: noti.notiId);
                  if (result) {
                    MyWidget().toast('ลบรายการแจ้งเตือนสำเร็จ');
                    Provider.of<NotiProvider>(context, listen: false)
                        .getAllNoti();
                  } else {
                    MyWidget()
                        .toast('ลบรายการแจ้งเตือนล้มเหลว ลองใหม่อีกครั้ง');
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'ลบรายการ',
                  style: MyStyle().boldPrimary18(),
                ),
              ),
            ] else ...[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'ตกลง',
                  style: MyStyle().boldBlue18(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
