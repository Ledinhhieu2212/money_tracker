import 'package:flutter/material.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/wallet_service.dart';

class ListWallet extends StatelessWidget {
  final List<Wallet> wallets;
  final WalletService service;
  final ValueChanged<Wallet> onIconSelected;
  const ListWallet(
      {super.key,
      required this.wallets,
      required this.service,
      required this.onIconSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 300,
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: wallets.length,
          itemBuilder: (context, index) {
            final wallet = wallets[index];
            return GestureDetector(
              onTap: () {
                onIconSelected(wallet);
                Navigator.of(context).pop();
              },
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Image.asset(
                          imageBase().getIconWallets()[wallets[index].icon],
                          width: 26,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          wallets[index].description,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
