import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/images.dart';

class SelectWallets extends StatelessWidget {
  final ValueChanged<Map<String, dynamic>> onPress;
  const SelectWallets({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Chọn loại ví",
          style: TextStyle(fontSize: 20),
        ),
        // actions: [
        //   TextButton(
        //     child: const Icon(
        //       Icons.add_circle_outlined,
        //       color: Color(white),
        //       size: 30,
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: imageBase().getIconWallets().length,
              itemBuilder: (context, index) {
                var data = imageBase().getIconWallets()[index];
                return MaterialButton(
                  onPressed: () {
                    // Truyền trực tiếp các giá trị icon và name qua Map
                    onPress({
                      'icon': data['icon'],
                      'name': data['name'],
                    });
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 60,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Image.asset(data['icon']!),
                        ),
                        Flexible(child: Text(data['name']!))
                      ],
                    ),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
