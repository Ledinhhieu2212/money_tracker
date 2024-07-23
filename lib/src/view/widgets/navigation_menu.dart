import 'package:flutter/material.dart';
import 'package:money_tracker/src/model/styles/colors.dart';
import 'package:money_tracker/src/view/pages/input/create.dart';
import 'package:money_tracker/src/view/pages/wallet/wallet.dart';
import 'package:money_tracker/src/view/pages/home/home.dart';
import 'package:money_tracker/src/view/pages/report/report.dart';
import 'package:money_tracker/src/view/pages/tool/tools.dart';
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
    final _widgetOptions = [
      HomeScreen(
        preferences: widget.preferences,
      ),
      AccountScreen(),
      CreateScreen(),
      ReportScreen(),
      ToolPage(
        pref: widget.preferences,
      ),
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: 30,),
            
            label: 'Tổng quan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet,size: 30,),
            label: 'Ví',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outlined,size: 30,),
            label: 'Nhập',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart,size: 30,),
            label: 'Báo cáo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard,size: 30,),
            label: 'Khác',
          ),
        ],
        currentIndex: _selectedIndex,
        iconSize: 20,
        selectedItemColor: Color(blue),
        unselectedIconTheme: const IconThemeData(size: 26, color: Colors.grey),
        onTap: _onItemTapped,
      ),
    );
  }
}
