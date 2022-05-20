import 'dart:convert';

import 'package:charoz/Screen/Suggestion/Model/assessment_model.dart';
import 'package:charoz/Screen/Suggestion/Model/suggestion_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:http/http.dart' as http;

class SuggestApi {
  Future insertSuggest({
    required String age,
    required String job,
    required String score,
    required String total,
    required String detail,
    required String time,
  }) async {
    final url = Uri.parse(
        '${RouteApi.domainApiSuggest}addSuggest.php?age=$age&job=$job&score=$score&total=$total&detail=$detail&created=$time');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 && response.body.toString() == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future getAllAssessment() async {
    List<AssessmentModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiSuggest}getAllAssessment.php');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        AssessmentModel model = AssessmentModel.fromMap(item);
        result.add(model);
      }
      return result;
    } else {
      return null;
    }
  }

  Future getAllSuggest() async {
    List<SuggestionModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiSuggest}getAllSuggest.php');
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.body.toString() != 'null') {
      for (var item in json.decode(response.body)) {
        SuggestionModel model = SuggestionModel.fromMap(item);
        result.add(model);
      }
      return result;
    } else {
      return null;
    }
  }

  Future getSuggestWhereId({required String id}) async {
    SuggestionModel? result;
    final url =
        Uri.parse('${RouteApi.domainApiSuggest}getSuggestWhereId.php?id=$id');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      for (var item in json.decode(response.body)) {
        result = SuggestionModel.fromMap(item);
      }
      return result;
    } else {
      return null;
    }
  }
}
