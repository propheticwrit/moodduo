import 'dart:convert';

import 'package:mood/data/model/survey.dart';

class Category {
  String id;
  String name;
  String? parent;
  DateTime? created;
  DateTime? modified;
  List<Survey>? surveys;
  List<dynamic> user;

  Category(
      {required this.id,
      required this.name,
      this.parent,
      this.created,
      this.modified,
      this.surveys,
      required this.user});

  Category.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        parent = json.containsKey('parent') ? json['parent'] : null,
        created = json.containsKey('created')
            ? DateTime.parse(json['created'])
            : DateTime.now(),
        modified = json.containsKey('modified')
            ? DateTime.parse(json['modified'])
            : DateTime.now(),
        surveys = Survey.fromList(json['surveys']),
        user = json['user'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'parent': parent,
        'created': created,
        'modified': modified,
        'surveys': surveys,
        'user': user
      };

  static List<Category> fromList(List<dynamic> json) {
    List<Category> categories = [];
    for (dynamic c in json) {
      categories.add(Category.fromMap(c));
    }
    return categories;
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
