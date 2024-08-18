class Wallet {
  int icon;
  int total;
  int id_user;
  int id_wallet;
  int money_price;
  String description;
  // final String? currency;

  Wallet({
    required this.icon,
    required this.total,
    required this.id_user,
    required this.id_wallet,
    required this.money_price,
    required this.description,
  });

  Map<String, Object?> toMap() {
    return {
      'icon': icon,
      'total': total,
      'id_user': id_user,
      'id_wallet': id_wallet,
      'money_price': money_price,
      'description': description,
    };
  }
}
