import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/view/pages/wallet/widgets/edit_delete_wallet.dart';
import 'package:money_tracker/view/pages/wallet/widgets/create_wallet.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int money = 0;
  double price = 0.0;
  String name = '';
  late WalletService service;
  List<Wallet> wallet = [];
  final styleText = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  loadUser() async {
    UserPreference userPreference = UserPreference();
    int user_id = await userPreference.getUserID();
    await _loadingHome(user_id);
  }

  _loadingHome(int userId) async {
    service = WalletService(await getDatabaseWallet());
    List<Wallet> data = await service.searchWallets(userId);
    setState(() {
      wallet = data ;
      for (final t in wallet) {
        price += double.parse(t.total.toString());
      }
    });
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  Widget _totalAmount() {
    return Container(
      height: 50,
      color: const Color(white),
      width: getScreenWidth(context),
      child: Center(
        child: RichText(
          text: TextSpan(
              text: "${'lable_wallet_total'.tr}: ${formatMoney(price)} ",
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              children:  [
                TextSpan(
                  text: "icon_currency".tr,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _buildListWallet() {
    return wallet.isEmpty
        ? const Center(child: Text("Chưa có thông tin giao dịch!"))
        : Expanded(
            child: ListView.builder(
              itemCount: wallet.length,
              itemBuilder: (context, index) {
                TextStyle style_text = TextStyle(
                  color: wallet[index].total >= 0 ? Colors.green : Colors.red,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                );
                return GestureDetector(
                  onTap: () => {
                    getToPage(
                      page: () => EditDeleteWallet(
                        idWallet: wallet[index].id_wallet!,
                      ),
                    ),
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                              wallet[index].icon,
                              width: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  wallet[index].name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                    "${formatMoney(wallet[index].total.toDouble())} ${'icon_currency'.tr}",
                                    style: style_text),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:  Text(
            "title_navigation_1".tr,
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              child: const Icon(
                Icons.add_circle_outlined,
                color: Color(white),
                size: 30,
              ),
              onPressed: () {
                getToPage(page: () => const CreateWallet());
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: _totalAmount(),
          ),
        ),
        body: Container(
          color: const Color(grey),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildListWallet(),
            ],
          ),
        ),
        
      ),
    );
  }
}
