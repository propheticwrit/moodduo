import 'dart:convert';

import 'package:mood/data/model/input_type.dart';

class Answer {
  String id;
  String? name;
  String? label;
  String? initialValue;
  String? validation;
  int sequence;
  DateTime? created;
  DateTime? modified;
  List<InputType>? inputTypes;
  List<dynamic> question;
  List<dynamic> user;

  Answer(
      {required this.id,
      this.name,
      this.label,
      this.initialValue,
      this.validation,
      required this.sequence,
      this.created,
      this.modified,
      this.inputTypes,
      required this.question,
      required this.user});

  Answer.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        name = json.containsKey('name') ? json['name'] : null,
        label = json.containsKey('label') ? json['label'] : null,
        initialValue =
            json.containsKey('initial_value') ? json['initial_value'] : null,
        validation = json.containsKey('validation') ? json['validation'] : null,
        sequence = json['sequence'],
        created = json.containsKey('created')
            ? DateTime.parse(json['created'])
            : DateTime.now(),
        modified = json.containsKey('modified')
            ? DateTime.parse(json['modified'])
            : DateTime.now(),
        inputTypes = InputType.fromList(json['input_types']),
        question = json['question'],
        user = json['user'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'label': label,
        'initialValue': initialValue,
        'validation': validation,
        'sequence': sequence,
        'created': created,
        'modified': modified,
        'inputTypes': inputTypes,
        'question': question,
        'user': user
      };

  static List<Answer> fromList(List<dynamic> json) {
    List<Answer> answers = [];
    for (dynamic c in json) {
      answers.add(Answer.fromMap(c));
    }
    return answers;
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));
}
