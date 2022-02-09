import 'dart:convert';

import 'package:mood/data/model/response.dart';

class Report {
  String id;
  DateTime? created;
  DateTime? modified;
  bool complete;
  int observation;
  int survey;
  List<Response>? responses;

  Report(
      {required this.id,
      this.created,
      this.modified,
      required this.complete,
      required this.observation,
      required this.survey,
      this.responses});

  Report.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        created = json.containsKey('created')
            ? DateTime.parse(json['created'])
            : DateTime.now(),
        modified = json.containsKey('modified')
            ? DateTime.parse(json['modified'])
            : DateTime.now(),
        complete = json['complete'],
        responses = Response.fromList(json['responses']),
        survey = json['survey'],
        observation = json['observation'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'created': created,
        'modified': modified,
        'complete': complete,
        'responses': responses,
        'survey': survey,
        'observation': observation
      };

  static List<Report> fromList(List<dynamic> json) {
    List<Report> reports = [];
    for (dynamic c in json) {
      reports.add(Report.fromMap(c));
    }
    return reports;
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) => Report.fromMap(json.decode(source));
}
