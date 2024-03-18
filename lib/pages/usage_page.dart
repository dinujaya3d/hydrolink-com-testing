import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fl_chart/fl_chart.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UsagePage extends StatefulWidget {
  final String tankName;
  const UsagePage({super.key, required this.tankName});

  @override
  State<UsagePage> createState() => _UsagePageState();
}

Widget UsageCharts({required Map tank, required String user}) {
  return Column(
    children: [
      Container(
        child: Column(
          children: [
            LineChart(LineChartData(lineBarsData: [
              LineChartBarData(
                  spots: [
                    FlSpot(0, 1),
                    FlSpot(1, 3),
                    FlSpot(2, 2),
                    FlSpot(3, 5),
                    FlSpot(4, 4),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(
                      show: true, color: Colors.blue.withOpacity(0.3)))
            ])),
            Text(
              user,
            ),
          ],
        ),
      ),
      Text("Usage"),
    ],
  );
}

class _UsagePageState extends State<UsagePage> {
  Query dbRef2 = FirebaseDatabase.instance.ref();
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('RealTimeDB/Tanks');
  DatabaseReference reference2 =
      FirebaseDatabase.instance.ref().child('RealTimeDB/Users');

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Color.fromARGB(255, 189, 202, 224)),
        child: Column(
          children: [
            //Text("Logged In: " + userFire.uid!),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8795,
              child: FirebaseAnimatedList(
                physics: const NeverScrollableScrollPhysics(),
                query: dbRef2,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map tank = snapshot.value as Map;
                  //mySmartDevices[index][2] =
                  //    student[user][switchParams[index]];
                  tank['key'] = snapshot.key;

                  return UsageCharts(tank: tank, user: widget.tankName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
