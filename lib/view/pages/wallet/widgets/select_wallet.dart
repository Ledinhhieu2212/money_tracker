import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';
import 'package:get/get.dart';

class SelectWallet extends StatefulWidget {
  const SelectWallet({
    super.key,
  });

  @override
  State<SelectWallet> createState() => _SelectWalletState();
}

class _SelectWalletState extends State<SelectWallet> {
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
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  //Hàm để lấy danh sách các item không được chọn (status == 0)
  List<Wallet> getItemsWallet(int status) {
    List<Wallet> unselectedItems = [];
    for (int i = 0; i < wallets.length; i++) {
      if (wallets[i].status == status) {
        unselectedItems.add(wallets[i]);
      }
    }
    return unselectedItems;
  }

  // Lấy hàm callback từ trang A
  final Function? callback = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              getToPage(page: () => const NavigationMenu());
            },
            icon: const Icon(Icons.arrow_back)),
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
              value: wallets[index].status == 1,
              onChanged: (bool? value) {
                setState(() {
                  wallets[index].status = value! ? 1 : 0;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(blue),
        onPressed: () {
          for (var wl in wallets) {
            walletService.updateStatus(
                walletID: wl.id_wallet!, status: wl.status);
          }

          getToPage(page: () => const NavigationMenu());
        },
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
