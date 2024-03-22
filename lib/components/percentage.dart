import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Percentage extends StatefulWidget {
  final double value;
  final bool switchValue;

  void Function(bool)? onTap;

  Percentage(
      {Key? key,
      required this.value,
      required this.onTap,
      required this.switchValue})
      : super(key: key);

  @override
  _PercentageState createState() => _PercentageState();
}

class _PercentageState extends State<Percentage> {
  @override
  Widget build(BuildContext context) {
    double percentage = widget.value;

    return CircularPercentIndicator(
      radius: MediaQuery.of(context).size.width * 0.35,
      lineWidth: 0.055 * MediaQuery.of(context).size.width,
      percent: percentage >= 1
          ? 0.99999
          : percentage <= 0
              ? 0.99999
              : percentage,
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
                ((percentage >= 1 ? 1 : percentage) * 100).toInt().toString() +
                    "%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Switch: " + (widget.switchValue ? "ON" : "OFF"),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: pi / 2,
                child: CupertinoSwitch(
                  value: widget.switchValue,
                  onChanged: widget.onTap,
                  activeColor: Theme.of(context).colorScheme.background,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
