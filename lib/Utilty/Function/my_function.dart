import 'package:intl/intl.dart';

class MyFunction {
  String cutWord10(String name) {
    String result = name;
    if (result.length > 15) {
      result = result.substring(0, 12);
      result = '$result...';
    }
    return result;
  }

  String authenAlert(String code) {
    if (code == 'invalid-email') {
      return 'อีเมลล์ไม่ถูกต้อง';
    } else if (code == 'email-already-in-use') {
      return 'อีเมลล์ถูกใช้งานแล้ว กรุณาลองอีเมลล์อื่น';
    } else if (code == 'wrong-password') {
      return 'รหัสผ่านไม่ถูกต้อง';
    } else {
      return "Error 404 Not Found";
    }
  }

  List<String> convertToList(String value) {
    List<String> result = [];
    value = value.substring(1, value.length - 1);
    List<String> strings = value.split(',');
    for (var item in strings) {
      result.add(item.trim());
    }
    return result;
  }

  String convertShopTime(String time) {
    DateTime convert = DateTime.parse("2022-05-01T$time.000Z");
    return DateFormat('HH:mm').format(convert);
  }

  String convertNotiTime(DateTime time) {
    return DateFormat('dd-MM-yyyy').format(time);
  }

  String convertBirthTime(DateTime time) {
    return DateFormat('dd-MM-yyyy').format(time);
  }
}
