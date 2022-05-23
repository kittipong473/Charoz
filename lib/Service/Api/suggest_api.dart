import 'dart:convert';

import 'package:charoz/Screen/Suggestion/Model/assessment_model.dart';
import 'package:charoz/Screen/Suggestion/Model/suggestion_model.dart';
import 'package:charoz/Service/Route/route_api.dart';
import 'package:http/http.dart' as http;

class SuggestApi {
  Future insertSuggest(
      {required String age,
      required String job,
      required String score,
      required String total,
      required String detail,
      required String time}) async {
    final url = Uri.parse(
        '${RouteApi.domainApiSuggest}addSuggest.php?age=$age&job=$job&score=$score&total=$total&detail=$detail&created=$time');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() == 'true') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getAllAssessment() async {
    List<AssessmentModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiSuggest}getAllAssessment.php');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          AssessmentModel model = AssessmentModel.fromMap(item);
          result.add(model);
        }
      }
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future getAllSuggest() async {
    List<SuggestionModel> result = [];
    final url = Uri.parse('${RouteApi.domainApiSuggest}getAllSuggest.php');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          SuggestionModel model = SuggestionModel.fromMap(item);
          result.add(model);
        }
      }
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future getSuggestWhereId({required String id}) async {
    SuggestionModel? result;
    final url =
        Uri.parse('${RouteApi.domainApiSuggest}getSuggestWhereId.php?id=$id');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200 && response.body.toString() != 'null') {
        for (var item in json.decode(response.body)) {
          result = SuggestionModel.fromMap(item);
        }
      }
      return result;
    } catch (e) {
      print(e);
    }
  }
}
