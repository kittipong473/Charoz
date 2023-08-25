import 'package:charoz/Utility/Constant/my_image.dart';
import 'package:flutter/material.dart';

class VariableData {
  static String mainTitle = 'Charoz Steak House';
  static List<String> datatypeAddress = [
    'คอนโดถนอมมิตร',
    'บ้านพัก',
    'ที่ทำงาน',
    'อื่นๆ'
  ];
  static List<String> datatypeBanner = ['profile', 'carousel', 'icon', 'video'];
  static List<String> datatypeNotiRole = [
    'guest',
    'customer',
    'rider',
    'manager'
  ];
  static List<String> datatypeNotiType = ['ข่าวสาร', 'โปรโมชั่น'];
  static List<String> datatypeOrderStatus = [
    'รอการยืนยันจากร้านค้า',
    'รอการยืนยันจากคนขับ',
    'กำลังจัดทำอาหาร',
    'ทำอาหารเสร็จสิ้น',
    'คนขับกำลังจัดส่ง',
    'ชำระเงินเรียบร้อย',
    'ถูกยกเลิกจากร้านค้า',
    'ไม่มีคนขับสะดวกรับงาน',
    'ให้คะแนนเรียบร้อย'
  ];
  static List<String> datatypeOrderTrack = [
    'sending',
    'accepted',
    'finished',
    'canceled',
  ];
  static List<String> datatypeProduct = [
    'อาหาร',
    'ทานเล่น',
    'เครื่องดื่ม',
    'ของหวาน'
  ];
  static List<String> datatypeTimeOpen = [
    'เปิดตามปกติ',
    'ปิดชั่วคราว',
    'ปิดกรณีพิเศษ'
  ];
  static List<String> datatypeUserRole = [
    'guest',
    'customer',
    'rider',
    'manager',
    'admin'
  ];

  static List<String> notiRoleTargetList = ['ทั้งหมด', 'คนขับ', 'ลูกค้า'];
  // Type of Order
  static List<String> orderTypeList = ['กำลังดำเนินการ', 'เสร็จสิ้น/ยกเลิก'];
  // List of Time Status

  // List of number of Tanommit building
  static List<String> buildingNumbers = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16'
  ];
  // List of Order Receive Type
  static List<String> orderReceiveList = [
    'มารับที่ร้านค้า',
    'จัดส่งตามที่อยู่',
  ];

  static List<Color> orderTrackingColor = [
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.red.shade100,
    Colors.grey.shade300,
  ];
}
