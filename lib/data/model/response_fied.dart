import 'dart:convert';

class ResponseField {
  String id;
  String text;
  DateTime? created;
  DateTime? modified;
  int response;

  ResponseField(
      {required this.id,
      required this.text,
      this.created,
      this.modified,
      required this.response});

  ResponseField.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        created = json.containsKey('created')
            ? DateTime.parse(json['created'])
            : DateTime.now(),
        modified = json.containsKey('modified')
            ? DateTime.parse(json['modified'])
            : DateTime.now(),
        response = json['response'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'text': text,
        'created': created,
        'modified': modified,
        'response': response
      };

  static List<ResponseField> fromList(List<dynamic> json) {
    List<ResponseField> responseFields = [];
    for (dynamic c in json) {
      responseFields.add(ResponseField.fromMap(c));
    }
    return responseFields;
  }

  String toJson() => json.encode(toMap());

  factory ResponseField.fromJson(String source) =>
      ResponseField.fromMap(json.decode(source));
}
