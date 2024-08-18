class imageBase {
  String Logo = 'assets/image/Animation.json';
  String wallet = "assets/image/iconWallets/wallet.png";
  String usa = "assets/image/Usa.png";
  String vietname = "assets/image/Vietnam.png";
  String internet = "assets/image/internet.png";
  String food = "assets/image/iconWallets/food.png";
  String coffee = "assets/image/iconWallets/coffee.png";
  String breakfast = "assets/image/iconWallets/breakfast.png";
  String success = "assets/image/success.svg";
  String iconSuccess = "assets/image/successgreen.svg";
  String iconFail = "assets/image/failred.svg";
  String fail = "assets/image/fail.svg";
  String warning = "assets/image/warning.svg";
  String iconWarning = "assets/image/warningOrange.svg";

  List<String> getIconWallets() {
    return [
      wallet,
      food,
      coffee,
      breakfast,
    ];
  }
}
