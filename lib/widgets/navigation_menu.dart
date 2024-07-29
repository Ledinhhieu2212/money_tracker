import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/view/pages/input/create.dart';
import 'package:money_tracker/view/pages/wallet/wallet.dart';
import 'package:money_tracker/view/pages/home/home.dart';
import 'package:money_tracker/view/pages/report/report.dart';
import 'package:money_tracker/view/pages/tool/tools.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationMenu extends StatefulWidget {
  final SharedPreferences preferences;
  const NavigationMenu({super.key, required this.preferences});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.preferences == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final widgetOptions = [
      HomeScreen(preferences: widget.preferences),
      AccountScreen(preferences: widget.preferences),
      CreateScreen(preferences: widget.preferences),
      ReportScreen(preferences: widget.preferences),
      ToolPage(),
    ];
    return Scaffold(
      body: Container(
        color: const Color(grey),
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              size: 25,
            ),
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.wallet,
              size: 25,
            ),
            label: 'wallet'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.add_circle_outlined,
              size: 25,
            ),
            label: 'input'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.bar_chart,
              size: 25,
            ),
            label: 'report'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.dashboard,
              size: 25,
            ),
            label: 'other'.tr,
          ),
        ],
        currentIndex: _selectedIndex,
        iconSize: 20,
        selectedItemColor: const Color(blue),
        unselectedIconTheme: const IconThemeData(size: 26, color: Colors.grey),
        onTap: _onItemTapped,
      ),
    );
  }
}
