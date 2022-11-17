import 'package:charoz/Util/Constant/my_image.dart';
import 'package:flutter/material.dart';

class VariableData {
  // title of this application
  static String mainTitle = 'Charoz Steak House';
  // Type of Product
  static List<String> productTypes = [
    'อาหาร',
    'ทานเล่น',
    'เครื่องดื่ม',
    'ของหวาน'
  ];
  // List of Carousel Shop Detail Image
  static List<String> carouselShopImage = [
    MyImage.showshop2,
    MyImage.showshop3,
    MyImage.showshop4
  ];
  // Type of Notification
  static List<String> notiTypeList = ['โปรโมชั่น', 'ข่าวสาร'];
  // Type of User receive Notification
  static List<String> notiReceiveUser = [
    'everyone',
    'rider',
    'customer',
  ];
  // Type of Role Target
  static List<String> notiRoleTargetList = ['ทั้งหมด', 'คนขับ', 'ลูกค้า'];
  // Type of Order
  static List<String> orderTypeList = ['กำลังดำเนินการ', 'เสร็จสิ้น/ยกเลิก'];
  // List of Time Status
  static List<String> timeTypes = [
    'เปิดตามเวลาปกติ',
    'ปิดชั่วคราว',
    'ปิดกรณีพิเศษ'
  ];
  // List of type of address
  static List<String> locationTypes = [
    'คอนโดถนอมมิตร',
    'ที่ทำงาน',
    'บ้านพัก',
    'อื่นๆ'
  ];
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
  // List of Order Tracking
  static List<String> orderTrackingList = [
    'sending',
    'accepted',
    'finished',
    'canceled',
  ];
  static List<Color> orderTrackingColor = [
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.red.shade100,
    Colors.grey.shade300,
  ];
  // List of Order Status
  static List<String> orderStatusList = [
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
}
