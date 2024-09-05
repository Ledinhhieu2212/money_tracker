import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/constants/config.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/view/widgets/flash_message.dart';
import 'package:money_tracker/view/widgets/select_wallets.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({super.key});

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  int? userID;
  int incomePrice = 0, spendingPrice = 0;
  late WalletService service;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _wallet = TextEditingController();
  connectDatabase() async {
    userID = await UserPreference().getUserID();
    service = WalletService(await getDatabaseWallet());
    setState(() {});
  }

  @override
  void initState() {
    connectDatabase();
    super.initState();
  }

  Map<String?, String?> iconWallet = {"icon": null, "name": null};
  bool checkIconWallet(Map<String?, String?> icon_wallet) {
    bool hasNullKey = icon_wallet.keys.any((key) => key == null);
    bool hasNullValue = icon_wallet.values.any((value) => value == null);
    return (hasNullKey || hasNullValue) ? true : false;
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
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      onPressed: () {
                        getToPage(
                          page: () => SelectWallets(
                            onPress: (value) {
                              setState(() {
                                iconWallet["icon"] = value["icon"];
                                iconWallet["name"] = value["name"];
                              });
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.5,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        child: checkIconWallet(iconWallet)
                            ? const Text("Chọn loại ví")
                            : Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(iconWallet["icon"]!),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text(iconWallet["name"]!),
                                  )
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        controller: _wallet,
                        decoration: const InputDecoration(
                          labelText: "Mô tả",
                          prefixIcon: Icon(Icons.article),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
                      if (checkIconWallet(iconWallet)) {
                        buildErrorMessage(
                            "Lỗi",
                            "Bạn phải chọn loại ví trước khi tạo mới!",
                            context);
                      }

                      if (!checkIconWallet(iconWallet)) {
                        if (_wallet.text.isEmpty) {
                          _wallet.text = '';
                        }
                        DateTime now = DateTime.now();
                        service.insert(
                          Wallet(
                            name: iconWallet['name']!,
                            id_user: userID!,
                            total: 0,
                            icon: iconWallet["icon"]!,
                            description: _wallet.text,
                            create_up: removeTimeDate(now).toString(),
                            upload_up: removeTimeDate(now).toString(),
                          ),
                        );
                        buildSuccessMessage(
                            "Thành công!", "Thành công tạo ví.", context);
                        _wallet.clear();
                        getOffAllPage(
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
