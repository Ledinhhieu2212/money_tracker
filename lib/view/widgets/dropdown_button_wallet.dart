import 'package:flutter/material.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/model/wallet.dart';

class MyWidget extends StatelessWidget {
  final Wallet wallet;
  final List<Transaction> transactions;
  final ValueChanged<Wallet> onSelected;
  const MyWidget(
      {super.key,
      required this.wallet,
      required this.transactions,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
