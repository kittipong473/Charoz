import 'package:charoz/Component/Address/Modal/add_location.dart';
import 'package:charoz/Component/Address/Modal/edit_location.dart';
import 'package:charoz/Provider/address_provider.dart';
import 'package:charoz/Model/address_model.dart';
import 'package:charoz/Service/Api/PHP/address_api.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Function/dialog_alert.dart';
import 'package:charoz/Utilty/Function/my_function.dart';
import 'package:charoz/Utilty/Widget/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LocationList extends StatelessWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: MyStyle.colorBackGround,
        body: Consumer<AddressProvider>(
          builder: (_, provider, __) => Stack(
            children: [
              if (provider.addressList == null) ...[
                ScreenWidget().showEmptyData(
                    'ยังไม่มีข้อมูลที่อยู่', 'กรุณาเพิ่มข้อมูลที่อยู่')
              ] else ...[
                Positioned.fill(
                  top: 10.h,
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
              ScreenWidget().appBarTitle('รายการที่อยู่ของคุณ'),
              ScreenWidget().backPage(context),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: MyStyle.primary,
            child: const Icon(Icons.add_rounded),
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
                Text(address.addressName, style: MyStyle().normalBlue16()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        address.addressName == 'คอนโดถนอมมิตร'
                            ? 'ตึกหมายเลข ${address.addressDetail}'
                            : address.addressDetail,
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
    return ActionPane(motion: const DrawerMotion(), children: [
      SlidableAction(
        onPressed: (context) =>
            EditLocation().openModalEditAddress(context, address),
        borderRadius: BorderRadius.circular(10),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: Icons.edit_rounded,
        label: 'Edit',
        autoClose: true,
        flex: 1,
      ),
    ]);
  }

  ActionPane buildRightSlidable(AddressModel address, int index) {
    return ActionPane(motion: const ScrollMotion(), children: [
      SlidableAction(
        onPressed: (context) async {
          bool status =
              await AddressApi().deleteAddressWhereId(id: address.addressId);
          if (status) {
            Provider.of<AddressProvider>(context, listen: false)
                .deleteAddressWhereId(address.addressId);
            MyFunction().toast('ลบที่อยู่เรียบร้อยแล้ว');
          } else {
            DialogAlert().deleteFailedDialog(context);
          }
        },
        borderRadius: BorderRadius.circular(10),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: Icons.delete_rounded,
        label: 'Delete',
        autoClose: true,
      ),
    ]);
  }
}
