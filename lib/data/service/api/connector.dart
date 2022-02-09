import 'package:mood/data/model/category.dart';
import 'package:mood/data/model/observation.dart';
import 'package:mood/data/model/question.dart';
import 'package:mood/data/model/report.dart';
import 'package:mood/data/model/response.dart';
import 'package:mood/data/model/response_fied.dart';
import 'package:mood/data/model/survey.dart';

abstract class Connector {
  Future<Map<Category, List<Category>>> completeCategories();

  Future<Category> addCategory(Category category);
  Future<Category> editCategory(Category category);
  Future<bool> deleteCategory(Category category);

  Future<Survey> addSurvey(Survey survey);
  Future<Survey> editSurvey(Survey survey);
  Future<bool> deleteSurvey(Survey survey);

  Future<Question> addQuestion(Question question);
  Future<Question> editQuestion(Question question);
  Future<bool> deleteQuestion(Question question);

  Future<Observation> addObservation(Observation observation);

  Future<Report> addReport(Report report);

  Future<Response> addResponse(Response response);

  Future<ResponseField> addResponseField(ResponseField responseField);
}
