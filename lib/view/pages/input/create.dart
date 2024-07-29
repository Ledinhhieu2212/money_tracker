import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:get/get.dart';
import 'package:money_tracker/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uuid/uuid.dart';

class CreateScreen extends StatefulWidget {
  final SharedPreferences preferences;
  const CreateScreen({super.key, required this.preferences});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late TransactionService service;
  var uuid = Uuid();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _money = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _description = TextEditingController();
  String _type = '0';
  connectDatabase() async {
    service = TransactionService(await getDatabase());
  }

  @override
  void initState() {
    connectDatabase();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (picked != null) {
        setState(() {
          _date.text = picked.toString().split(" ")[0];
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
                        controller: _money,
                        color:   Colors.red  ),
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
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    prefixIcon: Icon(Icons.calendar_today),
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
                      // Process the data, for example, add the product to a list
                      // or send it to an API
                      String userID =
                          widget.preferences.getString('ma_nguoi_dung')!;
                      service.insert(Transaction(
                          uuid.v4().hashCode,
                          _money.text,
                          userID,
                          _date.text,
                          _description.text,
                          _type));
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Thêm thành công!')));
                      _money.clear();
                      _date.clear();
                      _description.clear();
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
