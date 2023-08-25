import 'dart:developer';

class LogFunction {
  // Hidden & Not Important
  void consoleLogBlack({required String text}) {
    log('\x1B[30m$text\x1B[0m');
  }

  // Obvious & Important
  void consoleLogRed({required String text}) {
    log('\x1B[31m$text\x1B[0m');
  }

  // Permission & Acception
  void consoleLogGreen({required String text}) {
    log('\x1B[32m$text\x1B[0m');
  }

  // API Request & Response
  void consoleLogYellow({required String text}) {
    log('\x1B[33m$text\x1B[0m');
  }

  // Notification
  void consoleLogDarkBlue({required String text}) {
    log('\x1B[34m$text\x1B[0m');
  }

  //
  void consoleLogPurple({required String text}) {
    log('\x1B[35m$text\x1B[0m');
  }

  //
  void consoleLogLightBlue({required String text}) {
    log('\x1B[36m$text\x1B[0m');
  }

  // Particular
  void consoleLogWhite({required String text}) {
    log('\x1B[37m$text\x1B[0m');
  }
}
