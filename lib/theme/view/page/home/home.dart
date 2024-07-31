import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_tracker/theme/constants/app_assets.dart';
import 'package:money_tracker/theme/constants/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Container with gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HexColor("FFF6E5"),
                  HexColor('ffffff'),
                ],
                stops: const [0.3, 0.7],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: HexColor(AppPallete.violet100),
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        child: Image.asset(imageBase.avatar),
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      color: HexColor(AppPallete.violet100),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Account Balance",
                  style: TextStyle(
                    color: HexColor(AppPallete.light20),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '\$9400',
                  style: TextStyle(
                    color: HexColor(AppPallete.dark50),
                    fontWeight: FontWeight.bold,
                    fontSize: 46,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: HexColor(AppPallete.green100)),
                      child: Row(
                        children: [
                          Image.asset(
                            imageBase.Income,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            children: [
                              Text(
                                "Income",
                                style: TextStyle(
                                  color: HexColor(AppPallete.white),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "\$5000",
                                style: TextStyle(
                                    color: HexColor(AppPallete.white),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: HexColor(AppPallete.red100)),
                      child: Row(
                        children: [
                          Image.asset(
                            imageBase.Expenses,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            children: [
                              Text(
                                "Expenses",
                                style: TextStyle(
                                  color: HexColor(AppPallete.white),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "\$1200",
                                style: TextStyle(
                                    color: HexColor(AppPallete.white),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
                
              ],
            ),
          )
        ],
      ),
    );
  }
}