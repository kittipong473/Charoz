import 'package:encrypt/encrypt.dart' as encrypt;

class MyFunction {
  String cutWord10(String name) {
    String result = name;
    if (result.length > 13) {
      result = result.substring(0, 10);
      result = '$result...';
    }
    return result;
  }

  String authenAlert(String code) {
    if (code == 'invalid-email'){
      return 'อีเมลล์ไม่ถูกต้อง';
    } else if (code == 'email-already-in-use') {
      return 'อีเมลล์ถูกใช้งานแล้ว กรุณาลองอีเมลล์อื่น';
    } else if (code == 'wrong-password') {
      return 'รหัสผ่านไม่ถูกต้อง';
    } else {
      return "Error 404 Not Found";
    }
  }

  
  String encryption({required String text}) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(text, iv: iv);
    // final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return encrypted.base16.toString();
  }
}
