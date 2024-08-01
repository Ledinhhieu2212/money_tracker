import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:money_tracker/widgets/config.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/widgets/text_field.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/widgets/flash_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:money_tracker/view/pages/navigation/navigation.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late TransactionService service;
  String userID = '';
  int id_transaction = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _money = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _description = TextEditingController();
  String _type = '0';
  connectDatabase() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userID = preferences.getString('ma_nguoi_dung')!;
    service = TransactionService(await getDatabase());
    var data = await service.searchOfUser(userID);
    setState(() {
      id_transaction = data.length + 1;
      String date = DateTime.now().toString().split(' ')[0];
      List<String> parts = date.split('-');
      String year = parts[0];
      String month = parts[1];
      String day = parts[2];
      _date.text = "$day/$month/$year";
    });
  }

  @override
  void initState() {
    connectDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate() async {
      DateTime now = DateTime.now();
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        setState(() {
          String date = picked.toString().split(' ')[0];
          List<String> parts = date.split('-');
          String year = parts[0];
          String month = parts[1];
          String day = parts[2];
          _date.text = "$day/$month/$year";
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Tạo giao dịch",
          style: TextStyle(fontSize: 22),
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
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(20.0),
                color: const Color(white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Số tiền"),
                    textFormFieldCreateMoney(
                        controller: _money, color: Colors.red),
                  ],
                ),
              ),
              ToggleSwitch(
                minHeight: 50,
                minWidth: 200,
                fontSize: 20,
                cornerRadius: 10,
                activeBgColor: const [Color(blue), Color(primary)],
                activeFgColor: const Color(white),
                inactiveBgColor: Colors.black26,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                labels: const [
                  'Chi tiêu',
                  'Thu nhập',
                ],
                onToggle: (index) {
                  _type = index.toString();
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
                      if (_money.text.isEmpty ||
                          _date.text.isEmpty ||
                          _description.text.isEmpty) {
                        buildErrorMessage(
                            "Lỗi", "Không được để trống mục tạo!", context);
                      } else {
                        service.insert(Transaction(id_transaction, _money.text,
                            userID, _date.text, _description.text, _type));

                        buildSuccessMessage("Thành công!",
                            "Thành công tạo giao dịch.", context);
                        _money.clear();
                        _date.clear();
                        _description.clear();
                        GetToPage();
                      }
                    } else {
                      buildWarningMessage(
                          "Lỗi!", "Không thể tạo mới giao dịch.", context);
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
                child: Row(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
