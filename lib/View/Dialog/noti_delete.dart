import 'package:charoz/Service/Firebase/noti_crud.dart';
import 'package:charoz/Utility/Constant/my_image.dart';
import 'package:charoz/Utility/Constant/my_style.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/Utility/Variable/var_data.dart';
import 'package:charoz/Utility/Variable/var_general.dart';
import 'package:charoz/View_Model/noti_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotiDelete {
  final BuildContext context;
  final String id;
  NotiDelete(this.context, this.id);

  final NotiViewModel notiVM = Get.find<NotiViewModel>();

  void confirmDelete() {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(MyImage.svgWarning, width: 15.w, height: 15.w),
            SizedBox(height: 2.h),
            Text(
              "คุณต้องการลบ รายการนี้หรือไม่ ?",
              style: MyStyle().normalBlue16(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 25.w,
                height: 4.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade100),
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('ยกเลิก', style: MyStyle().boldRed16()),
                ),
              ),
              SizedBox(
                width: 25.w,
                height: 4.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade100),
                  onPressed: () async {
                    bool status = await NotiCRUD().deleteNoti(id: id);
                    if (status) {
                      notiVM.readNotiList();
                      MyFunction().toast('ลบรายการเรียบร้อยแล้ว');
                    } else {
                      MyDialog(context).deleteFailedDialog();
                    }
                    Navigator.pop(dialogContext);
                  },
                  child: Text('ยืนยัน', style: MyStyle().boldGreen16()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
