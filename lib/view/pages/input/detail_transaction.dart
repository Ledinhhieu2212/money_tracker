import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';
import 'package:money_tracker/view/widgets/flash_message.dart';
import 'package:money_tracker/view/widgets/list_wallet.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/view/widgets/text_field.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/services/transaction_service.dart';

class DetailTransaction extends StatefulWidget {
  final String transactionid;
  final Wallet wallet;
  const DetailTransaction(
      {super.key, required this.transactionid, required this.wallet});

  @override
  State<DetailTransaction> createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  int _currentIndex = 0;
  late TransactionService service;
  late Transaction transaction;
  late Wallet newWallet = widget.wallet;
  List<Wallet> wallets = [];
  List<Transaction> transactions = [];
  late WalletService walletService;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _description = TextEditingController();
  connectDatabase() async {
    service = TransactionService(await getDatabase());
    walletService = WalletService(await getDatabaseWallet());
    Transaction p = await service.getById(widget.transactionid);
    List<Transaction> date2 =
        await service.searchOfUser(userId: widget.wallet.id_user);
    var data = await walletService.searchWallets(widget.wallet.id_user);
    setState(
      () {
        wallets = data;
        transaction = p;
        transactions = date2;
        newWallet = widget.wallet;
        _date.text = p.dateTime;
        _price.text = formatMoney(p.money.toDouble());
        _description.text = p.description;
        _currentIndex = p.transaction_type;
      },
    );
  }

  void _showIconSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ListWallet(
          wallets: wallets,
          service: walletService,
          onIconSelected: (value) {
            setState(() {
              newWallet = value;
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    connectDatabase();
    super.initState();
  }

  void showConfirm(
      BuildContext context, String transactionid, Wallet walletOld) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xóa giao dịch?'),
          content: const Text('Bạn có muốn xóa giao dịch này không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () {
                int total = transaction.transaction_type == 1
                    ? walletOld.total - transaction.money
                    : walletOld.total + transaction.money;
                service.delete(transactionid);
                walletService.updateTotal(
                    walletID: walletOld.id_wallet!, price: total);
                buildSuccessMessage(
                  "Thành công!",
                  "Xóa thành công",
                  context,
                );
                getOffAllPage(
                  page: () => const NavigationMenu(),
                );
              },
              child: const Text('Có'),
            ),
          ],
        );
      },
    );
  }

  void updateWallet({
    required Wallet oldWallet,
    required Wallet newWallet,
  }) {
    if (oldWallet.id_wallet == newWallet.id_wallet) {
      int total = 0;
      if (transaction.transaction_type == 1) {
        // Cộng nhân 2  tiền cũ
        total = oldWallet.total +
            (int.parse(removeCurrencySeparator(_price.text)) * 2);
      } else {
        // Trừ nhân 2  tiền cũ
        total = oldWallet.total -
            (int.parse(removeCurrencySeparator(_price.text)) * 2);
      }
      walletService.updateTotal(walletID: oldWallet.id_wallet!, price: total);
    } else {
      int totalAdd = transaction.transaction_type == 1
          ? newWallet.total + transaction.money
          : newWallet.total - transaction.money;
      walletService.updateTotal(
          walletID: newWallet.id_wallet!, price: totalAdd);

      int totalChange = transaction.transaction_type == 1
          ? oldWallet.total - transaction.money
          : oldWallet.total + transaction.money;
      walletService.updateTotal(
          walletID: oldWallet.id_wallet!, price: totalChange);
    }
  }

  bool isAnyFieldEmpty() {
    return _price.text.isEmpty || _date.text.isEmpty;
  }

  void updateTransaction() {
    DateTime now = DateTime.now();
    service.update(
      Transaction(
        id: transaction.id,
        id_user: transaction.id_user,
        dateTime: transaction.dateTime,
        id_wallet: newWallet.id_wallet!,
        money: transaction.money,
        description: _description.text,
        transaction_type: _currentIndex,
        create_up: transaction.create_up,
        upload_up: removeTimeDate(now).toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(grey),
      appBar: AppBar(
        title: const Text(
          "Chi tiết giao dịch",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Số tiền"),
                      textFormFieldCreateMoney(
                        controller: _price,
                        color: _currentIndex == 0 ? Colors.red : Colors.green,
                        isEnabled: false,
                      ),
                    ],
                  ),
                ),
                // ToggleSwitch(
                //   fontSize: 20,
                //   minWidth: 200,
                //   minHeight: 50,
                //   totalSwitches: 2,
                //   cornerRadius: 10,
                //   inactiveFgColor: Colors.white,
                //   initialLabelIndex: _currentIndex,
                //   inactiveBgColor: Colors.black26,
                //   activeFgColor: const Color(white),
                //   activeBgColor: const [Color(blue), Color(primary)],
                //   labels: [
                //     'spending'.tr,
                //     'income'.tr,
                //   ],
                //   onToggle: (index) {
                //     setState(() {
                //       _currentIndex = index!;
                //     });
                //   },
                // ),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(white),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text("Loại giao dịch:"),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: _currentIndex == 0
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  _currentIndex == 0 ? "Chi tiêu" : "Thu nhập",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70,
                        child: TextField(
                          enabled: false,
                          readOnly: true,
                          controller: _date,
                          decoration: const InputDecoration(
                            labelText: 'Ngày',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        child: TextField(
                          controller: _description,
                          decoration: InputDecoration(
                            labelText: "description".tr,
                            prefixIcon: const Icon(Icons.article),
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          _showIconSelectionDialog();
                        },
                        child: SizedBox(
                          height: 70,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: Image.asset(
                                  newWallet.icon,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Text(newWallet.name),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: getScreenWidth(context),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'Cập nhật',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(white),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (isAnyFieldEmpty()) {
                          buildErrorMessage(
                            "Lỗi",
                            "Không được để trống mục tạo!",
                            context,
                          );
                        }

                        if (!isAnyFieldEmpty()) {
                          updateTransaction();
                          updateWallet(
                            newWallet: newWallet,
                            oldWallet: widget.wallet,
                          );
                          buildSuccessMessage(
                              "Thành công!", "Sửa thành công", context);
                          getOffAllPage(page: () => const NavigationMenu());
                        }
                      } else {
                        buildWarningMessage(
                            "Lỗi!", "Không thể sửa giao dịch.", context);
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
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.delete),
                    label: const Text(
                      'Xóa',
                      style: TextStyle(
                        color: Color(white),
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      showConfirm(context, widget.transactionid, widget.wallet);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      iconColor: const Color(white),
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
      ),
    );
  }
}
