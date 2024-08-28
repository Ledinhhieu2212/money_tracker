import 'dart:async';
import 'package:money_tracker/model/wallet.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabaseWallet() async {
  final database =
      openDatabase(join(await getDatabasesPath(), 'wallet_database.db'),
          onCreate: (db, version) {
    return db.execute(
        'create table IF NOT EXISTS wallets(id_wallet TEXT PRIMARY KEY, id_user INTEGER, icon TEXT, name TEXT, money_price INTEGER, total INTEGER, description TEXT, create_up TEXT, upload_up TEXT)');
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
    await db.update("wallets", p.toMapUpdate(),
        where: "id_wallet=?", whereArgs: [p.id_wallet]);
  }

  Future<void> updateTotal({
    required String walletID,
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
            'id_wallet': id_wallet as String,
            'icon': icon as String,
            'total': total as int,
            'id_user': id_user as int,
            'name': name as String,
            'money_price': money_price as int,
            'description': description as String,
            "create_up": create_up as String,
            "upload_up": upload_up as String,
          } in wallet)
        Wallet(
          id_wallet: id_wallet,
          icon: icon,
          name: name,
          total: total,
          id_user: id_user,
          money_price: money_price,
          description: description,
          create_up: create_up,
          upload_up: upload_up,
        ),
    ];
  }

  Future<List<Wallet>> searchWallets(int UserId) async {
    final List<Map<String, Object?>> wallet = await db.query(
      "wallets",
      where: "id_user=?",
      whereArgs: [UserId],
      orderBy: "create_up DESC",
    );
    return [
      for (final {
            'id_wallet': id_wallet as String,
            'icon': icon as String,
            'total': total as int,
            'id_user': id_user as int,
            'name': name as String,
            'money_price': money_price as int,
            'description': description as String,
            "create_up": create_up as String,
            "upload_up": upload_up as String,
          } in wallet)
        Wallet(
          id_wallet: id_wallet,
          icon: icon,
          name: name,
          total: total,
          id_user: id_user,
          money_price: money_price,
          description: description,
          create_up: create_up,
          upload_up: upload_up,
        ),
    ];
  }

  Future<Wallet> getById(String id) async {
    final List<Map<String, Object?>> wallet =
        await db.query("wallets", where: 'id_wallet=?', whereArgs: [id]);
    return Wallet( 
      icon: wallet.first['icon'].toString(),
      name: wallet.first['name'].toString(),
      total: int.parse(wallet.first['total'].toString()),
      description: wallet.first['description'].toString(),
      id_user: int.parse(wallet.first['id_user'].toString()),
      id_wallet: wallet.first['id_wallet'].toString(),
      money_price: int.parse(wallet.first['money_price'].toString()),
      create_up: wallet.first['create_up'].toString(),
      upload_up: wallet.first['upload_up'].toString(),
    );
  }

  Future<void> delete(String id) async {
    await db.delete("wallets", where: "id_wallet=?", whereArgs: [id]);
  }

  Future<void> deleteAllwallets(int id) async {
    await db.delete("wallets");
  }
}
