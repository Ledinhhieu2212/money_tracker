import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/constants/font_size.dart';
import 'package:money_tracker/model/transaction.dart' as tr;
import 'package:money_tracker/model/user.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/view/pages/input/detail_transaction.dart';
import 'package:money_tracker/view/widgets/notification.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TransactionService transactionService;
  late WalletService walletService;
  List<tr.Transaction> transactions = [];
  List<Wallet> wallets = [];
  User? user;
  int price = 0;
  int expense = 0;
  int income = 0;
  late List<bool> _expandedState;
  loadUser() async {
    UserPreference userPreference = UserPreference();
    int userId = await userPreference.getUserID();
    User u = await userPreference.getUser();
    await connectTransactions(userId);
    await connectWallets(userId);
    setState(() {
      user = u;
    });
  }

  connectTransactions(int userid) async {
    transactionService = TransactionService(await getDatabase());
    var data = await transactionService.searchOfUser(userId: userid);

    setState(() {
      transactions = data;
      for (final i in data) {
        if (i.transaction_type == 1) {
          income += i.money;
        } else {
          expense += i.money;
        }
      }
      price = income - expense;
    });
  }

  connectWallets(int userid) async {
    walletService = WalletService(await getDatabaseWallet());
    var data = await walletService.searchWallets(userid);
    setState(() {
      wallets = data;
      _expandedState = List<bool>.filled(data.length, false);
    });
  }

  bool _obscureText = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      loadUser();
    });
  }

  Widget buildTextTotalPrice() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: RichText(
        text: TextSpan(
          text: _obscureText ? "${formatMoney(price.toDouble())} " : "***000 ",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Color(primary), fontSize: 30),
          children: <TextSpan>[
            TextSpan(
              text: 'icon_currency'.tr,
              style: const TextStyle(
                  color: Color(primary),
                  fontSize: 30,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buitlTextSpending() {
    return RichText(
      text: TextSpan(
        text:
            "${'spending'.tr}: ${_obscureText ? '${formatMoney(expense.toDouble())} ' : "***000 "}",
        style: const TextStyle(color: Colors.red),
        children:  [
          TextSpan(
            text: 'icon_currency'.tr,
            style: const TextStyle(
              color: Colors.red,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget buitlTextComein() {
    return RichText(
      text: TextSpan(
        text:
            "${'income'.tr}: ${_obscureText ? '${formatMoney(income.toDouble())} ' : "***000 "}",
        style: const TextStyle(color: Colors.green),
        children: [
          TextSpan(
            text:'icon_currency'.tr,
            style: const TextStyle(
              color: Colors.green,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVisibilityButton() {
    return Column(
      children: [
        IconButton(
          padding: const EdgeInsets.all(8.0),
          enableFeedback: false,
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ],
    );
  }

  Widget _buildContainterPrice({
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(white),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextTotalPrice(),
              buitlTextSpending(),
              buitlTextComein(),
            ],
          ),
          buildVisibilityButton(),
        ],
      ),
    );
  }

  Widget usernameTitleAppbar() {
    return Text(
      '${'hello'.tr} ${user!.username ?? ''}!',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget getSelectWalletToggleTransaction(
      bool isExpanded, List<tr.Transaction> fillTranssaction, Wallet wl) {
    if (isExpanded) {
      return fillTranssaction.isEmpty
          ? Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: const Center(
                child: Text("Chưa có giao dịch trong ví!"),
              ),
            )
          : Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: fillTranssaction.length,
                  itemBuilder: (context, index) {
                    Text text = fillTranssaction[index].transaction_type == 1
                        ? Text(
                            "+${formatMoney(fillTranssaction[index].money.toDouble())}${'icon_currency'.tr}",
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "-${formatMoney(fillTranssaction[index].money.toDouble())}${'icon_currency'.tr}",
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          );
                    Color color = fillTranssaction[index].transaction_type == 1
                        ? Colors.green
                        : Colors.red;
                    return MaterialButton(
                      onPressed: () {
                        getToPage(
                            page: () => DetailTransaction(
                                transactionid: fillTranssaction[index].id!,
                                wallet: wl));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: CircleAvatar(
                                backgroundColor: color,
                                child: const Icon(
                                  Icons.attach_money,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: text,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
    } else {
      return const SizedBox(height: 2);
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return user != null
        ? Scaffold(
            backgroundColor: const Color(grey),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: usernameTitleAppbar(),
              actions: [
                IconButton(
                  onPressed: () {
                    getToPage(page: () => const NotificationPage());
                  },
                  icon: const Icon(Icons.notifications),
                )
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(110.0),
                child: _buildContainterPrice(context: context),
              ),
            ),
            body: wallets.isEmpty
                ? Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: const Center(child: Text("Chưa ví được tạo!")),
                  )
                : Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: wallets.length,
                            itemBuilder: (context, index) {
                              List<tr.Transaction> fillTranssaction =
                                  transactions
                                      .where((element) =>
                                          element.id_wallet ==
                                          wallets[index].id_wallet)
                                      .toList();
                              bool isExpanded = _expandedState[index];
                              return Column(
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        _expandedState[index] = !isExpanded;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      width: double.infinity,
                                      color: Colors.white,
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Image.asset(
                                              wallets[index].icon,
                                              width: 40,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Icon(
                                              isExpanded
                                                  ? Icons.expand_less
                                                  : Icons.expand_more,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  getSelectWalletToggleTransaction(
                                    isExpanded,
                                    fillTranssaction,
                                    wallets[index],
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
