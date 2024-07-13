import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_tracker/model/Styles/app_style.dart';
import 'package:money_tracker/model/Styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _obscureText = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Tk: dinhhieu203765',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // Chiều cao của ButtonTheme
          child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: white, // Màu nền của Container
                borderRadius:
                    BorderRadius.circular(12.0), // Bo tròn góc của Container
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "0",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text("Chi tiêu: 0"),
                      Text("Thu nhập: 0"),
                    ],
                  ),
                  Column(
                    children: [
                      
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.visibility),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.visibility_off),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
      body: Container(
        color: grey,
        child:  Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: white,
              width: getScreenWidth(context),
              height: getScreenHeight(context)/2,
              child: GestureDetector(
                onTap: () {
                  
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tình hình thu chi",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),

                        IconButton(onPressed: () {
                          
                        }, icon: Icon(Icons.settings))
                      ],
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
