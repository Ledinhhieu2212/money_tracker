import 'package:money_tracker/constants/config.dart'; 
import 'package:money_tracker/controller/homeController.dart';
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
  final HomeController h = Get.put(HomeController());
  var _obscureText;
  @override
  void initState() {
    super.initState();
    setState(() {});
    _obscureText = false;
  }

  Widget buildTextTotalPrice() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: RichText(
        text: TextSpan(
          text: _obscureText ? "${formatMoney(h.price.value.toDouble())} " : "***000 ",
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
              "${'spending'.tr}: ${_obscureText ? '${formatMoney(h.spendingPrice.value.toDouble())} ' : "***000 "}",
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
        text:
            "${'income'.tr}: ${_obscureText ? '${formatMoney(h.incomePrice.value.toDouble())} ' : "***000 "}",
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

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(grey),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(() {
          return Text(
            '${'hello'.tr} ${h.username.value}!',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              getToPage(page: () => NotificationPage());
            },
            icon: const Icon(Icons.notifications),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(110.0),
          child: _buildContainterPrice(context: context),
        ),
      ),
      body: Obx(
        () {
          if (h.wallets.isEmpty) {
            return Center(child: Text('Không có ví'));
          } else {
            return RefreshIndicator(
              onRefresh: h.refreshWallets, // Gọi phương thức làm mới ví
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: h.wallets.length,
                      itemBuilder: (context, index) {
                        var wallet = h.wallets[index];
                        var transactions = h.getTransactionsOfWallet(
                          transactions: h.transactions,
                          idWallet: h.wallets[index].id_wallet!,
                        );

                        bool isExpanded = h.expandedIndexes.contains(index);
                        return Column(
                          children: [
                            Container(
                              height: 60,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                                icon: CircleAvatar(
                                  child: Image.asset( wallet.icon),
                                ),
                                label: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        wallet.name,
                                        style: const TextStyle(
                                          color: Color(black),
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    AnimatedRotation(
                                      turns: isExpanded ? -0.25 : 0.25,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
                                    h.toggleExpanded(index);
                                  });
                                },
                              ),
                            ),
                            if (isExpanded)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: transactions.isEmpty
                                    ? Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Center(
                                            child: Text(
                                                'Không có giao dịch trong ví')))
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: transactions.length,
                                        itemBuilder:
                                            (context, transactionIndex) {
                                          var transaction =
                                              transactions[transactionIndex];

                                          bool isType = h.getTypeTransaction(
                                              transaction.transaction_type);
                                          return MaterialButton(
                                            onPressed: () {
                                              getToPage(
                                                page: () => DetailTransaction(
                                                  transactionid:
                                                      transaction.id!,
                                                  wallet: wallet,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(top: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      isType
                                                          ? const CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              child: Icon(
                                                                Icons
                                                                    .attach_money,
                                                                color: Colors
                                                                    .white,
                                                              ))
                                                          : const CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.red,
                                                              child: Icon(
                                                                Icons
                                                                    .attach_money,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15.0),
                                                          child: Text(
                                                            transaction
                                                                .description,
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  isType
                                                      ? Text(
                                                          '+${formatMoney(transaction.money.toDouble())}đ',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      : Text(
                                                          '-${formatMoney(transaction.money.toDouble())}đ',
                                                          style: const TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
