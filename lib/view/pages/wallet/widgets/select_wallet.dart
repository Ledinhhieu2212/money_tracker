import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/user.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';
import 'package:get/get.dart';

class SelectWallet extends StatefulWidget {
  final Function(List<Wallet>, int) setChecked;
  const SelectWallet({
    super.key,
    required this.setChecked,
  });

  @override
  State<SelectWallet> createState() => _SelectWalletState();
}

class _SelectWalletState extends State<SelectWallet> {
  List<bool> isCheckedList = [];
  int? userId;
  List<Wallet> wallets = [];
  late WalletService walletService;
  loadUser() async {
    UserPreference userPreference = UserPreference();
    userId = await userPreference.getUserID();
    await connectWallets(userId!);
  }

  connectWallets(int userid) async {
    walletService = WalletService(await getDatabaseWallet());
    var data = await walletService.searchWallets(userid);
    setState(() {
      wallets = data;
      isCheckedList = List<bool>.filled(wallets.length, false);
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

// Hàm cập nhật trạng thái checkbox
  void _onCheckboxChanged(bool? value, int index) {
    setState(() {
      isCheckedList[index] = value ?? false;
    });
  }

// Hàm này sẽ trả về danh sách các ví đã chọn
  List<Wallet> getSelectedWallets() {
    return [
      for (int i = 0; i < wallets.length; i++)
        if (isCheckedList[i]) wallets[i]
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title_select_wallet".tr),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16),
      ),
      body: ListView.builder(
        itemCount: wallets.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            child: CheckboxListTile(
              title: Row(
                children: [
                  Expanded(flex: 1, child: Image.asset(wallets[index].icon)),
                  const SizedBox(width: 10),
                  Expanded(flex: 8, child: Text(wallets[index].name)),
                ],
              ),
              value: isCheckedList[index],
              onChanged: (value) => _onCheckboxChanged(value, index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(blue),
        onPressed: () {
          List<Wallet> selectedWallets = getSelectedWallets();

          widget.setChecked(selectedWallets, userId!);
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
