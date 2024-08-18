import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:money_tracker/model/transaction.dart' as modelTransaction;

Future<Database> getDatabase() async {
  final database =
      openDatabase(join(await getDatabasesPath(), 'bkap_database.db'),
          onCreate: (db, version) {
    return db.execute(
        'create table IF NOT EXISTS transactions(id INTEGER PRIMARY KEY, id_user INTEGER,id_wallet INTEGER, money INTEGER, dateTime TEXT, description TEXT, transaction_type INTEGER)');
  }, version: 1);
  return database;
}

class TransactionService {
  Database db;
  TransactionService(this.db);
  Future<void> insert(modelTransaction.Transaction p) async {
    db.insert("transactions", p.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(modelTransaction.Transaction p) async {
    db.update("transactions", p.toMap(), where: "id=?", whereArgs: [p.id]);
  }

  Future<List<modelTransaction.Transaction>> getAll() async {
    final List<Map<String, Object?>> transaction =
        await db.query("transactions", orderBy: 'id DESC');
    return [
      for (final {
            'id': id as int,
            'money': money as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as int,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as int,
          } in transaction)
        modelTransaction.Transaction(
          id: id,
          money: money,
          id_user: id_user,
          dateTime: dateTime,
          id_wallet: id_wallet,
          description: description,
          transaction_type: transaction_type,
        ),
    ];
  }

  Future<List<modelTransaction.Transaction>> search(
      {required int transactionID}) async {
    final List<Map<String, Object?>> transaction = await db
        .query("transactions", where: "id=?", whereArgs: [transactionID]);
    return [
      for (final {
            'id': id as int,
            'money': money as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as int,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as int,
          } in transaction)
        modelTransaction.Transaction(
          id: id,
          money: money,
          id_user: id_user,
          dateTime: dateTime,
          id_wallet: id_wallet,
          description: description,
          transaction_type: transaction_type,
        ),
    ];
  }

  Future<List<modelTransaction.Transaction>> searchOfUser(
      {required int userId}) async {
    final List<Map<String, Object?>> transaction = await db.query(
        "transactions",
        where: "id_user=?",
        whereArgs: [userId],
        orderBy: 'id DESC');
    return [
      for (final {
            'id': id as int,
            'money': money as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as int,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as int,
          } in transaction)
        modelTransaction.Transaction(
          id: id,
          money: money,
          id_user: id_user,
          dateTime: dateTime,
          id_wallet: id_wallet,
          description: description,
          transaction_type: transaction_type,
        ),
    ];
  }

  Future<int> totalPriceType(
      {required int userId, required int typePrice}) async {
    final List<Map<String, Object?>> transaction = await db.query(
        "transactions",
        where: "id_user=? AND transaction_type=?",
        whereArgs: [userId, typePrice]);
    int totalMoney = 0;

    List<modelTransaction.Transaction> transactions = [
      for (final {
            'id': id as int,
            'money': money as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as int,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as int,
          } in transaction)
        modelTransaction.Transaction(
          id: id,
          money: money,
          id_user: id_user,
          dateTime: dateTime,
          id_wallet: id_wallet,
          description: description,
          transaction_type: transaction_type,
        ),
    ];

    for (final t in transactions) {
      totalMoney += t.money;
    }
    return totalMoney ?? 0;
  }

  Future<int> totalPriceWalletType(
      {required int userId,
      required int typePrice,
      required int walletID}) async {
    final List<Map<String, Object?>> transaction = await db.query(
        "transactions",
        where: "id_user=? AND transaction_type=? AND id_wallet=?",
        whereArgs: [userId, typePrice, walletID]);
    int totalMoney = 0;

    List<modelTransaction.Transaction> transactions = [
      for (final {
            'id': id as int,
            'money': money as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as int,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as int,
          } in transaction)
        modelTransaction.Transaction(
          id: id,
          money: money,
          id_user: id_user,
          dateTime: dateTime,
          id_wallet: id_wallet,
          description: description,
          transaction_type: transaction_type,
        ),
    ];

    for (final t in transactions) {
      totalMoney += t.money;
    }
    return totalMoney ?? 0;
  }

  Future<modelTransaction.Transaction> getById(int id) async {
    final List<Map<String, Object?>> transaction =
        await db.query("transactions", where: 'id=?', whereArgs: [id]);
    return modelTransaction.Transaction(
      id: int.parse(transaction.first['id'].toString()),
      dateTime: transaction.first['dateTime'].toString(),
      money: int.parse(transaction.first['money'].toString()),
      description: transaction.first['description'].toString(),
      id_user: int.parse(transaction.first['id_user'].toString()),
      id_wallet: int.parse(transaction.first['id_wallet'].toString()),
      transaction_type:
          int.parse(transaction.first['transaction_type'].toString()),
    );
  }

  Future<void> delete(int id) async {
    await db.delete("transactions", where: "id=?", whereArgs: [id]);
  }

  Future<void> deleteAllTransactions(String id) async {
    await db.delete("transactions");
  }
}
