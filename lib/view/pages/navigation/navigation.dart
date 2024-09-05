import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/model/user.dart';
import 'package:money_tracker/view/pages/home/home.dart';
import 'package:money_tracker/view/pages/input/create.dart';
import 'package:money_tracker/view/pages/report/report.dart';
import 'package:money_tracker/view/pages/tool/tools.dart';
import 'package:money_tracker/view/pages/wallet/wallet.dart';

class NavigationMenu extends StatefulWidget {
  final int routerNavigationMenu;
  const NavigationMenu({
    super.key,
    this.routerNavigationMenu = 0,
  });

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
  int currentScreen = 0;
  late final List<Widget> items = [
    HomeScreen(),
    WalletScreen(),
    ReportScreen(),
    ToolPage(),
    CreateScreen(),
  ];

  @override
  void initState() {
    super.initState();
    selectedTab = widget.routerNavigationMenu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(grey),
      body: PageStorage(
        bucket: bucket,
        child: items[selectedTab],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 70,
        width: 70,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              selectedTab = 4;
            });
          },
          backgroundColor: const Color(blue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: selectedTab == 5
              ? const Icon(Icons.close, color: Colors.white)
              : const Icon(Icons.add, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
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
                      selectedTab = 2;
                    });
                  },
                  child: Icon(
                    Icons.bar_chart,
                    color: selectedTab == 2 ? const Color(blue) : Colors.grey,
                  ),
                ),
                MaterialButton(
                  height: 60,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    setState(() {
                      selectedTab = 3;
                    });
                  },
                  child: Icon(
                    Icons.dashboard,
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
