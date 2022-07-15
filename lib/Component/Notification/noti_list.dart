import 'package:charoz/Component/Notification/Dialog/noti_detail.dart';
import 'package:charoz/Component/Order/List/order_list_customer.dart';
import 'package:charoz/Component/Order/List/order_list_manager.dart';
import 'package:charoz/Component/Order/List/order_list_rider.dart';
import 'package:charoz/Model/noti_model.dart';
import 'package:charoz/Provider/noti_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Widget/show_progress.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotiList extends StatefulWidget {
  final List notiList;
  const NotiList({Key? key, required this.notiList}) : super(key: key);

  @override
  State<NotiList> createState() => _NotiListState();
}

class _NotiListState extends State<NotiList> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    Provider.of<NotiProvider>(context, listen: false)
        .getAllNotiWhereType(widget.notiList[GlobalVariable.indexNotiChip]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Stack(
          children: [
            Positioned.fill(
              top: 8.h,
              child: RefreshIndicator(
                onRefresh: getData,
                child: Column(
                  children: [
                    buildChip(),
                    if (GlobalVariable.indexNotiChip == 0) ...[
                      if (GlobalVariable.role == 'customer') ...[
                        const OrderListCustomer(),
                      ] else if (GlobalVariable.role == 'manager') ...[
                        const OrderListManager(),
                      ] else if (GlobalVariable.role == 'rider') ...[
                        const OrderListRider(),
                      ] else ...[
                        buildNotiList(),
                      ],
                    ] else ...[
                      buildNotiList(),
                    ],
                  ],
                ),
              ),
            ),
            ScreenWidget().appBarTitle('การแจ้งเตือน'),
            if (GlobalVariable.role == 'admin' ||
                GlobalVariable.role == 'manager') ...[
              ScreenWidget().createNoti(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildChip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < widget.notiList.length; i++) ...[
            chip(widget.notiList[i], i),
          ],
        ],
      ),
    );
  }

  Widget chip(String title, int index) {
    return ActionChip(
      backgroundColor: GlobalVariable.indexNotiChip == index
          ? MyStyle.primary
          : Colors.grey.shade300,
      label: Text(
        title,
        style: GlobalVariable.indexNotiChip == index
            ? MyStyle().normalWhite16()
            : MyStyle().normalBlack16(),
      ),
      onPressed: () {
        setState(() => GlobalVariable.indexNotiChip = index);
        getData();
      },
    );
  }

  Widget buildNotiList() {
    return SizedBox(
      width: 100.w,
      height: 70.h,
      child: Consumer<NotiProvider>(
        builder: (_, provider, __) => provider.notiList == null
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ยังไม่มี ${widget.notiList[GlobalVariable.indexNotiChip]} ในขณะนี้',
                      style: MyStyle().normalPrimary18(),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'กรุณารอรายการ ${widget.notiList[GlobalVariable.indexNotiChip]} ได้ในภายหลัง',
                      style: MyStyle().normalPrimary18(),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 0),
                itemCount: provider.notiList.length,
                itemBuilder: (context, index) {
                  return buildNotiItem(provider.notiList[index], index);
                },
              ),
      ),
    );
  }

  Widget buildNotiItem(NotiModel noti, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      elevation: 5.0,
      child: InkWell(
        onTap: () => NotiDetail().dialogNoti(context, noti),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.campaign_rounded, size: 30.sp, color: MyStyle.primary),
              Text(noti.notiName, style: MyStyle().normalBlack16()),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: MyStyle.primary, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }

  Color checkOrderStatusColor(String type, String status) {
    if (type == GlobalVariable.orderReceiveTypeList[0]) {
      if (status == GlobalVariable.orderStatusReceiveList[0]) {
        return Colors.yellow.shade100;
      } else if (status == GlobalVariable.orderStatusReceiveList[1]) {
        return Colors.purple.shade100;
      } else if (status == GlobalVariable.orderStatusReceiveList[2]) {
        return Colors.green.shade100;
      } else if (status == GlobalVariable.orderStatusReceiveList[4]) {
        return Colors.red.shade100;
      } else {
        return Colors.white;
      }
    } else if (type == GlobalVariable.orderReceiveTypeList[1]) {
      if (status == GlobalVariable.orderStatusDeliveryList[0] ||
          status == GlobalVariable.orderStatusDeliveryList[1]) {
        return Colors.yellow.shade100;
      } else if (status == GlobalVariable.orderStatusDeliveryList[2]) {
        return Colors.purple.shade100;
      } else if (status == GlobalVariable.orderStatusDeliveryList[3]) {
        return Colors.green.shade100;
      } else if (status == GlobalVariable.orderStatusDeliveryList[5] ||
          status == GlobalVariable.orderStatusDeliveryList[6]) {
        return Colors.red.shade100;
      } else {
        return Colors.white;
      }
    } else {
      return Colors.white;
    }
  }
}
