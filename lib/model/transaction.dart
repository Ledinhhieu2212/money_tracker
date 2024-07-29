 
 
class Transaction {
  int id;
  String money;
  String id_user;
  String dateTime;
  String description;
  String transaction_type;

  Transaction(
      this.id,
      this.money,
      this.id_user,
      this.dateTime,
      this.description,
      this.transaction_type);



  Map<String, Object?> toMap() {
    return {
      'id': id,
      'money': money,
      'id_user': id_user,
      'dateTime': dateTime,
      'description': description,
      'transaction_type': transaction_type,
    };
  }
}
