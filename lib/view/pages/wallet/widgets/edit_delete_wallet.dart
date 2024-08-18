import 'package:get/get.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:money_tracker/view/widgets/Icon_selection_dialog.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/view/widgets/config.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/view/widgets/text_field.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/view/widgets/flash_message.dart';
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
  int? userID;
  late WalletService service;
  int selectedIcon = 0;
  List<Transaction> transactions = [];
  late TransactionService transactionService;
  int incomePrice = 0, spendingPrice = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _wallet = TextEditingController();
  final TextEditingController _money = TextEditingController();
  connectDatabase() async {
    service = WalletService(await getDatabaseWallet());
    transactionService = TransactionService(await getDatabase());
    Wallet p = await service.getById(widget.idWallet);
    int income = await transactionService.totalPriceWalletType(
        userId: p.id_user, typePrice: 1, walletID: p.id_wallet);
    int spending = await transactionService.totalPriceWalletType(
        userId: p.id_user, typePrice: 0, walletID: p.id_wallet);
    setState(() {
      userID = p.id_user;
      incomePrice = income;
      spendingPrice = spending;
      _money.text = p.money_price.toString();
      _wallet.text = p.description;
      selectedIcon = p.icon;
    });
  }

  @override
  void initState() {
    connectDatabase();
    super.initState();
  }

  void _showIconSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return IconSelectionDialog(
          icons: imageBase().getIconWallets(),
          onIconSelected: (icon) {
            setState(() {
              selectedIcon = icon;
            });
          },
        );
      },
    );
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
                      GetOffAllPage(
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
                        _showIconSelectionDialog();
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                                imageBase().getIconWallets()[selectedIcon]),
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
                      service.update(
                        Wallet(
                          icon: selectedIcon,
                          description: _wallet.text,
                          id_user: userID ?? 0,
                          id_wallet: widget.idWallet,
                          total: int.parse(_money.text) +
                              incomePrice -
                              spendingPrice,
                          money_price: int.parse(_money.text),
                        ),
                      );
                      buildSuccessMessage(
                          "Thành công!", "Sửa thành công", context);
                      GetOffAllPage(
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
