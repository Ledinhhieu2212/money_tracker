import 'dart:async';
import 'dart:math';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:money_tracker/model/transaction.dart' as model_Transaction;
import 'package:uuid/uuid.dart';

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
  Future<void> insert(model_Transaction.Transaction p) async {
    db.insert("transactions", p.toMapInsert(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(model_Transaction.Transaction p) async {
    db.update("transactions", p.toMapUpload(),
        where: "id=?", whereArgs: [p.id]);
  }

  List<model_Transaction.Transaction> getTransactionData(
      List<Map<String, Object?>> transactions) {
    List<model_Transaction.Transaction> transactionList = [];
    for (final Map<String, Object?> transactionData in transactions) {
      model_Transaction.Transaction transactionItem =
          model_Transaction.Transaction(
              id: transactionData['id'] as String,
              money: transactionData['money'] as int,
              id_user: transactionData['id_user'] as int,
              id_wallet: transactionData['id_wallet'] as String,
              dateTime: transactionData['dateTime'] as String,
              description: transactionData['description'] as String,
              transaction_type: transactionData['transaction_type'] as int,
              create_up: transactionData['create_up'] as String,
              upload_up: transactionData['upload_up'] as String);
      transactionList.add(transactionItem);
    }
    return transactionList;
  }

  Future<List<model_Transaction.Transaction>> getAll() async {
    final List<Map<String, Object?>> transactions =
        await db.query("transactions", orderBy: 'create_up DESC');
    return getTransactionData(transactions);
  }

  fakeTransaction(
      {required int userId,
      required int sl,
      required List<Wallet> wls,
      required WalletService ws}) {
    deleteOfUser(userId);
    int length = wls.length;
    for (int i = 1; i <= sl; i++) {
      //ranbom wallet
      Wallet wl = wls[Random().nextInt(length)];
      int type = Random().nextInt(2);
      int money = Random().nextInt(1000001);
      DateTime date = generateRandomDateTime();
      String text = generateRandomString(20);
      insert(
        model_Transaction.Transaction(
          id: const Uuid().v4(),
          money: money,
          id_wallet: wl.id_wallet!,
          id_user: userId,
          dateTime: FormatDateVi(date),
          description: text,
          transaction_type: type,
          create_up: date.toString(),
          upload_up: date.toString(),
        ),
      );
    }

    for (var wl in wls) {
      voidTotalWallet(userId, wl, ws);
    }
    // ws.deleteAllwallets(wls.first.id_user);
  }

  Future<void> voidTotalWallet(int userId, Wallet wl, WalletService ws) async {
    var data =
        await searchOfUserAndWallets(userId: userId, id_wallet: wl.id_wallet!);
    int total = 0;
    int income = 0;
    int expense = 0;
    for (final d in data) {
      if (d.transaction_type == 1) {
        income += d.money;
      } else {
        expense += d.money;
      }
    }
    total = income - expense;
    ws.updateTotal(
      walletID: wl.id_wallet!,
      price: total,
    );
  }

  Future<List<model_Transaction.Transaction>> search(
      {required String transactionID}) async {
    final List<Map<String, Object?>> transactions = await db
        .query("transactions", where: "id=?", whereArgs: [transactionID]);
    return getTransactionData(transactions);
  }

  Future<List<model_Transaction.Transaction>> searchOfUser(
      {required int userId}) async {
    final List<Map<String, Object?>> transactions = await db.query(
        "transactions",
        where: "id_user=?",
        whereArgs: [userId],
        orderBy: 'create_up DESC');
    return getTransactionData(transactions);
  }

  Future<List<model_Transaction.Transaction>> searchOfUserAndWallets(
      {required int userId, required String id_wallet}) async {
    final List<Map<String, Object?>> transactions = await db.query(
        "transactions",
        where: "id_user=? AND id_wallet=?",
        whereArgs: [userId, id_wallet],
        orderBy: 'create_up DESC');
    return getTransactionData(transactions);
  }

  Future<model_Transaction.Transaction> getById(String id) async {
    final List<Map<String, Object?>> transaction =
        await db.query("transactions", where: 'id=?', whereArgs: [id]);
    return model_Transaction.Transaction(
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

  Future<void> deleteOfUser(int id) async {
    await db.delete("transactions", where: "id_user=?", whereArgs: [id]);
  }
}
