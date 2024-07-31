import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:money_tracker/model/transaction.dart' as modelTransaction;

Future<Database> getDatabase() async {
  final database =
      openDatabase(join(await getDatabasesPath(), 'bkap_database.db'),
          onCreate: (db, version) {
    return db.execute(
        'create table IF NOT EXISTS transactions(id INTEGER PRIMARY KEY, id_user TEXT, money TEXT, dateTime TEXT, description TEXT, transaction_type TEXT)');
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
        await db.query("transactions");
    return [
      for (final {
            'id': id as int,
            'money': money as String,
            'id_user': id_user as String,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as String,
          } in transaction)
        modelTransaction.Transaction(
          id,
          money,
          id_user,
          dateTime,
          description,
          transaction_type,
        ),
    ];
  }

  Future<List<modelTransaction.Transaction>> search(int id) async {
    final List<Map<String, Object?>> transaction = await db
        .query("transactions", where: "id like ?", whereArgs: ["%$id%"]);
    return [
      for (final {
            'id': id as int,
            'money': money as String,
            'id_user': id_user as String,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as String,
          } in transaction)
        modelTransaction.Transaction(
            id, money, id_user, dateTime, description, transaction_type),
    ];
  }

  Future<List<modelTransaction.Transaction>> searchOfUser(String UserId) async {
    final List<Map<String, Object?>> transaction = await db.query(
        "transactions",
        where: "id_user like ?",
        whereArgs: ["%$UserId%"]);
    return [
      for (final {
            'id': id as int,
            'money': money as String,
            'id_user': id_user as String,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as String,
          } in transaction)
        modelTransaction.Transaction(
            id, money, id_user, dateTime, description, transaction_type),
    ];
  }

  Future<double> totalPriceInCome(String UserId) async {
    final List<Map<String, Object?>> transaction = await db.query(
        "transactions",
        where: "id_user like ? AND transaction_type = '1'",
        whereArgs: ["%$UserId%"]);
    double totalMoney = 0.0;

    List<modelTransaction.Transaction> transactions = [
      for (final {
            'id': id as int,
            'money': money as String,
            'id_user': id_user as String,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as String,
          } in transaction)
        modelTransaction.Transaction(
            id, money, id_user, dateTime, description, transaction_type),
    ];

    for (final t in transactions) {
      totalMoney += double.tryParse(t.money) ?? 0.0;
    }

    return totalMoney;
  }

  Future<double> totalPriceSpending(String UserId) async {
    final List<Map<String, Object?>> transaction = await db.query(
        "transactions",
        where: "id_user like ? AND transaction_type = '0'",
        whereArgs: ["%$UserId%"]);
    double totalMoney = 0.0;

    List<modelTransaction.Transaction> transactions = [
      for (final {
            'id': id as int,
            'money': money as String,
            'id_user': id_user as String,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as String,
          } in transaction)
        modelTransaction.Transaction(
            id, money, id_user, dateTime, description, transaction_type),
    ];

    for (final t in transactions) {
      totalMoney += double.tryParse(t.money) ?? 0.0;
    }
    return totalMoney;
  }

  Future<modelTransaction.Transaction> getById(int id) async {
    final List<Map<String, Object?>> transaction =
        await db.query("transactions", where: 'id=?', whereArgs: [id]);
    return modelTransaction.Transaction(
      int.parse(transaction.first['id'].toString()),
      transaction.first['money'].toString(),
      transaction.first['id_user'].toString(),
      transaction.first['dateTime'].toString(),
      transaction.first['description'].toString(),
      transaction.first['transaction_type'].toString(),
    );
  }

  Future<void> delete(int id) async {
    await db.delete("transactions", where: "id=?", whereArgs: [id]);
  }

  Future<void> deleteAllTransactions(String id) async {
    await db.delete("transactions");
  }
}
