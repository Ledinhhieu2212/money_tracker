import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart'; 
import 'package:money_tracker/view/widgets/flash_message.dart';
import 'package:money_tracker/view/widgets/list_wallet.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:money_tracker/view/widgets/config.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/view/widgets/text_field.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/services/transaction_service.dart';

class DetailTransaction extends StatefulWidget {
  final int transactionid;
  const DetailTransaction({super.key, required this.transactionid});

  @override
  State<DetailTransaction> createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  int? _currentIndex;
  int? userID;
  late TransactionService service;
  late Transaction transaction;
  List<Wallet> wallets = [];
  late Wallet oldWallet;
  Wallet? wallet;
  late WalletService walletService;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _description = TextEditingController();
  connectDatabase() async {
    service = TransactionService(await getDatabase());
    walletService = WalletService(await getDatabaseWallet());
    Transaction p = await service.getById(widget.transactionid);
    List<Wallet> dataWallets = await walletService.searchWallets(p.id_user);
    Wallet dataWallet = await walletService.getById(p.id_wallet);
    setState(
      () {
        transaction = p;
        userID = p.id_user;
        oldWallet = wallet = dataWallet;
        wallets = dataWallets;
        _date.text = p.dateTime;
        _price.text = p.money.toString();
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
              wallet = value;
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

  void showConfirm(BuildContext context, int transactionid) {
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
                    ? oldWallet.total - transaction.money
                    : oldWallet.total + transaction.money;
                service.delete(transactionid);
                walletService.updateTotal(
                    walletID: oldWallet.id_wallet, price: total);
                buildSuccessMessage(
                  "Thành công!",
                  "Xóa thành công",
                  context,
                );
                GetOffAllPage(
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

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        lastDate: DateTime(2100),
        firstDate: DateTime(2000),
        initialDate: DateTime.now(),
      );

      if (picked != null) {
        setState(
          () {
            String date = picked.toString().split(' ')[0];
            List<String> parts = date.split('-');
            String year = parts[0];
            String month = parts[1];
            String day = parts[2];
            _date.text = "$day/$month/$year";
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết giao dịch",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(grey),
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(white),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Số tiền"),
                    textFormFieldCreateMoney(
                        controller: _price,
                        color: _currentIndex == 0 ? Colors.red : Colors.green),
                  ],
                ),
              ),
              ToggleSwitch(
                fontSize: 20,
                minWidth: 200,
                minHeight: 50,
                totalSwitches: 2,
                cornerRadius: 10,
                inactiveFgColor: Colors.white,
                initialLabelIndex: _currentIndex,
                inactiveBgColor: Colors.black26,
                activeFgColor: const Color(white),
                activeBgColor: const [Color(blue), Color(primary)],
                labels: const [
                  'Chi tiêu',
                  'Thu nhập',
                ],
                onToggle: (index) {
                  _currentIndex = index;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(white),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _description,
                        decoration: InputDecoration(
                          labelText: "description".tr,
                          prefixIcon: const Icon(Icons.article),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        readOnly: true,
                        controller: _date,
                        decoration: const InputDecoration(
                          labelText: 'Ngày',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        onTap: () {
                          selectDate();
                        },
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        _showIconSelectionDialog();
                      },
                      child: Container(
                        height: 70,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Image.asset(
                                wallet == null
                                    ? imageBase().wallet
                                    : imageBase()
                                        .getIconWallets()[wallet!.icon],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 18.0),
                              child: Text(wallet == null
                                  ? "Biểu tượng"
                                  : wallet!.description),
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
                    bool isAnyFieldEmpty() {
                      return _price.text.isEmpty ||
                          _date.text.isEmpty ||
                          _description.text.isEmpty;
                    }

                    void updateTransaction() {
                      service.update(
                        Transaction(
                          id_user: userID!,
                          dateTime: _date.text,
                          id: widget.transactionid,
                          id_wallet: wallet!.id_wallet,
                          money: int.parse(_price.text),
                          description: _description.text,
                          transaction_type: _currentIndex!,
                        ),
                      );
                    }

                    if (_formKey.currentState!.validate()) {
                      if (isAnyFieldEmpty()) {
                        buildErrorMessage(
                            "Lỗi", "Không được để trống mục tạo!", context);
                      }
                      updateWallet() async {
                        if (oldWallet.id_wallet == wallet!.id_wallet) {
                          int income = 0;
                          int expense = 0;
                          income = await service.totalPriceWalletType(
                              userId: oldWallet.id_user,
                              typePrice: 1,
                              walletID: oldWallet.id_wallet);

                          expense = await service.totalPriceWalletType(
                              userId: oldWallet.id_user,
                              typePrice: 1,
                              walletID: oldWallet.id_wallet);
                          int total = int.parse(_price.text) + income - expense;
                          walletService.updateTotal(
                              walletID: oldWallet.id_wallet, price: total);
                        }

                        if (oldWallet.id_wallet != wallet!.id_wallet) {
                          // Cập nhật ví mới về giao dịch chuyển và lấy loại chuyển theo ngay trên thông tin cập nhật;
                          int total = _currentIndex == 1
                              ? wallet!.total + transaction.money
                              : wallet!.total - transaction.money;
                          walletService.updateTotal(
                              walletID: wallet!.id_wallet, price: total);

                          // Cập nhật lại ví cũ khi chuyển giao dịch
                          int totaldelete = transaction.transaction_type == 1
                              ? oldWallet.total - transaction.money
                              : oldWallet.total + transaction.money;
                          walletService.updateTotal(
                              walletID: oldWallet.id_wallet,
                              price: totaldelete);
                        }
                      }

                      if (!isAnyFieldEmpty()) {
                        updateTransaction();
                        updateWallet();
                        buildSuccessMessage(
                            "Thành công!", "Sửa thành công", context);
                        GetOffAllPage(page: () => const NavigationMenu());
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
                    showConfirm(context, widget.transactionid);
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
    );
  }
}
