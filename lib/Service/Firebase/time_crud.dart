import 'package:charoz/Model/Data/time_model.dart';
import 'package:charoz/Service/Restful/api_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TimeCRUD {
  final ApiController capi = Get.find<ApiController>();
  final time = FirebaseFirestore.instance.collection('time');

  Future<TimeModel?> readTimeModel() async {
    TimeModel? model;
    try {
      capi.loadingPage(true);
      final snapshot = await time.limit(1).get();
      for (var item in snapshot.docs) {
        model = convertTime(item, null);
      }
      capi.loadingPage(false);
      return model;
    } catch (e) {
      capi.loadingPage(false);
      return null;
    }
  }
}
