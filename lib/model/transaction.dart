class Transaction {
  int id;
  int money;
  int id_user;
  int id_wallet;
  String dateTime;
  String description;
  int transaction_type;

  Transaction({
    required this.id,
    required this.money,
    required this.id_wallet,
    required this.id_user,
    required this.dateTime,
    required this.description,
    required this.transaction_type,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'money': money,
      'id_user': id_user,
      'dateTime': dateTime,
      'id_wallet': id_wallet,
      'description': description,
      'transaction_type': transaction_type,
    };
  }
}
