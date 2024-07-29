import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:money_tracker/widgets/text_field.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DetailTransaction extends StatefulWidget {
  final int transactionid;
  const DetailTransaction({super.key, required this.transactionid});

  @override
  State<DetailTransaction> createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  late TransactionService service;
  final _formKey = GlobalKey<FormState>();
  Transaction p = Transaction(0, "", "", "", "", "");
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _date = TextEditingController();

  int? _currentIndex;
  connectDatabase() async {
    service = TransactionService(await getDatabase());
  }

  getProduct() async {
    service = TransactionService(await getDatabase());
    var data = await service.getById(widget.transactionid);
    setState(() {
      p = data;
      _price.text = p.money;
      _description.text = p.description;
      _date.text = p.dateTime;
      _currentIndex = int.parse(p.transaction_type);
    });
  }

  @override
  void initState() {
    getProduct();
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
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(20.0),
                color: const Color(white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Số tiền"),
                    textFormFieldCreateMoney(
                        controller: _price,
                        color: p.transaction_type == '0'
                            ? Colors.red
                            : Colors.green),
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
                initialLabelIndex: _currentIndex,
                labels: const [
                  'Chi tiêu',
                  'Thu nhập',
                ],
                onToggle: (index) {
                  _currentIndex =
                      index; // Cập nhật trạng thái khi toggle thay đổi
                },
              ),
              const SizedBox(
                height: 10,
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
                    labelText: 'Ngày',
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
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: Text(
                    'save'.tr,
                    style: const TextStyle(color: Color(white), fontSize: 20),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
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
                  label: Text(
                    'Xóa',
                    style: const TextStyle(color: Color(white), fontSize: 20),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  style: ElevatedButton.styleFrom(
                    iconColor: const Color(white),
                    backgroundColor:  Colors.red,
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
