import 'dart:math';

import 'package:get/get.dart';

class imageBase {
  String Logo = 'assets/image/Animation.json';
  String wallet = "assets/image/iconWallets/wallet.png";
  String usa = "assets/image/Usa.png";
  String vietname = "assets/image/Vietnam.png";
  String internet = "assets/image/internet.png";
  String food = "assets/image/iconWallets/food.png";
  String coffee = "assets/image/iconWallets/coffee.png";
  String breakfast = "assets/image/iconWallets/breakfast.png";
  String house = "assets/image/iconWallets/house.png";
  String game = "assets/image/iconWallets/game-controller.png";
  String clothes = "assets/image/iconWallets/male-clothes.png";
  String success = "assets/image/success.svg";
  String iconSuccess = "assets/image/successgreen.svg";
  String iconFail = "assets/image/failred.svg";
  String fail = "assets/image/fail.svg";
  String warning = "assets/image/warning.svg";
  String iconWarning = "assets/image/warningOrange.svg";
  String cardBank = "assets/image/iconWallets/card-bank.png";
  String money = "assets/image/iconWallets/money123.png";
  String car = "assets/image/iconWallets/car21.png"; 

  List<Map<String, String>> getIconWallets() {
    return [
      {'icon': wallet, 'name': "select_wallet_1".tr},
      {'icon': money, 'name': "select_wallet_2".tr},
      {'icon': cardBank, 'name': "select_wallet_3".tr},
      {'icon': house, 'name': "select_wallet_4".tr},
      {'icon': car, 'name': "select_wallet_5".tr},
      {'icon': game, 'name': "select_wallet_6".tr},
    ];
  }

  Map<String, String> getRandomIconWallet() {
    List<Map<String, String>> iconWallets = getIconWallets();
    Random random = Random();
    return iconWallets[random.nextInt(iconWallets.length)];
  }
}
