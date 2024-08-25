import 'package:uuid/uuid.dart';

class Wallet {
  String? id_wallet;
  int id_user;
  int icon;
  int total;
  int money_price;
  String description;
  String create_up;
  String upload_up;

  Wallet({
    this.id_wallet,
    required this.icon,
    required this.total,
    required this.id_user,
    required this.money_price,
    required this.description,
    required this.create_up,
    required this.upload_up,
  });

  Map<String, Object?> toMap() {
    var uuid = const Uuid();
    return {
      'icon': icon,
      'total': total,
      'id_user': id_user,
      'id_wallet': uuid.v4(),
      'money_price': money_price,
      'description': description,
      "create_up": create_up,
      "upload_up": upload_up,
    };
  }

  Map<String, Object?> toMapUpdate() { 
    return {
      'icon': icon,
      'total': total,
      'id_user': id_user,
      'id_wallet': id_wallet,
      'money_price': money_price,
      'description': description,
      "create_up": create_up,
      "upload_up": upload_up,
    };
  }
}
