import 'dart:convert';

class InputType {
  String id;
  String? type;
  List<dynamic> answer;

  InputType({required this.id, required this.type, required this.answer});

  InputType.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        type = json.containsKey('type') ? json['type'] : null,
        answer = json['answer'];

  Map<String, dynamic> toMap() => {'id': id, 'type': type, 'answer': answer};

  static List<InputType> fromList(List<dynamic> json) {
    List<InputType> inputTypes = [];
    for (dynamic c in json) {
      inputTypes.add(InputType.fromMap(c));
    }
    return inputTypes;
  }

  String toJson() => json.encode(toMap());

  factory InputType.fromJson(String source) =>
      InputType.fromMap(json.decode(source));
}
