import 'dart:async';
import 'package:money_tracker/model/wallet.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabaseWallet() async {
  final database =
      openDatabase(join(await getDatabasesPath(), 'wallet_database.db'),
          onCreate: (db, version) {
    return db.execute(
        'create table IF NOT EXISTS wallets(id_wallet INTEGER PRIMARY KEY, id_user INTEGER, icon INTEGER, money_price INTEGER, total INTEGER, description TEXT)');
  }, version: 1);
  return database;
}

class WalletService {
  Database db;
  WalletService(this.db);
  Future<void> insert(Wallet p) async {
    await db.insert("wallets", p.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Wallet p) async {
    await db.update("wallets", p.toMap(),
        where: "id_wallet=?", whereArgs: [p.id_wallet]);
  }

  Future<void> updateTotal({
    required int walletID,
    required int price,
  }) async {
    await db.update(
      "wallets",
      {"total": price}, 
      where: "id_wallet = ?",
      whereArgs: [walletID],
    );
  }

  Future<List<Wallet>> getAll() async {
    final List<Map<String, Object?>> wallet = await db.query("wallets");
    return [
      for (final {
            'icon': icon as int,
            'total': total as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as int,
            'money_price': money_price as int,
            'description': description as String,
          } in wallet)
        Wallet(
          icon: icon,
          total: total,
          id_user: id_user,
          id_wallet: id_wallet,
          money_price: money_price,
          description: description,
        ),
    ];
  }

  Future<List<Wallet>> search(int id) async {
    final List<Map<String, Object?>> wallet = await db
        .query("wallets", where: "id_wallet like ?", whereArgs: ["%$id%"]);
    return [
      for (final {
            'icon': icon as int,
            'total': total as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as int,
            'money_price': money_price as int,
            'description': description as String,
          } in wallet)
        Wallet(
          icon: icon,
          total: total,
          id_user: id_user,
          id_wallet: id_wallet,
          money_price: money_price,
          description: description,
        ),
    ];
  }

  Future<List<Wallet>> searchWallets(int UserId) async {
    final List<Map<String, Object?>> wallet = await db
        .query("wallets", where: "id_user like ?", whereArgs: ["%$UserId%"]);
    return [
      for (final {
            'icon': icon as int,
            'total': total as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as int,
            'money_price': money_price as int,
            'description': description as String,
          } in wallet)
        Wallet(
          icon: icon,
          total: total,
          id_user: id_user,
          id_wallet: id_wallet,
          money_price: money_price,
          description: description,
        ),
    ];
  }

  Future<List<Wallet>> searchWallet(int id_wallet) async {
    final List<Map<String, Object?>> wallet = await db.query("wallets",
        where: "id_wallet like ?", whereArgs: ["%$id_wallet%"]);
    return [
      for (final {
            'icon': icon as int,
            'total': total as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as int,
            'money_price': money_price as int,
            'description': description as String,
          } in wallet)
        Wallet(
          icon: icon,
          total: total,
          id_user: id_user,
          id_wallet: id_wallet,
          money_price: money_price,
          description: description,
        ),
    ];
  }

  Future<Wallet> getById(int id) async {
    final List<Map<String, Object?>> wallet =
        await db.query("wallets", where: 'id_wallet=?', whereArgs: [id]);
    return Wallet(
      icon: int.parse(wallet.first['icon'].toString()),
      total: int.parse(wallet.first['total'].toString()),
      description: wallet.first['description'].toString(),
      id_user: int.parse(wallet.first['id_user'].toString()),
      id_wallet: int.parse(wallet.first['id_wallet'].toString()),
      money_price: int.parse(wallet.first['money_price'].toString()),
    );
  }

  Future<void> delete(int id) async {
    await db.delete("wallets", where: "id_wallet=?", whereArgs: [id]);
  }

  Future<void> deleteAllwallets(int id) async {
    await db.delete("wallets");
  }
}
