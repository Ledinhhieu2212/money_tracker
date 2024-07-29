
import 'dart:convert';

User clientFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromMap(jsonData);
}

String clientToJson(User data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class User {
  final int? ma_nguoi_dung;
  final String? ten_nguoi_dung;
  final String? password;
  final String? email;
  final double? so_du;
  final String? soDienThoai;


  User(
      {this.ma_nguoi_dung,
      this.ten_nguoi_dung,
      this.so_du,
      this.email,
      this.password,
      this.soDienThoai});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      ma_nguoi_dung: json['ma_nguoi_dung'] as int?,
      ten_nguoi_dung: json['ten_nguoi_dung'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      so_du: json['so_du'] as double?,
      soDienThoai: json['soDienThoai'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
        'ma_nguoi_dung': ma_nguoi_dung,
        "ten_nguoi_dung": ten_nguoi_dung,
        "so_du": so_du,
        "email": email,
        "password": password,
        "soDienThoai": soDienThoai,
      };

  factory User.fromMap(Map<String, dynamic> json) => new User(
        ma_nguoi_dung: json["ma_nguoi_dung"],
        ten_nguoi_dung: json["ten_nguoi_dung"],
        so_du: json["so_du"],
        email: json["email"] ,
        password: json["password"] ,
        soDienThoai: json["soDienThoai"] ,
      );
  Map<String, dynamic> toMap() {
    return {
      'ma_nguoi_dung': ma_nguoi_dung,
      "ten_nguoi_dung": ten_nguoi_dung,
      "so_du": so_du,
      "email": email,
      "password": password,
      "soDienThoai": soDienThoai,
    };
  }
}
