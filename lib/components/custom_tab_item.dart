import 'package:flutter/material.dart';

class MyTabItem extends StatefulWidget {
  final String title;
  MyTabItem({super.key, required this.title});

  @override
  State<MyTabItem> createState() => _MyTabItemState();
}

class _MyTabItemState extends State<MyTabItem> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
        ),
      ]),
    );
  }
}
