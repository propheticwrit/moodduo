import 'package:mood/data/model/category.dart';
import 'package:mood/data/model/question.dart';
import 'package:mood/data/model/survey.dart';
import 'package:mood/data/service/api/connector.dart';
import 'package:mood/data/service/api/mood_api.dart';

class Repository {
  String authToken;

  late Connector connector;

  Repository({required this.authToken}) {
    connector = MoodAPI(authToken: authToken);
  }

  Future<Map<Category, List<Category>>> fetchCategories() async {
    return await connector.completeCategories();
  }

  Future<Category> addCategory(Category category) async {
    return await connector.addCategory(category);
  }

  Future<Survey> addSurvey(Survey survey) async {
    return await connector.addSurvey(survey);
  }

  Future<Question> addQuestion(Question question) async {
    return await connector.addQuestion(question);
  }

  Future<Category> editCategory(Category category) async {
    return await connector.editCategory(category);
  }

  Future<Survey> editSurvey(Survey survey) async {
    return await connector.editSurvey(survey);
  }

  Future<Question> editQuestion(Question question) async {
    return await connector.editQuestion(question);
  }

  Future<bool> deleteCategory(Category category) async {
    return await connector.deleteCategory(category);
  }

  Future<bool> deleteSurvey(Survey survey) async {
    return await connector.deleteSurvey(survey);
  }

  Future<bool> deleteQuestion(Question question) async {
    return await connector.deleteQuestion(question);
  }
}
