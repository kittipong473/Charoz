import 'package:firebase_auth/firebase_auth.dart';

class MyVariable {
  // Constant Variable

  // Width and Height between iPad and iPhone
  static bool largeDevice = false;
  // Index Page of each Service
  static int indexPage = 0;
  // Index Page of Product Type
  static int menuIndex = 0;
  static String menuType = 'อาหาร';
  // Index Page of Customer Notification
  static int notiCustomerIndex = 0;
  // Login Status
  static bool login = false;
  // Role of user
  static String role = '';
  // Create FirebaseAuth Variable
  static FirebaseAuth auth = FirebaseAuth.instance;

  // Dynamic Variable

  // title of this application
  static String mainTitle = 'charoz';
  // Status Auto Login
  static String accountUid = "";
  // Type of Product
  static List<String> producttypes = [
    'อาหาร',
    'ออร์เดิฟ',
    'เครื่องดื่ม',
    'ของหวาน',
  ];
  // Question & Answer
  static List<String> aboutQues = [
    'แอพพลิเคชั่นของร้านนี้ มีไว้ทำอะไร ?',
    'เหตุผลในการตอบแบบประเมิน',
    'มีแนวทางการพัฒนา แอพพลิเคชั่น ในอนาคตอย่างไรบ้าง ?',
  ];
  static List<String> aboutAns = [
    'เป็น แอพพลิเคชั่น ของร้านอาหาร Charoz Steak House มีไว้สำหรับผู้ใช้งาน 3 ประเภท คือ ลูกค้า ผู้ขาย และผู้ดูแลระบบ โดยลูกค้าจะสามารถตรวจสอบข้อมูลของร้านอาหารต่างๆได้ ไม่ว่าจะเป็น ตำแหน่งร้านอาหาร ดูเมนูอาหาร,เครื่องดื่ม,ของหวาน การประกาศและการนำเสนอจากร้านค้า และเวลาเปิดปิดของร้านที่แสดงไว้ชัดเจน โดยลูกค้าสามารถตรวจสอบรายการอาหารต่างๆได้ทุกเวลา ซึ่งปัจจุบันสามารถใช้งานได้เฉพาะระบบปฏิบัติการ Android เท่านั้น',
    'เพื่อที่ทางร้านค้าจะได้วิเคราะห์ ข้อเสนอแนะจากลูกค้า และนำไปปรับปรุงร้านค้าให้ดีขึ้นในด้านต่างๆ เพื่อให้ลูกค้าได้รับความพึงพอใจในการบริการตรงตามที่ลูกค้าต้องการมากที่สุด',
    'ในอนาคตจะมีการอัพเดทส่วนเสริมของ แอพพลิเคชั่น เพิ่มขึ้นมาเรื่อยๆ ตัวอย่างเช่น\n  - มีระบบ สมัครสมาชิกเข้าใช้งาน เพื่อที่สามารถสั่งอาหารทางร้านอาหารได้\n  - มีระบบคูปองเพื่อใช้ลดราคาอาหารกับทางร้านอาหาร\n  - มีระบบแจ้งเตือน notification ไว้สำหรับแจ้งข่าวสารและโปรโมชั่น รวมถึงระบบพูดคุยกับทางร้านค้า\n  - มีระบบการให้คะแนนกับร้านค้า และการเผยแพร่ในระบบปฏิบัติการ ios เช่น iphone/ipad ด้วยเช่นกัน',
  ];
  // List of job select
  static String chooseJob = '--เลือกอาชีพ--';
  static List<String> jobs = [
    '--เลือกอาชีพ--',
    'นักเรียน/นักศึกษา',
    'พนักงานบริษัท',
    'พ่อค้า/แม่ค้า',
    'ฟรีแลนซ์/อาชีพอิสระ',
    'ยังไม่ทำงาน',
    'อื่นๆ',
  ];
}