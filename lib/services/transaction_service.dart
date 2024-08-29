import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:money_tracker/model/transaction.dart' as modelTransaction;

Future<Database> getDatabase() async {
  final database =
      openDatabase(join(await getDatabasesPath(), 'bkap_database.db'),
          onCreate: (db, version) {
    return db.execute(
        'create table IF NOT EXISTS transactions(id TEXT PRIMARY KEY, id_user INTEGER,id_wallet INTEGER, money INTEGER, dateTime TEXT, description TEXT, transaction_type INTEGER, create_up TEXT, upload_up TEXT)');
  }, version: 1);
  return database;
}

class TransactionService {
  Database db;
  TransactionService(this.db);
  Future<void> insert(modelTransaction.Transaction p) async {
    db.insert("transactions", p.toMapInsert(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(modelTransaction.Transaction p) async {
    db.update("transactions", p.toMapUpload(),
        where: "id=?", whereArgs: [p.id]);
  }

  Future<List<modelTransaction.Transaction>> getAll() async {
    final List<Map<String, Object?>> transaction =
        await db.query("transactions", orderBy: 'create_up DESC');
    return [
      for (final {
            'id': id as String,
            'money': money as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as String,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as int,
            "create_up": create_up as String,
            "upload_up": upload_up as String
          } in transaction)
        modelTransaction.Transaction(
          id: id,
          money: money,
          id_user: id_user,
          dateTime: dateTime,
          id_wallet: id_wallet,
          description: description,
          transaction_type: transaction_type,
          create_up: create_up,
          upload_up: upload_up,
        ),
    ];
  }

  Future<List<modelTransaction.Transaction>> search(
      {required String transactionID}) async {
    final List<Map<String, Object?>> transaction = await db
        .query("transactions", where: "id=?", whereArgs: [transactionID]);
    return [
      for (final {
            'id': id as String,
            'money': money as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as String,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as int,
            "create_up": create_up as String,
            "upload_up": upload_up as String
          } in transaction)
        modelTransaction.Transaction(
          id: id,
          money: money,
          id_user: id_user,
          dateTime: dateTime,
          id_wallet: id_wallet,
          description: description,
          transaction_type: transaction_type,
          create_up: create_up,
          upload_up: upload_up,
        ),
    ];
  }

  Future<List<modelTransaction.Transaction>> searchOfUser(
      {required int userId}) async {
    final List<Map<String, Object?>> transaction = await db.query(
        "transactions",
        where: "id_user=?",
        whereArgs: [userId],
        orderBy: 'create_up DESC');
    return [
      for (final {
            'id': id as String,
            'money': money as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as String,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as int,
            "create_up": create_up as String,
            "upload_up": upload_up as String
          } in transaction)
        modelTransaction.Transaction(
          id: id,
          money: money,
          id_user: id_user,
          dateTime: dateTime,
          id_wallet: id_wallet,
          description: description,
          transaction_type: transaction_type,
          create_up: create_up,
          upload_up: upload_up,
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
            'id': id as String,
            'money': money as int,
            'id_user': id_user as int,
            'id_wallet': id_wallet as String,
            'dateTime': dateTime as String,
            'description': description as String,
            'transaction_type': transaction_type as int,
            "create_up": create_up as String,
            "upload_up": upload_up as String
          } in transaction)
        modelTransaction.Transaction(
          id: id,
          money: money,
          id_user: id_user,
          dateTime: dateTime,
          id_wallet: id_wallet,
          description: description,
          transaction_type: transaction_type,
          create_up: create_up,
          upload_up: upload_up,
        ),
    ];

    for (final t in transactions) {
      totalMoney += t.money;
    }
    return totalMoney ?? 0;
  }

  int totalWalletType(
      {required int type,
      required List<modelTransaction.Transaction> tracsactions}) {
    int total = tracsactions
        .where((transaction) => transaction.transaction_type == type)
        .fold(0, (sum, transaction) => sum + transaction.money);

    return total;
  }

  Future<modelTransaction.Transaction> getById(String id) async {
    final List<Map<String, Object?>> transaction =
        await db.query("transactions", where: 'id=?', whereArgs: [id]);
    return modelTransaction.Transaction(
      id: transaction.first['id'].toString(),
      dateTime: transaction.first['dateTime'].toString(),
      money: int.parse(transaction.first['money'].toString()),
      description: transaction.first['description'].toString(),
      id_user: int.parse(transaction.first['id_user'].toString()),
      id_wallet: transaction.first['id_wallet'].toString(),
      transaction_type:
          int.parse(transaction.first['transaction_type'].toString()),
      create_up: transaction.first['create_up'].toString(),
      upload_up: transaction.first['upload_up'].toString(),
    );
  }

  Future<void> delete(String id) async {
    await db.delete("transactions", where: "id=?", whereArgs: [id]);
  }

  Future<void> deleteAllTransactions(String id_wallet) async {
    await db
        .delete("transactions", where: "id_wallet=?", whereArgs: [id_wallet]);
  }
}
