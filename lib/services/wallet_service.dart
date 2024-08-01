import 'dart:async';
import 'package:money_tracker/model/wallet.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final database =
      openDatabase(join(await getDatabasesPath(), 'wallet_database.db'),
          onCreate: (db, version) {
    return db.execute(
        'create table IF NOT EXISTS wallets(id_wallet INTEGER PRIMARY KEY, id_user INTEGER, icon TEXT, money_price INTEGER, description TEXT)');
  }, version: 1);
  return database;
}

class WalletService {
  Database db;
  WalletService(this.db);
  Future<void> insert(Wallet p) async {
    db.insert("wallets", p.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Wallet p) async {
    db.update("wallets", p.toMap(),
        where: "id_wallet=?", whereArgs: [p.id_wallet]);
  }

  Future<List<Wallet>> getAll() async {
    final List<Map<String, Object?>> wallet = await db.query("wallets");
    return [
      for (final {
            'id_wallet': id_wallet as int,
            'id_user': id_user as int,
            'icon': icon as String,
            'money_price': money_price as int,
            'description': description as String,
          } in wallet)
        Wallet(
          id_wallet,
          id_user,
          icon,
          money_price,
          description,
        ),
    ];
  }

  Future<List<Wallet>> search(int id) async {
    final List<Map<String, Object?>> wallet = await db
        .query("wallets", where: "id_wallet like ?", whereArgs: ["%$id%"]);
    return [
      for (final {
            'id_wallet': id_wallet as int,
            'id_user': id_user as int,
            'money_price': money_price as int,
            'description': description as String,
            'icon': icon as String,
          } in wallet)
        Wallet(
          id_wallet,
          id_user,
          icon,
          money_price,
          description,
        ),
    ];
  }

  Future<List<Wallet>> searchWallets(int UserId) async {
    final List<Map<String, Object?>> wallet = await db
        .query("wallets", where: "id_user like ?", whereArgs: ["%$UserId%"]);
    return [
      for (final {
            'id_wallet': id_wallet as int,
            'id_user': id_user as int,
            'money_price': money_price as int,
            'description': description as String,
            'icon': icon as String,
          } in wallet)
        Wallet(
          id_wallet,
          id_user,
          icon,
          money_price,
          description,
        ),
    ];
  }

  Future<List<Wallet>> searchWallet(int id_wallet) async {
    final List<Map<String, Object?>> wallet = await db.query("wallets",
        where: "id_wallet like ?", whereArgs: ["%$id_wallet%"]);
    return [
      for (final {
            'id_wallet': id_wallet as int,
            'id_user': id_user as int,
            'money_price': money_price as int,
            'description': description as String,
            'icon': icon as String,
          } in wallet)
        Wallet(
          id_wallet,
          id_user,
          icon,
          money_price,
          description,
        ),
    ];
  }

  Future<Wallet> getById(int id) async {
    final List<Map<String, Object?>> wallet =
        await db.query("wallets", where: 'id_wallet=?', whereArgs: [id]);
    return Wallet(
      int.parse(wallet.first['id_wallet'].toString()),
      int.parse(wallet.first['id_user'].toString()),
      wallet.first['icon'].toString(),
      int.parse(wallet.first['money_price'].toString()),
      wallet.first['description'].toString(),
    );
  }

  Future<void> delete(int id) async {
    await db.delete("wallets", where: "id_wallet=?", whereArgs: [id]);
  }

  Future<void> deleteAllwallets(int id) async {
    await db.delete("wallets");
  }
}
