import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';
import 'package:money_tracker/view/widgets/Icon_selection_dialog.dart';
import 'package:money_tracker/view/widgets/config.dart';
import 'package:money_tracker/view/widgets/flash_message.dart';
import 'package:money_tracker/view/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({super.key});

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  int? userID; 
  int incomePrice = 0, spendingPrice = 0;
  late WalletService service;
  List<Wallet> wallet = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _wallet = TextEditingController();
  final TextEditingController _money = TextEditingController();
  connectDatabase() async {
    userID = await UserPreference().getUserID();
    service = WalletService(await getDatabaseWallet());
    var data = await service.searchWallets(userID!);
    setState(() { 
      wallet = data;
    });
  }

  @override
  void initState() {
    connectDatabase();
    super.initState();
  }

  int selectedIcon = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Tạo thêm ví",
          style: TextStyle(fontSize: 20),
        ),
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
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: Text(
                    'save'.tr,
                    style: const TextStyle(color: Color(white), fontSize: 20),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the data, for example, add the product to a list
                      // or send it to an API

                      if (_wallet.text.isEmpty) {
                        buildErrorMessage(
                            "Lỗi", "Không được để trống mục tạo!", context);
                      } else {
                        if (_money.text.isEmpty) {
                          _money.text = '0';
                        }
                        
                        DateTime now = DateTime.now();
                        service.insert(
                          Wallet(
                            total: int.parse(_money.text), 
                            id_user: userID!,
                            icon: selectedIcon,
                            money_price: int.parse(_money.text),
                            description: _wallet.text,
                            create_up: now.toString(),
                            upload_up: now.toString(),
                          ),
                        );
                        buildSuccessMessage(
                            "Thành công!", "Thành công tạo ví.", context);
                        _money.clear();
                        _wallet.clear();
                        GetOffAllPage(
                            page: () => const NavigationMenu(
                                  routerNavigationMenu: 1,
                                ));
                      }
                    } else {
                      buildWarningMessage(
                          "Lỗi!", "Không thể tạo mới ví!", context);
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
    );
  }
}
