import 'dart:convert';

import 'package:http/http.dart';
import 'package:mood/data/model/survey.dart';
import 'package:mood/data/model/question.dart';
import 'package:mood/data/model/category.dart';
import 'package:mood/data/service/api/api.dart';
import 'package:mood/data/service/api/api_path.dart';
import 'package:mood/data/service/api/connector.dart';

class MoodAPI extends API implements Connector {
  MoodAPI({required this.authToken});

  var client = Client();
  API api = API();

  String authToken;

  Map<String, String> _authHeader() =>
      {'authorization': 'Basic ' + base64Encode(utf8.encode('$authToken:'))};

  Future<Response> _add(String name, String json) async {
    return await api.post(
        uri: Uri.http(APIPath.url, name),
        headers: _authHeader()..addAll({'Content-Type': 'application/json'}),
        body: json);
  }

  Future<Response> _edit(String name, String id, String json) async {
    return await api.patch(
        uri: Uri.http(APIPath.url, '$name/$id'),
        headers: _authHeader()..addAll({'Content-Type': 'application/json'}),
        body: json);
  }

  Future<Response> _delete(String name, String id) async {
    return await api.delete(
        uri: Uri.http(APIPath.url, '$name/$id'), headers: _authHeader());
  }

  @override
  Future<Category> addCategory(Category category) async {
    Response response = await _add('/api/category', category.toJson());
    return Category.fromJson(response.body);
  }

  @override
  Future<Question> addQuestion(Question question) async {
    Response response = await _add('/api/question', question.toJson());
    return Question.fromJson(response.body);
  }

  @override
  Future<Survey> addSurvey(Survey survey) async {
    Response response = await _add('/api/survey', survey.toJson());
    return Survey.fromJson(response.body);
  }

  @override
  Future<Map<Category, List<Category>>> completeCategories() async {
    print(authToken);
    Response response = await api.get(
        uri: Uri.http(APIPath.url, '/api/category/base'),
        headers: _authHeader());

    Map<Category, List<Category>> baseCategories = <Category, List<Category>>{};

    List<dynamic> jsonResponse = jsonDecode(response.body);

    for (var dict in jsonResponse) {
      Category baseCategory = Category.fromMap(dict['parent']);
      baseCategories[baseCategory] = <Category>[];

      List<dynamic> childCategories = dict['children'];

      for (var childDict in childCategories) {
        baseCategories[baseCategory]!.add(Category.fromMap(childDict));
      }
    }

    return baseCategories;
  }

  @override
  Future<bool> deleteCategory(Category category) async {
    Response response = await _delete('/api/category', category.id);
    return response.statusCode == 204;
  }

  @override
  Future<bool> deleteQuestion(Question question) async {
    Response response = await _delete('/api/question', question.id);
    return response.statusCode == 204;
  }

  @override
  Future<bool> deleteSurvey(Survey survey) async {
    Response response = await _delete('/api/survey', survey.id);
    return response.statusCode == 204;
  }

  @override
  Future<Category> editCategory(Category category) async {
    Response response =
        await _edit('/api/category', category.id, category.toJson());
    return Category.fromJson(response.body);
  }

  @override
  Future<Question> editQuestion(Question question) async {
    Response response =
        await _edit('/api/question', question.id, question.toJson());
    return Question.fromJson(response.body);
  }

  @override
  Future<Survey> editSurvey(Survey survey) async {
    Response response = await _edit('/api/survey', survey.id, survey.toJson());
    return Survey.fromJson(response.body);
  }
}
