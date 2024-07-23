import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_tracker/src/model/styles/app_style.dart';
import 'package:money_tracker/src/model/styles/colors.dart';
import 'package:money_tracker/src/view/components/category.dart';
import 'package:money_tracker/src/view/widgets/button/button_icon.dart';

const List<String> danhMuc = ['Chi tiêu', 'Thu nhập'];

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String dropdownValue = danhMuc.first;
  TextEditingController controller = new TextEditingController();

  final TextEditingController _dateController = new TextEditingController();

  FocusNode inputNode = FocusNode();

  void openKeyboard() {
    FocusScope.of(context).requestFocus(inputNode);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate() async {
      DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (_picked != null) {
        setState(() {
          _dateController.text = _picked.toString().split(" ")[0];
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceAround, // Center items with equal space around
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customButtomIcon(
                call: () {},
                colorIcon:const Color(white),
                icon: Icons.access_time_outlined,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    elevation: 16,
                    style: const TextStyle(color:  Color(blue), fontSize: 18),
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items:
                        danhMuc.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          // Wrap with Container to remove border

                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              customButtomIcon(
                call: () {},
                colorIcon: const Color(white),
                icon: Icons.check,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: const Color(grey),
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
                  TextField(
                    controller: controller,
                    focusNode: inputNode,
                    textAlign: TextAlign.end,
                    obscureText: false,
                    style: const TextStyle(color: Colors.red, fontSize: 30),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      hintText: "0",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      hintStyle: TextStyle(color: Colors.red, fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: const Color(white),
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: SizedBox(
                      width: 250,
                      child: TextField(
                        enabled: false,
                        obscureText: false,
                        decoration: InputDecoration(
                            labelText: "Chọn danh mục",
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 17)),
                      ),
                    ),
                  ),
                  Expanded(
                      child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(color: Color(primary)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Category()),
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Tất cả ',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15,
                              ),
                            ),
                            WidgetSpan(
                              child: Icon(
                                Icons.chevron_right,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Container(
              color: const Color(white),
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  // filled: true,
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  _selectDate();
                },
              ),
            ),
            Container(
              color: const Color(white),
              padding: const EdgeInsets.all(20.0),
              child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  labelText: "Ghi chú",
                  prefixIcon: Icon(Icons.done),
                ),
              ),
            ),
            Container(
              height: 50,
              width: getScreenWidth(context),
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text(
                  'Lưu',
                  style: TextStyle(color: Color(white), fontSize: 20),
                ),
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  iconColor: const Color(white), backgroundColor: const Color(blue), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        5), // Adjust as per your requirement
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
