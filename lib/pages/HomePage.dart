import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
//import 'package:hydrolink_testing/components/percentage.dart';
//import 'package:hydrolink_testing/components/percentage2.dart';
//import 'package:hydrolink_testing/components/waterflow.dart';
import 'package:hydrolink_testing/pages/dashboard.dart';
import 'package:hydrolink_testing/pages/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    SettingsPage(),
    Dashboard(),
    const Center(
      child: Text(
        "Support",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _pages[_selectedIndex],
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      bottomNavigationBar: GNav(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        selectedIndex: _selectedIndex,
        tabs: const [
          GButton(
            icon: Icons.settings_applications,
            text: 'Settings',
          ),
          GButton(
            icon: Icons.home,
            text: 'Dashboard',
          ),
          GButton(
            icon: Icons.help_center_rounded,
            text: 'Support',
          ),
        ],
        onTabChange: (value) {
          _navigateBottomBar(value);
        },
      ),
    );
  }
}
