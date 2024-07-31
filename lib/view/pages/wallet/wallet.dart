import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/widgets/config.dart';
import 'package:money_tracker/view/pages/wallet/component/create_wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double price = 0;
  final styleText = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  void _loadingHome() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    price = double.parse(preferences.getString('so_du')!);
    setState(() {});
  }

  Widget _totalAmount() {
    return Container(
      height: 50,
      color: const Color(white),
      width: getScreenWidth(context),
      child: Center(
        child: RichText(
          text: TextSpan(
              text: "Tổng tiền: $price",
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              children: const [
                TextSpan(
                  text: "đ",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _totalAmountDetails() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: const Color(white),
      width: getScreenWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Đang sử dụng (0 đ)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Transform.rotate(
            angle: 90 * 3.1415926535897932 / 180,
            child: const Icon(
              Icons.chevron_left,
              size: 25,
              color: Colors.grey,
            ),
          ),
        ],
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
          title: const Center(
            child: Text(
              "Thông tin ví",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        body: Container(
          color: const Color(grey),
          child: Column(
            children: [
              _totalAmount(),
              _totalAmountDetails(),
              MaterialButton(
                onPressed: () {},
                color: const Color(white),
                padding: const EdgeInsets.all(
                  10,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Image.asset(
                        imageBase().wallet,
                        width: 26,
                      ),
                    ),
                    const Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text("Ví tiền mặt"),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {},
                color: const Color(white),
                padding: const EdgeInsets.all(
                  10,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Image.asset(
                        imageBase().wallet,
                        width: 26,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(blue),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          tooltip: 'Increment',
          onPressed: () => GetToPage(page: const CreateWallet()),
          child: const Icon(
            Icons.add,
            color: Color(white),
            size: 30,
          ),
        ),
      ),
    );
  }
}
