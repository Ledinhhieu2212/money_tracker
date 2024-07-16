import 'package:flutter/material.dart';
import 'package:money_tracker/src/model/styles/colors.dart';
import 'package:money_tracker/src/view/pages/create.dart';
import 'package:money_tracker/src/view/pages/home.dart';
import 'package:money_tracker/src/view/pages/account.dart';
import 'package:money_tracker/src/view/pages/report.dart';
import 'package:money_tracker/src/view/pages/tool_page.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AccountScreen(),
    CreateScreen(),
    ReportScreen(),
    ToolPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tổng quan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Tài khoản',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Nhập',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Báo cáo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Khác',
          ),
        ],
        currentIndex: _selectedIndex,
        iconSize: 20,
        selectedItemColor:  Color(blue),
        unselectedIconTheme: const IconThemeData(size: 26, color: Colors.grey),
        onTap: _onItemTapped,
      ),
    );
  }
}
