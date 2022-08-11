import 'package:charoz/Component/Address/Modal/add_location.dart';
import 'package:charoz/Component/Address/Modal/edit_location.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Model_Main/address_model.dart';
import 'package:charoz/Service/Database/Firebase/address_crud.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LocationList extends StatefulWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    await Provider.of<AddressProvider>(context, listen: false)
        .readAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        appBar: ScreenWidget().appBarTheme('ที่อยู่ทั้งหมดของฉัน'),
        body: Consumer<AddressProvider>(
          builder: (_, provider, __) => Stack(
            children: [
              if (provider.addressList == null) ...[
                ScreenWidget().showEmptyData(
                    'ยังไม่มีข้อมูลที่อยู่', 'กรุณาเพิ่มข้อมูลที่อยู่')
              ] else ...[
                Positioned.fill(
                  top: 2.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100.w,
                          height: 80.h,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 0),
                            shrinkWrap: true,
                            itemCount: provider.addressList.length,
                            itemBuilder: (context, index) => Slidable(
                              startActionPane: buildLeftSlidable(
                                  provider.addressList[index], index),
                              endActionPane: buildRightSlidable(
                                  provider.addressList[index], index),
                              child: buildAddressItem(
                                  provider.addressList[index], index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: MyStyle.bluePrimary,
            child: Icon(Icons.add_rounded, size: 20.sp, color: Colors.white),
            onPressed: () => AddLocation().openModalAddAddress(context)),
      ),
    );
  }

  Widget buildAddressItem(AddressModel address, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.pin_drop_rounded,
              color: MyStyle.bluePrimary,
              size: 25.sp,
            ),
            Column(
              children: [
                Text(address.name, style: MyStyle().normalBlue16()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        address.name == 'คอนโดถนอมมิตร'
                            ? 'ตึกหมายเลข ${address.detail}'
                            : address.detail,
                        style: MyStyle().normalBlack14()),
                  ],
                ),
              ],
            ),
            Icon(Icons.compare_arrows_rounded,
                size: 20.sp, color: MyStyle.primary),
          ],
        ),
      ),
    );
  }

  ActionPane buildLeftSlidable(AddressModel address, int index) {
    return ActionPane(
      motion: const ScrollMotion(),
      extentRatio: 0.2,
      children: [
        InkWell(
          onTap: () => EditLocation().openModalEditAddress(context, address),
          child: Container(
            width: 10.w,
            height: 10.w,
            margin: EdgeInsets.only(left: 5.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              Icons.edit_location_alt_rounded,
              size: 20.sp,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  ActionPane buildRightSlidable(AddressModel address, int index) {
    return ActionPane(
      motion: const ScrollMotion(),
      extentRatio: 0.2,
      children: [
        InkWell(
          onTap: () async {
            bool status = await AddressCRUD().deleteAddress(address.id);
            if (status) {
              Provider.of<AddressProvider>(context, listen: false)
                  .readAddressList();
              MyFunction().toast('ลบที่อยู่เรียบร้อยแล้ว');
            } else {
              DialogAlert().deleteFailedDialog(context);
            }
          },
          child: Container(
            width: 10.w,
            height: 10.w,
            margin: EdgeInsets.only(left: 5.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              Icons.delete_forever_rounded,
              size: 20.sp,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
