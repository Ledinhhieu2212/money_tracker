import 'dart:async';
import 'package:money_tracker/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDataUser() async {
  final database = openDatabase(join(await getDatabasesPath(), 'user.db'),
      onCreate: (db, version) {
    return db.execute(
        'create table IF NOT EXISTS users(id INTEGER PRIMARY KEY, username TEXT, password TEXT, phone TEXT, email TEXT, token  TEXT)');
  }, version: 1);
  return database;
}

class UserService {
  Database db;
  UserService(this.db);
  Future<void> insert(User p) async {
    await db.insert("users", p.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(User p) async {
    await db.update("users", p.toMap(), where: "id=?", whereArgs: [p.id]);
  }

  Future<List<User>> getAll() async {
    final List<Map<String, Object?>> user = await db.query("users");
    return [
      for (final {
            'id': id as int,
            'phone': phone as String,
            'username': username as String,
            'password': password as String,
            'token': token as String,
            'email': email as String,
          } in user)
        User(
          id: id,
          phone: phone,
          email: email,
          token: token,
          username: username,
          password: password, 
        ),
    ];
  }
 Future<User?> getUser(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }
  Future<List<User>> search(int id) async {
    final List<Map<String, Object?>> user =
        await db.query("users", where: "id=?", whereArgs: [id]);
    return [
      for (final {
            'id': id as int,
            'phone': phone as String,
            'username': username as String,
            'password': password as String,
            'token': token as String,
            'email': email as String,
          } in user)
        User(
          id: id,
          phone: phone,
          email: email,
          username: username,
          password: password,
          token: token,
        ),
    ];
  }

  Future<User> getById(int id) async {
    final List<Map<String, Object?>> user =
        await db.query("users", where: 'id=?', whereArgs: [id]);
    return User(
      id: int.parse(user.first['id'].toString()),
      email: user.first['email'].toString(),
      phone: user.first['phone'].toString(),
      password: user.first['password'].toString(),
      username: user.first['username'].toString(),
      token:  user.first['token'].toString(),
    );
  }


  Future<bool> idExists(int id) async {
    final List<Map<String, dynamic>> user = await db.query(
      'users', // Tên bảng của bạn
      columns: ['id'], // Chỉ cần cột 'id'
      where: 'id = ?', // Điều kiện
      whereArgs: [id], // Giá trị của điều kiện
      limit: 1, // Chỉ cần 1 bản ghi
    );

    return user.isNotEmpty; // Nếu có bản ghi, 'id' tồn tại
  }

  Future<void> delete(int id) async {
    await db.delete("users", where: "id=?", whereArgs: [id]);
  }

  Future<void> deleteAllusers(int id) async {
    await db.delete("users");
  }
}
