class Wallet {
  int id_wallet;
  int id_user;
  int money_price;
  String description;
  String icon;
  // final String? currency;

  Wallet(
    this.id_wallet,
    this.id_user,
    this.icon,
    this.money_price,
    this.description,
  );

  Map<String, Object?> toMap() {
    return {
      'id_wallet': id_wallet,
      'id_user': id_user,
      'icon': icon,
      'money_price': money_price,
      'description': description,
    };
  }
}
