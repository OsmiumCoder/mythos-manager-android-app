class User {
  final int id;
  final String username;
  final String email;
  final String password;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password});

  // TODO: change to fromDocumentSnapshot
  User.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        password = json['password'];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password,
    };
  }
}
