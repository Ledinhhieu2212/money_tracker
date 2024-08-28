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

  List<Map<String, String>> getIconWallets() {
    return [
      {'icon': wallet, 'name': "Ví tiết kiệm"},
      {'icon': food,  'name': "Đồ ăn chay"},
      {'icon': breakfast,  'name': "Ăn sáng"},
      {'icon': coffee,  'name': "Cà phê"}, 
      {'icon': house,  'name': "Nhà"},
      {'icon': clothes,  'name': "Quần áo"},
      {'icon': game,  'name': "Game"},
    ];
  }
}
