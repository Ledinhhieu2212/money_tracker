import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/widgets/config.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/widgets/text_field.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/widgets/flash_message.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';

class EditDeleteWallet extends StatefulWidget {
  final int idWallet;
  const EditDeleteWallet({super.key, required this.idWallet});

  @override
  State<EditDeleteWallet> createState() => _EditDeleteWalletState();
}

class _EditDeleteWalletState extends State<EditDeleteWallet> {
  var uuid = Uuid();
  String userID = '';
  late WalletService service;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _wallet = TextEditingController();
  final TextEditingController _money = TextEditingController();
  connectDatabase() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userID = preferences.getString('ma_nguoi_dung')!;
    service = WalletService(await getDatabase());
    Wallet p = await service.getById(widget.idWallet);
    setState(() {
      _money.text = p.money_price.toString();
      _wallet.text = p.description;
    });
  }

  @override
  void initState() {
    connectDatabase();
    super.initState();
  }

  void showConfirm(BuildContext context, int transactionid) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Xóa ví?'),
              content: const Text('Bạn có muốn xóa ví này không?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Không')),
                TextButton(
                    onPressed: () {
                      service.delete(transactionid);
                      buildSuccessMessage(
                          "Thành công!", "Xóa thành công", context);
                      GetToPage(
                        page: () => const NavigationMenu(
                          routerNavigationMenu: 1,
                        ),
                      );
                    },
                    child: const Text('Có')),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết thông tin ví",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(grey),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Số dư ban đầu"),
                    textFormFieldCreateMoney(
                      controller: _money,
                      color: const Color(primary),
                      error: "Không nhập tiền giao dịch",
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: CircleAvatar(
                              backgroundColor: Colors.lightBlue[900],
                              child: Image.asset(
                                imageBase().food,
                                width: 20,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 7,
                            child: TextField(
                              controller: _wallet,
                              decoration: const InputDecoration(
                                labelText: "Tên ví",
                                // prefixIcon:
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      onPressed: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            child: Image.asset(imageBase().wallet),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 18.0),
                            child: Text("Biểu tượng"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: getScreenWidth(context),
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Cập nhật',
                    style: TextStyle(color: Color(white), fontSize: 20),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      service.update(Wallet(
                        widget.idWallet,
                        int.parse(userID),
                        'abc',
                        int.parse(_money.text),
                        _wallet.text,
                      ));
                      buildSuccessMessage(
                          "Thành công!", "Sửa thành công", context);
                      GetToPage(
                        page: () => const NavigationMenu(
                          routerNavigationMenu: 1,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    iconColor: const Color(white),
                    backgroundColor: const Color(blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: getScreenWidth(context),
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text(
                    'Xóa',
                    style: TextStyle(color: Color(white), fontSize: 20),
                  ),
                  onPressed: () {
                    showConfirm(context, widget.idWallet);
                  },
                  style: ElevatedButton.styleFrom(
                    iconColor: const Color(white),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
