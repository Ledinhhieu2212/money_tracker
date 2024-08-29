import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:money_tracker/view/widgets/Icon_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/model/wallet.dart'; 
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/view/widgets/select_wallets.dart';
import 'package:money_tracker/view/widgets/text_field.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/view/widgets/flash_message.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';

class EditDeleteWallet extends StatefulWidget {
  final String idWallet;
  const EditDeleteWallet({super.key, required this.idWallet});

  @override
  State<EditDeleteWallet> createState() => _EditDeleteWalletState();
}

class _EditDeleteWalletState extends State<EditDeleteWallet> {
  late WalletService service;
  Wallet? wallet;
  String selectedIcon = "";
  late TransactionService transactionService; 
  List<Transaction> transactions = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _wallet = TextEditingController(); 
  connectDatabase() async {
    service = WalletService(await getDatabaseWallet());
    transactionService = TransactionService(await getDatabase());
    Wallet p = await service.getById(widget.idWallet);
    setState(() {
      wallet = p; 
      _wallet.text = p.description;
      selectedIcon = p.icon;
    });
  }

  @override
  void initState() {
    connectDatabase();
    super.initState();
  }

  void showDeleteWalletDialog({
    required BuildContext context,
    required String id_wallet,
    required WalletService ws,
    required TransactionService ts,
  }) {
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
                      ws.delete(id_wallet);
                      ts.deleteAllTransactions(id_wallet);
                      buildSuccessMessage(
                          "Thành công!", "Xóa thành công", context);
                      getOffAllPage(
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
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //   color: Colors.white,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       const Text("Số dư ban đầu"),
              //       textFormFieldCreateMoney(
              //         controller: _money,
              //         color: const Color(primary),
              //       )
              //     ],
              //   ),
              // ),
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
                      child: TextField(
                        controller: _wallet,
                        decoration: const InputDecoration(
                          labelText: "Tên ví",
                          prefixIcon: Icon(Icons.article),
                          // prefixIcon:
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      onPressed: () {
                        getToPage(
                          page: () => SelectWallets(
                            onPress: (value) {
                              setState(() {
                                wallet!.icon = value["icon"];
                                wallet!.name = value["name"];
                              });
                            },
                          ),
                        );
                      },
                      child: wallet == null
                          ? CircularProgressIndicator()
                          : Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(wallet!.icon),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Text(wallet!.name),
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
                      DateTime now = DateTime.now();
                      service.update(
                        Wallet(
                          name: wallet!.name,
                          id_wallet: wallet!.id_wallet,
                          icon: wallet!.icon,
                          description: _wallet.text,
                          id_user: wallet!.id_user,
                          total: wallet!.total, 
                          create_up: wallet!.create_up,
                          upload_up: now.toString(),
                        ),
                      );
                      buildSuccessMessage(
                          "Thành công!", "Sửa thành công", context);
                      getOffAllPage(
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
                    showDeleteWalletDialog(
                      context: context,
                      id_wallet: widget.idWallet,
                      ts: transactionService,
                      ws: service,
                    );
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
