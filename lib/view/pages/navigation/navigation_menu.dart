import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/view/pages/home/home.dart';
import 'package:money_tracker/view/pages/input/create.dart';
import 'package:money_tracker/view/pages/report/report.dart';
import 'package:money_tracker/view/pages/tool/tools.dart';
import 'package:money_tracker/view/pages/wallet/wallet.dart';

class NavigationMenu extends StatefulWidget { 
  const NavigationMenu({super.key });

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final walletNavKey = GlobalKey<NavigatorState>();
  final reportNavKey = GlobalKey<NavigatorState>();
  final ortherNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 70,
        width: 70,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(100)),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              currentScreen = const CreateScreen();
              selectedTab = 5;
            });
          },
          backgroundColor: selectedTab == 5 ? const Color(blue) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            Icons.add,
            color: selectedTab == 5 ? Colors.white : const Color(blue),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  height: 60,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    setState(() {
                      currentScreen = const HomeScreen();
                      selectedTab = 0;
                    });
                  },
                  child: Icon(
                    Icons.home,
                    color: selectedTab == 0 ? const Color(blue) : Colors.grey,
                  ),
                ),
                MaterialButton(
                  height: 60,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    setState(() {
                      currentScreen = const WalletScreen();
                      selectedTab = 1;
                    });
                  },
                  child: Icon(
                    Icons.wallet,
                    color: selectedTab == 1 ? const Color(blue) : Colors.grey,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  height: 60,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    setState(() {
                      currentScreen = const ReportScreen();
                      selectedTab = 2;
                    });
                  },
                  child: Icon(
                    Icons.home,
                    color: selectedTab == 2 ? const Color(blue) : Colors.grey,
                  ),
                ),
                MaterialButton(
                  height: 60,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    setState(() {
                      currentScreen = const ToolPage();
                      selectedTab = 3;
                    });
                  },
                  child: Icon(
                    Icons.wallet,
                    color: selectedTab == 3 ? const Color(blue) : Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
