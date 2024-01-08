import 'package:get/get.dart';

class ConfigViewModel extends GetxController {
  final RxString _targetVersion = ''.obs;
  final RxString _baseVersion = ''.obs;

  String get targetVersion => _targetVersion.value;
  String get baseVersion => _baseVersion.value;

  void setTargetVersion(String value) {
    _targetVersion.value = value;
    update();
  }

  void setBaseVersion(String value) {
    _baseVersion.value = value;
    update();
  }
}
