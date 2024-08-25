 import 'package:uuid/uuid.dart'; 

class Transaction {
  String? id;
  int money;
  int id_user;
  String id_wallet;
  String dateTime;
  String description;
  int transaction_type;
  String create_up; 
  String upload_up;

  Transaction({
     this.id,
    required this.money,
    required this.id_wallet,
    required this.id_user,
    required this.dateTime,
    required this.description,
    required this.transaction_type,
    required this.create_up,
    required this.upload_up,
  });
 Map<String, Object?> toMapUpload() { 
    return {
      'id': id,
      'money': money,
      'id_user': id_user,
      'dateTime': dateTime,
      'id_wallet': id_wallet,
      'description': description,
      'transaction_type': transaction_type,
      "create_up": create_up,
      "upload_up": upload_up,
    };
  }
  Map<String, Object?> toMapInsert() { 
    var uuid = const Uuid();
    return {
      'id': uuid.v4(),
      'money': money,
      'id_user': id_user,
      'dateTime': dateTime,
      'id_wallet': id_wallet,
      'description': description,
      'transaction_type': transaction_type,
      "create_up": create_up,
      "upload_up": upload_up,
    };
  }
}
