import 'package:firebase_auth/firebase_auth.dart';

class MyVariable {
  // Dynamic Variable

  // User Id
  static int userTokenId = 0;
  // Status Auto Login
  static String accountUid = "";
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

  // Constant Variable

  // Create FirebaseAuth Variable
  static FirebaseAuth auth = FirebaseAuth.instance;
  // title of this application
  static String mainTitle = 'charoz';
  // Type of Product
  static List<String> productTypes = [
    'อาหาร',
    'ออร์เดิฟ',
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
  // List of type of address
  static List<String> locationTypes = [
    '--เลือกสถานที่--',
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
}
