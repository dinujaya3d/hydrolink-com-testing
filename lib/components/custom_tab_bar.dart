import 'package:flutter/material.dart';
import 'package:hydrolink_testing/components/custom_tab_item.dart';
import 'package:hydrolink_testing/components/custom_tab_item.dart';

class MyTabBar extends StatefulWidget {
  MyTabBar({super.key});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TabBar(
        tabs: [
          Tab(
            text: "Year",
          ),
          Tab(
            text: "Month",
          ),
          Tab(
            text: "Day",
          ),
          Tab(
            text: "Hour",
          )
        ],
      ),
    );
  }
}
