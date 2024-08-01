import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/wallet_service.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart'; 
import 'package:money_tracker/widgets/config.dart';
import 'package:money_tracker/widgets/flash_message.dart';
import 'package:money_tracker/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({super.key});

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> { 
  String userID = '';
  int id = 1;
  late WalletService service; 
  List<Wallet> wallet = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _wallet = TextEditingController();
  final TextEditingController _money = TextEditingController();
  connectDatabase() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userID = preferences.getString('ma_nguoi_dung')!;
    service = WalletService(await getDatabase());
    var data = await service.searchWallets(int.parse(userID));
    setState(() {
       wallet = data;
       id = wallet.length + 1;
    });
  }

  @override
  void initState() {
    connectDatabase();
    super.initState();
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
                        service.insert(
                          Wallet(
                            id,
                            int.parse(userID),
                            '123',
                            int.parse(_money.text),
                            _wallet.text,
                          ),
                        );
                        buildSuccessMessage("Thành công!",
                            "Thành công tạo ví.", context); 
                        _money.clear();
                        _wallet.clear();
                        GetToPage(page: () =>  const NavigationMenu(routerNavigationMenu: 1,));
                      }
                    } else {  
                      buildWarningMessage("Lỗi!",
                            "Không thể tạo mới ví!", context);
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
