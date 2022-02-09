import 'dart:convert';

import 'package:mood/data/model/response_fied.dart';

class Response {
  String id;
  DateTime? created;
  DateTime? modified;
  int question;
  int report;
  List<ResponseField>? responseFields;

  Response(
      {required this.id,
      this.created,
      this.modified,
      this.responseFields,
      required this.question,
      required this.report});

  Response.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        created = json.containsKey('created')
            ? DateTime.parse(json['created'])
            : DateTime.now(),
        modified = json.containsKey('modified')
            ? DateTime.parse(json['modified'])
            : DateTime.now(),
        responseFields = ResponseField.fromList(json['response_fields']),
        question = json['question'],
        report = json['report'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'created': created,
        'modified': modified,
        'response_fields': responseFields,
        'question': question,
        'report': report
      };

  static List<Response> fromList(List<dynamic> json) {
    List<Response> responses = [];
    for (dynamic c in json) {
      responses.add(Response.fromMap(c));
    }
    return responses;
  }

  String toJson() => json.encode(toMap());

  factory Response.fromJson(String source) =>
      Response.fromMap(json.decode(source));
}
