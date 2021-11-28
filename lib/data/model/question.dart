import 'dart:convert';

import 'package:mood/data/model/answer.dart';

class Question {
  String id;
  String? name;
  String? label;
  DateTime? created;
  DateTime? modified;
  List<Answer>? answers;
  List<dynamic> survey;
  List<dynamic> user;

  Question(
      {required this.id,
      this.name,
      this.label,
      this.created,
      this.modified,
      this.answers,
      required this.survey,
      required this.user});

  Question.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        name = json.containsKey('name') ? json['name'] : null,
        label = json.containsKey('label') ? json['label'] : null,
        created = json.containsKey('created')
            ? DateTime.parse(json['created'])
            : DateTime.now(),
        modified = json.containsKey('modified')
            ? DateTime.parse(json['modified'])
            : DateTime.now(),
        answers = Answer.fromList(json['answers']),
        survey = json['survey'],
        user = json['user'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'label': label,
        'created': created,
        'modified': modified,
        'answers': answers,
        'survey': survey,
        'user': user
      };

  static List<Question> fromList(List<dynamic> json) {
    List<Question> questions = [];
    for (dynamic c in json) {
      questions.add(Question.fromMap(c));
    }
    return questions;
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}
