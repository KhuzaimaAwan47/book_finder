class Users {
  final int? userId;
  final String email;
  final String password;

  Users({
    this.userId,
    required this.email,
    required this.password,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
    userId: json["userId"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "userId": userId,
    "email": email,
    "password": password,
  };
}