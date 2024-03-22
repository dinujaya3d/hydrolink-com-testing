import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentageSmall extends StatefulWidget {
  const PercentageSmall({Key? key}) : super(key: key);

  @override
  _PercentageSmallState createState() => _PercentageSmallState();
}

class _PercentageSmallState extends State<PercentageSmall> {
  double switchValue = 0.8;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: MediaQuery.of(context).size.width * 0.15,
      lineWidth: 0.022 * MediaQuery.of(context).size.width,
      percent: switchValue,
      progressColor: Theme.of(context).colorScheme.background,
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      circularStrokeCap: CircularStrokeCap.round,
      center: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (0.8 * 100).toInt().toString() + "%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
