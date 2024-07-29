import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/images.dart';
import 'package:money_tracker/widgets/text_field.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({super.key});

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  TextEditingController controller = TextEditingController();
  FocusNode inputNode = FocusNode();
  TextEditingController name_wallet = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Tạo thêm ví",
          style: TextStyle(fontSize: 20),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.check,
              size: 30,
            ),
          )
        ],
      ),
      body: Container(
        color: Color(grey),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              child: Column(
                children: [
                  Text("Số dư ban đầu"),
                  textFormFieldCreateMoney(
                      controller: controller,
                      color: const Color(primary))
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
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.lightBlue[900],
                          child: Image.asset(
                            imageBase().food,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    onPressed: () {},
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child:  Image.asset(imageBase().wallet),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Tiền mặt"),
                            )
                          ],
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.money_rounded,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("VND"),
                            )
                          ],
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: Colors.grey,
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
                onPressed: () {},
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
    );
  }
}
