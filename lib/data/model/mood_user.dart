class User {
  final int id;
  final String? name;
  final String? email;
  final String? idToken;

  const User({required this.id, this.name, this.email, this.idToken});

  User.fromData(dynamic data)
      : id = data['id'],
        name = data['name'],
        email = data['email'],
        idToken = data['idToken'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'idToken': idToken,
    };
  }

  static const empty = User(id: -1);

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;
}
