// import 'package:charoz/Service/Firebase/order_crud.dart';
// import 'package:charoz/Model/Utility/Constant/my_style.dart';
// import 'package:charoz/View/Function/dialog_alert.dart';
// import 'package:charoz/View/Function/my_function.dart';
// import 'package:charoz/Model/Utility/Variable/my_variable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class RiderProcess {
//   final BuildContext context;
//   final String id;
//   RiderProcess(this.context, this.id);

//   void acceptConfirmYes() {
//     showDialog(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Icon(
//               Icons.receipt_rounded,
//               size: 25.sp,
//               color: MyStyle.orangePrimary,
//             ),
//             SizedBox(
//               width: 45.w,
//               child: Text(
//                 'ยืนยันการยอมรับออเดอร์นี้หรือไม่ ?',
//                 style: MyStyle().boldPrimary18(),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(dialogContext);
//                   EasyLoading.show(status: 'loading...');
//                   checkDuplicateAcceptOrder();
//                 },
//                 child: Text('ยอมรับ', style: MyStyle().boldGreen18()),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('ยกเลิก', style: MyStyle().boldGrey18()),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Future checkDuplicateAcceptOrder() async {
//     bool? status = await OrderCRUD().checkRiderIdById(id: id);
//     if (status != null && status) {
//       processAcceptOrder();
//     } else {
//       MyDialog(context).doubleDialog(
//           'ออเดอร์นี้มีคนอื่นรับไปแล้ว', 'โปรดรอออเดอร์อื่นๆในภายหลัง');
//     }
//   }

//   Future processAcceptOrder() async {
//     bool api1 =
//         await OrderCRUD().updateOrderStatus(id: id, status: 2, track: 1);
//     bool api2 = await OrderCRUD().updateOrderRiderId(id: id);
//     if (api1 && api2) {
//       EasyLoading.dismiss();
//       Navigator.pop(context);
//       MyVariable.tabController!.animateTo(1);
//       MyFunction().toast('ยอมรับออเดอร์ เรียบร้อย');
//     } else {
//       EasyLoading.dismiss();
//       MyDialog(context).doubleDialog(
//           'มีปัญหาเกิดขึ้นที่ระบบ', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
//     }
//   }

//   Future processReceiveOrder() async {
//     bool api = await OrderCRUD().updateOrderStatus(id: id, status: 4, track: 1);
//     if (api) {
//       EasyLoading.dismiss();
//       Navigator.pop(context);
//       MyFunction().toast('อัพเดทสถานะ เรียบร้อย');
//     } else {
//       EasyLoading.dismiss();
//       MyDialog(context).doubleDialog(
//           'มีปัญหาเกิดขึ้นที่ระบบ', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
//     }
//   }

//   Future processSendOrder() async {
//     bool api = await OrderCRUD().updateOrderStatus(id: id, status: 5, track: 3);
//     if (api) {
//       EasyLoading.dismiss();
//       Navigator.pop(context);
//       MyFunction().toast('อัพเดทสถานะ เรียบร้อย');
//     } else {
//       EasyLoading.dismiss();
//       MyDialog(context).doubleDialog(
//           'มีปัญหาเกิดขึ้นที่ระบบ', 'กรุณาลองใหม่อีกครั้งในภายหลัง');
//     }
//   }
// }
