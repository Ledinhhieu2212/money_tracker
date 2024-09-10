import 'dart:async'; 
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

Future<Database> getDatabaseWallet() async {
  final database =
      openDatabase(join(await getDatabasesPath(), 'wallet_database.db'),
          onCreate: (db, version) {
    return db.execute(
        'create table IF NOT EXISTS wallets(id_wallet TEXT PRIMARY KEY, id_user INTEGER, icon TEXT, name TEXT, total INTEGER, description TEXT ,status INTEGER , create_up TEXT, upload_up TEXT)');
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

  Future<void> updateStatus({
    required String walletID,
    required int status,
  }) async {
    await db.update(
      "wallets",
      {"status": status},
      where: "id_wallet = ?",
      whereArgs: [walletID],
    );
  }

  fakeWallet({required int sl, required int userid}) {
    deleteAllwallets(userid);
    imageBase images = imageBase();
    for (var i = 1; i <= sl; i++) {
      Map<String, String> randomWallet = images.getRandomIconWallet();
      insert(Wallet(
          id_wallet: const Uuid().v4(),
          icon: randomWallet['icon']!,
          name: randomWallet['name']!,
          total: 0,
          id_user: userid,
          description: generateRandomString(100),
          status: 1,
          create_up: generateRandomDateTime().toString(),
          upload_up: generateRandomDateTime().toString()));
    }
  }

  Future<List<Wallet>> getAll() async {
    final List<Map<String, Object?>> wallets = await db.query("wallets");
    return getWalletData(wallets);
  }

  List<Wallet> getWalletData(List<Map<String, Object?>> wallets) {
    List<Wallet> walletList = [];
    for (final Map<String, Object?> walletData in wallets) {
      Wallet walletItem = Wallet(
        id_wallet: walletData['id_wallet'] as String,
        icon: walletData['icon'] as String,
        name: walletData['name'] as String,
        total: walletData['total'] as int,
        id_user: walletData['id_user'] as int,
        description: walletData['description'] as String,
        status:  walletData['status'] as int,
        create_up: walletData['create_up'] as String,
        upload_up: walletData['upload_up'] as String,
      );
      walletList.add(walletItem);
    }
    return walletList;
  }

  Future<List<Wallet>> searchWallets(int userId) async {
    final List<Map<String, Object?>> wallets = await db.query(
      "wallets",
      where: "id_user=?",
      whereArgs: [userId],
      orderBy: "create_up DESC",
    );
    return getWalletData(wallets);
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
      status: int.parse(wallet.first['status'].toString()),
      create_up: wallet.first['create_up'].toString(),
      upload_up: wallet.first['upload_up'].toString(),
    );
  }

  Future<void> delete(String id) async {
    await db.delete("wallets", where: "id_wallet=?", whereArgs: [id]);
  }

  Future<void> deleteAllwallets(int id) async {
    await db.delete("wallets", where: "id_user=?", whereArgs: [id]);
  }
}
