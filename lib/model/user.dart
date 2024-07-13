

class User {
  final String? id;
  final String? username;
  final String? password;
  final String? email;
  final String? phone;
  final String? token;

  User(
      {this.id,
      this.username,
      this.password,
      this.email,
      this.phone,
      this.token});


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      token: json['token'] as String?,
    );
  }
   Map<String, dynamic> toJson() => {
        'id':id,
        "username": username,
        "password": password,
        "phone": phone,
        'email': email,
        "token": token,
      };
}

