import 'dart:convert';

import 'package:http/http.dart';
import 'package:mood/data/model/survey.dart';
import 'package:mood/data/model/question.dart';
import 'package:mood/data/model/category.dart';
import 'package:mood/data/model/user.dart';
import 'package:mood/data/service/api/api.dart';
import 'package:mood/data/service/api/api_path.dart';
import 'package:mood/data/service/api/connector.dart';

class MoodAPI extends API implements Connector {
  MoodAPI({required this.authToken});

  var client = Client();
  String authToken;

  @override
  Future<Category> addCategory(Category category) {
    // TODO: implement addCategory
    throw UnimplementedError();
  }

  @override
  Future<Question> addQuestion(Question question) {
    // TODO: implement addQuestion
    throw UnimplementedError();
  }

  @override
  Future<Survey> addSurvey(Survey survey) {
    // TODO: implement addSurvey
    throw UnimplementedError();
  }

  @override
  Future<Map<Category, List<Category>>> completeCategories() async {
    Response response = await get(Uri.http(APIPath.url, 'api/category/base'),
        headers: {'Authorization': 'Bearer $authToken'});

    Map<Category, List<Category>> baseCategories = <Category, List<Category>>{};

    try {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      for (var dict in jsonResponse) {
        Category baseCategory = Category.fromMap(dict['parent']);
        if (baseCategory != null) {
          baseCategories[baseCategory] = <Category>[];

          List<dynamic> childCategories = dict['children'];

          for (var childDict in childCategories) {
            baseCategories[baseCategory]!.add(Category.fromMap(childDict));
          }
        }
      }
    } on Exception {}
    return baseCategories;
  }

  @override
  Future<bool> deleteCategory(Category category) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteQuestion(Question question) {
    // TODO: implement deleteQuestion
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteSurvey(Survey survey) {
    // TODO: implement deleteSurvey
    throw UnimplementedError();
  }

  @override
  Future<Category> editCategory(Category category) {
    // TODO: implement editCategory
    throw UnimplementedError();
  }

  @override
  Future<Question> editQuestion(Question question) {
    // TODO: implement editQuestion
    throw UnimplementedError();
  }

  @override
  Future<Survey> editSurvey(Survey survey) {
    // TODO: implement editSurvey
    throw UnimplementedError();
  }
}
