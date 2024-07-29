import 'package:money_tracker/view/components/detail_transaction.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:money_tracker/view/components/notification.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final SharedPreferences preferences;
  const HomeScreen({super.key, required this.preferences});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';
  double price = 0.00;
  double incomePrice = 0.00;
  double spendingPrice = 0.00;
  List<Transaction> transactions = [];
  late TransactionService service;
  getTransactions() async {
    service = TransactionService(await getDatabase());
    String id = widget.preferences.getString('ma_nguoi_dung')!;
    var data = await service.searchOfUser(id);
    incomePrice = await service.totalPriceInCome(id);
    spendingPrice = await service.totalPriceSpending(id);
    setState(() {
      transactions = data;
      for (final t in transactions) {
        price += double.parse(t.money);
      }
    });
  }

  var _obscureText;
  @override
  void initState() {
    _loadingHome();
    getTransactions();
    super.initState();
    _obscureText = false;
  }

  void _loadingHome() {
    username = widget.preferences.getString('ten_nguoi_dung')!;
    setState(() {});
  }

  Widget buildTextTotalPrice() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: RichText(
        text: TextSpan(
          text: _obscureText ? "$price" : "***000 ",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Color(primary), fontSize: 30),
          children: const <TextSpan>[
            TextSpan(
              text: 'đ',
              style: TextStyle(
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
              "${'spending'.tr}: ${_obscureText ? '$spendingPrice ' : "***000 "}",
          style: const TextStyle(color: Colors.red),
          children: const [
            TextSpan(
              text: 'đ',
              style: TextStyle(
                color: Colors.red,
                decoration: TextDecoration.underline,
              ),
            ),
          ]),
    );
  }

  Widget buitlTextComein() {
    return RichText(
      text: TextSpan(
        text: "${'income'.tr}: ${_obscureText ? '$incomePrice ' : "***000 "}",
        style: const TextStyle(color: Colors.green),
        children: const [
          TextSpan(
            text: 'đ',
            style: TextStyle(
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
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off)),
      ],
    );
  }

  Widget _buildContainterPrice({
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => Get.to(const NotificationPage()),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(white), // Màu nền của Container
          borderRadius:
              BorderRadius.circular(12.0), // Bo tròn góc của Container
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextTotalPrice(),
                buitlTextSpending(),
                buitlTextComein(),
              ],
            ),
            buildVisibilityButton()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: linearGradient(),
        automaticallyImplyLeading: false,
        title: Text(
          '${'hello'.tr} $username!',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cached),
          ),
          IconButton(
            onPressed: () {
              GetToPage(page: const NotificationPage());
            },
            icon: const Icon(Icons.notifications),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: _buildContainterPrice(context: context),
        ),
      ),
      body: transactions.isEmpty
          ? Container(
            child: Center(child: Text("Chưa có thông tin giao dịch!")),
          )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => GetToPage(
                    page: DetailTransaction(
                        transactionid: transactions[index].id),
                  ),
                  child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      transactions[index].transaction_type ==
                                              '0'
                                          ? Colors.red
                                          : Colors.green,
                                  child: const FaIcon(
                                    FontAwesomeIcons.dollarSign,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    transactions[index].description,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${transactions[index].transaction_type == '0' ? '- ' : '+ '}${transactions[index].money}đ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: transactions[index].transaction_type ==
                                          '0'
                                      ? Colors.red
                                      : Colors.green),
                            )
                          ],
                        ),
                      )),
                );
              },
            ),
    );
  }
}
