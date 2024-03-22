import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyGraph extends StatefulWidget {
  final Map graphMap;
  const MyGraph({super.key, required this.graphMap});

  @override
  State<MyGraph> createState() => _MyGraphState();
}

class _MyGraphState extends State<MyGraph> {
  @override
  Widget build(BuildContext context) {
    print(widget.graphMap);
    int pointer = widget.graphMap['Pointer'].toInt();
    List x_temp = widget.graphMap.keys.toList();
    x_temp.remove('Pointer');
    List<int> x_data = x_temp.map((e) => int.parse(e)).toList();
    List<double> y_data = [];
    int i = pointer + 1;
    while (i < x_data.length) {
      y_data.add(widget.graphMap[x_data[i].toString()].toDouble());
      i++;
    }
    i = 0;
    while (i <= pointer) {
      y_data.add(widget.graphMap[x_data[i].toString()].toDouble());
      i++;
    }
    List<FlSpot> spotsGraph = [];
    i = 0;
    while (i < x_data.length) {
      spotsGraph.add(FlSpot(i.toDouble(), y_data[i]));
      i++;
    }
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(LineChartData(lineBarsData: [
        LineChartBarData(
            spots: spotsGraph,
            isCurved: false,
            color: Color.fromARGB(255, 223, 138, 12),
            barWidth: 4,
            //isStrokeCapRound: true,
            belowBarData: BarAreaData(
                show: true,
                color:
                    const Color.fromARGB(255, 223, 138, 12).withOpacity(0.3)))
      ])),
    );
  }
}
