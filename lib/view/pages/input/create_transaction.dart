import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/view/widgets/text_field.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/view/widgets/list_wallet.dart';
import 'package:money_tracker/view/widgets/flash_message.dart';
import 'package:money_tracker/services/transaction_service.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late TransactionService service;
  int? userID;
  final _formKey = GlobalKey<FormState>();

  List<Wallet> wallets = [];
  Wallet? wallet;
  late WalletService walletService;
  TextEditingController _money = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _description = TextEditingController();
  int _type = 0;
  connectDatabase() async {
    userID = await UserPreference().getUserID();
    service = TransactionService(await getDatabase());
    walletService = WalletService(await getDatabaseWallet());
    var dataWallet = await walletService.searchWallets(userID!);
    setState(() {
      wallets = dataWallet.where((element) => element.status ==1).toList();
      _date.text = FormatDateVi(DateTime.now());
    });
  }

  @override
  void initState() {
    super.initState();
    connectDatabase();
  }

  int selectedIcon = 0;
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

  bool isByte(int byte) => byte != 0;

  Future<void> selectDate() async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      lastDate: DateTime(2100),
      firstDate: DateTime(2000),
    );
    if (picked != null) {
      setState(() {
        _date.text = FormatDateVi(picked);
      });
    }
  }

  void createTransaction() {
    DateTime now = DateTime.now();
    service.insert(
      Transaction(
        id_user: userID!,
        dateTime:  _date.text,
        transaction_type: _type,
        id_wallet: wallet!.id_wallet!,
        money: int.parse(_money.text.replaceAll('.', '')),
        description: _description.text,
        create_up: removeTimeDate(now).toString(),
        upload_up: removeTimeDate(now).toString(),
      ),
    );
  }

  void updateWalletMoneyTotal() {
    int total = _type == 1
        ? wallet!.total + int.parse(_money.text.replaceAll('.', ''))
        : wallet!.total - int.parse(_money.text.replaceAll('.', ''));
    walletService.updateTotal(
      walletID: wallet!.id_wallet!,
      price: total,
    );
  }

  bool isEmptyTextfield() =>
      _money.text.isEmpty || _date.text.isEmpty || wallet == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "title_navigation_4".tr,
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(grey),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(20.0),
                  color: const Color(white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Số tiền"),
                      textFormFieldCreateMoney(
                          controller: _money,
                          color: isByte(_type) ? Colors.green : Colors.red),
                    ],
                  ),
                ),
                ToggleSwitch(
                  fontSize: 20,
                  minWidth: 200,
                  minHeight: 50,
                  totalSwitches: 2,
                  cornerRadius: 10,
                  initialLabelIndex: _type,
                  inactiveFgColor: Colors.white,
                  inactiveBgColor: Colors.black26,
                  activeFgColor: const Color(white),
                  activeBgColor: const [Color(blue), Color(primary)],
                  labels: [
                    'spending'.tr,
                    'income'.tr,
                  ],
                  onToggle: (index) {
                    setState(() {
                      _type = index!;
                    });
                  },
                ),
                Container(
                  color: const Color(white),
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _description,
                    decoration: InputDecoration(
                      labelText: "description".tr,
                      prefixIcon: const Icon(Icons.article),
                    ),
                  ),
                ),
                Container(
                  color: const Color(white),
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _date,
                    decoration: InputDecoration(
                      labelText: 'date'.tr,
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () {
                      selectDate();
                    },
                  ),
                ),
                MaterialButton(
                  color: const Color(white),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  onPressed: () {
                    _showIconSelectionDialog();
                  },
                  child: wallet == null
                      ? SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Text(
                              "select_title_wallets_create_transaction".tr),
                        )
                      : Row(
                          children: [
                            CircleAvatar(
                              child: Image.asset(wallet!.icon),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(wallet!.name),
                            )
                          ],
                        ),
                ),
                Container(
                  height: 50,
                  width: getScreenWidth(context),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: Text(
                      'save'.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(white),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (isEmptyTextfield()) {
                          buildErrorMessage(
                            "Lỗi",
                            "Không được để trống mục tạo!",
                            context,
                          );
                        } else {
                          if (int.parse(removeCurrencySeparator(_money.text)) >=
                              5000000) {
                            buildWarningMessage(
                              "Thông báo",
                              "Giá trị giao dịch không vượt quá 5 triệu VNĐ giao dịch!",
                              context,
                            );
                          } else {
                            createTransaction();
                            updateWalletMoneyTotal();
                            buildSuccessMessage(
                              "Thành công!",
                              "Thành công tạo giao dịch.",
                              context,
                            );
                            _money.clear();
                            _date.text = FormatDateVi(DateTime.now());
                            _description.clear();
                            getOffAllPage(page: () => const NavigationMenu(routerNavigationMenu: 0,));
                          }
                        }
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
