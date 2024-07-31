import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/view/pages/navigation/navigation_menu.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:money_tracker/widgets/config.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/widgets/text_field.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money_tracker/services/transaction_service.dart';

class DetailTransaction extends StatefulWidget {
  final int transactionid;
  const DetailTransaction({super.key, required this.transactionid});

  @override
  State<DetailTransaction> createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  int? _currentIndex;
  late SharedPreferences prefs;
  late TransactionService service;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _description = TextEditingController();
  connectDatabase() async {
    prefs = await SharedPreferences.getInstance();
    service = TransactionService(await getDatabase());
    Transaction p = await service.getById(widget.transactionid);

    setState(() {
      _price.text = p.money;
      _date.text = p.dateTime;
      _description.text = p.description;
      _currentIndex = int.parse(p.transaction_type);
    });
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
                    child: const Text('Không')),
                TextButton(
                    onPressed: () {
                      service.delete(transactionid);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Xóa thành công!')));
                      GetToPage(page: () => const NavigationMenu()); 
                    },
                    child: const Text('Có')),
              ]);
        });
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
                        color: _currentIndex == 0 ? Colors.red : Colors.green),
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
                  _currentIndex = index;
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
                  label: const Text(
                    'Cập nhật',
                    style: TextStyle(color: Color(white), fontSize: 20),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      service.update(Transaction(
                        widget.transactionid,
                        _price.text,
                        prefs.getString('ma_nguoi_dung')!,
                        _date.text,
                        _description.text,
                        _currentIndex.toString(),
                      )); 
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sửa thành công!')));
                      GetToPage(page: () => const NavigationMenu()); 
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
                    showConfirm(context,   widget.transactionid); 
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


