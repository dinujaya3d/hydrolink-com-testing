import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WaterflowIndicator extends StatefulWidget {
  final bool value;
  final bool cutOff;
  WaterflowIndicator({
    Key? key,
    required this.value,
    required this.cutOff,
  }) : super(key: key);

  @override
  _WaterflowIndicatorState createState() => _WaterflowIndicatorState();
}

class _WaterflowIndicatorState extends State<WaterflowIndicator> {
  double switchValue = 1;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: MediaQuery.of(context).size.width * 0.15,
      lineWidth: 0.022 * MediaQuery.of(context).size.width,
      percent: 0.9999999999,
      progressColor: widget.value ? Colors.red : Colors.green,
      backgroundColor: Color(0xFF203248),
      circularStrokeCap: CircularStrokeCap.round,
      center: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.value
                    ? "Air Flow"
                    : widget.cutOff
                        ? "Cut-Off"
                        : "Normal",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
