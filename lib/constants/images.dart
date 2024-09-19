import 'dart:math';


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
      {'icon': "assets/image/iconWallets/water-tap.png", "name": "Điện nước "},
      {'icon': "assets/image/iconWallets/wallet.png", "name": "Ví điện tử"},
      {'icon': "assets/image/iconWallets/shirt.png", "name": "Quần áo"},
      {'icon': "assets/image/iconWallets/money123.png", "name": "Tiền mặt "},
      {'icon': "assets/image/iconWallets/house.png", "name": "Nhà"},
      {
        'icon': "assets/image/iconWallets/game-controller.png",
        "name": "Giải trí"
      },
      {'icon': "assets/image/iconWallets/food.png", "name": "Đồ ăn"},
      {'icon': "assets/image/iconWallets/coffee.png", "name": "Cà phê"},
      {'icon': "assets/image/iconWallets/card-bank.png", "name": "Thẻ tín dụng "},
      {'icon': "assets/image/iconWallets/car21.png", "name": "Ô tô"},
    ];
  }

  Map<String, String> getRandomIconWallet() {
    List<Map<String, String>> iconWallets = getIconWallets();
    Random random = Random();
    return iconWallets[random.nextInt(iconWallets.length)];
  }

  List<String> getWallets() {
    return [
      "assets/image/iconWallets/water-tap.png",
      "assets/image/iconWallets/wallet.png",
      "assets/image/iconWallets/shirt.png",
      "assets/image/iconWallets/money123.png",
      "assets/image/iconWallets/male-clothes.png",
      "assets/image/iconWallets/house.png",
      "assets/image/iconWallets/game-controller.png",
      "assets/image/iconWallets/food.png",
      "assets/image/iconWallets/coffee.png",
      "assets/image/iconWallets/card-bank.png",
      "assets/image/iconWallets/car21.png",
      "assets/image/iconWallets/breakfast.png",
    ];
  }
}
