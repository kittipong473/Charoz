// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';

// class LocalAuthApi {
//   static final _auth = LocalAuthentication();

//   static Future<bool> hasBiometric() async {
//     try {
//       return await _auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       return false;
//     }
//   }

//   static Future<bool> authenticate() async {
//     final isAvaliable = await hasBiometric();
//     if (!isAvaliable) return false;

//     try {
//       return await _auth.authenticate(
//         localizedReason: 'Scan Fingerprint to Authenticate',
//         options: const AuthenticationOptions(
//             useErrorDialogs: true, stickyAuth: true),
//       );
//     } on PlatformException catch (e) {
//       return false;
//     }
//   }
// }
