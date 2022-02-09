import 'dart:convert';

import 'package:mood/data/model/report.dart';

class Observation {
  String id;
  DateTime? created;
  int user;
  List<Report>? reports;

  Observation(
      {required this.id, this.created, required this.user, this.reports});

  Observation.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        created = json.containsKey('created')
            ? DateTime.parse(json['created'])
            : DateTime.now(),
        reports = Report.fromList(json['reports']),
        user = json['user'];

  Map<String, dynamic> toMap() =>
      {'id': id, 'created': created, 'user': user, 'reports': reports};

  static List<Observation> fromList(List<dynamic> json) {
    List<Observation> observations = [];
    for (dynamic c in json) {
      observations.add(Observation.fromMap(c));
    }
    return observations;
  }

  String toJson() => json.encode(toMap());

  factory Observation.fromJson(String source) =>
      Observation.fromMap(json.decode(source));
}
