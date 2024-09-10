import 'package:uuid/uuid.dart';

class Wallet {
  String? id_wallet;
  int id_user;
  int total;
  String icon;
  String name;
  String description;
  int status;
  String create_up;
  String upload_up;

  Wallet({
    this.id_wallet,
    required this.icon,
    required this.name,
    required this.total,
    required this.id_user,
    required this.description,
    required this.status,
    required this.create_up,
    required this.upload_up,
  });

  Map<String, Object?> toMap() {
    var uuid = const Uuid();
    return {
      'icon': icon,
      'total': total,
      'name': name,
      'id_user': id_user,
      'id_wallet': uuid.v4(),
      'description': description,
      'status': status,
      "create_up": create_up,
      "upload_up": upload_up,
    };
  }

  Map<String, Object?> toMapUpdate() {
    return {
      'icon': icon,
      'total': total,
      'name': name,
      'id_user': id_user,
      'id_wallet': id_wallet,
      'description': description,
      'status': status,
      "create_up": create_up,
      "upload_up": upload_up,
    };
  }
}
