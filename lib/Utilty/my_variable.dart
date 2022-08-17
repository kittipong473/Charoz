import 'package:charoz/Utilty/Constant/my_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyVariable {
  // User Id
  static String userTokenId = '';
  // Status Auto Login
  static String accountUid = '';
  // Width and Height between iPad and iPhone
  static bool largeDevice = false;
  // Index Page of Product Type
  static int indexProductChip = 0;
  // Index Page of Notification Type
  static int indexNotiChip = 0;
  // Index Page of Order Type
  static int indexOrderChip = 0;
  // Login Status
  static bool login = false;
  // Role of user
  static String role = '';

  // List of Carousel Shop Detail Image
  static List<String> carouselShopImage = [
    MyImage.showshop2,
    MyImage.showshop3,
    MyImage.showshop4
  ];
  // Create FirebaseAuth Variable
  static FirebaseAuth auth = FirebaseAuth.instance;
  // title of this application
  static String mainTitle = 'Charoz Steak House';
  // Type of Product
  static List<String> productTypes = [
    'อาหาร',
    'ทานเล่น',
    'เครื่องดื่ม',
    'ของหวาน'
  ];
  // Type of Notification
  static List<String> notiTypeList = ['โปรโมชั่น', 'ข่าวสาร'];
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
    'บ้านพัก',
    'ที่ทำงาน',
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
  // Tab Control of Page Navigation
  static late TabController? tabController;
}
