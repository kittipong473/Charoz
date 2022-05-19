import 'package:charoz/Screen/Suggestion/Model/assessment_model.dart';
import 'package:charoz/Screen/Suggestion/Model/suggestion_model.dart';
import 'package:charoz/Service/Api/suggest_api.dart';
import 'package:flutter/cupertino.dart';

class SuggestProvider with ChangeNotifier {
  SuggestionModel? _suggest;

  List<AssessmentModel> _assessments = [];
  List<SuggestionModel> _suggests = [];
  final List<String> _scores = [];

  get suggest => _suggest;

  get assessments => _assessments;
  get assessmentsLength => _assessments.length;

  get suggests => _suggests;
  get suggestsLength => _suggests.length;

  get scores => _scores;
  get scoresLength => _scores.length;

  Future getAssessment() async {
    _assessments = await SuggestApi().getAllAssessment();
    notifyListeners();
  }

  Future getAllSuggest() async {
    _suggests = await SuggestApi().getAllSuggest();
    notifyListeners();
  }

  Future getSuggestWhereId(String id) async {
    _suggest = await SuggestApi().getSuggestWhereId(id: id);
    convertScore(_suggest!.suggestScore);
    notifyListeners();
  }

  void convertScore(String score) {
    if (_scores.isNotEmpty) {
      _scores.clear();
    }
    String string = score;
    string = string.substring(1, string.length - 1);
    List<String> strings = string.split(',');
    for (var item in strings) {
      _scores.add(item.trim());
    }
    notifyListeners();
  }
}
