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
  // Index Page of each Page Navigation
  static int indexPageNavigation = 0;
  // Index Page of Product Type
  static int indexProductChip = 0;
  // Index Page of Customer Notification
  static int indexNotiChip = 0;
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
  // Type of User Notification
  static List<String> notisUser = ['โปรโมชั่น', 'ข่าวสาร'];
  // Type of Customer Notification
  static List<String> notisCustomer = [
    'ออเดอร์',
    'โปรโมชั่น',
    'ข่าวสาร',
    'ติดต่อ'
  ];
  // Type of Rider Notification
  static List<String> notisRider = ['ออเดอร์', 'ข่าวสาร', 'ติดต่อ'];
  // Type of Manager Notification
  static List<String> notisManager = ['ออเดอร์', 'โปรโมชั่น', 'ข่าวสาร'];
  // Type of Admin Notification
  static List<String> notisAdmin = ['ติดต่อ', 'โปรโมชั่น', 'ข่าวสาร'];
  // List of Time Status
  static List<String> timeTypes = [
    'เปิดตามเวลาปกติ',
    'ปิดชั่วคราว',
    'ปิดช่วงเทศกาล'
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
  static List<String> orderReceiveTypeList = [
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
    Colors.grey.shade100,
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
