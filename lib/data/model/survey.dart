import 'dart:convert';

import 'package:mood/data/model/question.dart';

class Survey {
  String id;
  String name;
  DateTime? created;
  DateTime? modified;
  List<Question>? questions;
  List<dynamic> category;
  List<dynamic>? user;

  Survey(
      {required this.id,
      required this.name,
      this.created,
      this.modified,
      this.questions,
      required this.category,
      this.user});

  Survey.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        created = json.containsKey('created')
            ? DateTime.parse(json['created'])
            : DateTime.now(),
        modified = json.containsKey('modified')
            ? DateTime.parse(json['modified'])
            : DateTime.now(),
        questions = Question.fromList(json['questions']),
        category = json['category'],
        user = json['user'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'created': created,
        'modified': modified,
        'category': category,
        'questions': questions,
        'user': user
      };

  static List<Survey> fromList(List<dynamic> json) {
    List<Survey> surveys = [];
    for (dynamic c in json) {
      surveys.add(Survey.fromMap(c));
    }
    return surveys;
  }

  String toJson() => json.encode(toMap());

  factory Survey.fromJson(String source) => Survey.fromMap(json.decode(source));
}
