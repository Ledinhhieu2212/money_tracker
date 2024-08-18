class User {
  final int id;
  final String username;
  final String password;
  final String email;
  final String phone;
  final String? token;

  User({
    required this.id,
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      token: json['token'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        "username": username,
        "token": token,
        "email": email,
        "password": password,
        "phone": phone,
      };

  factory User.fromMap(Map<String, dynamic> json) => new User(
        id: json['id'] as int,
        username: json['username'] as String,
        password: json['password'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        token: json['token'] as String?,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      "username": username,
      "token": token,
      "email": email,
      "password": password,
      "phone": phone,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, phone: $phone, email: $email, password: $password, token: $token}';
  }
}
