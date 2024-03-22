import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fl_chart/fl_chart.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hydrolink_testing/components/custom_tab_bar.dart';
import 'package:hydrolink_testing/components/graph_generator.dart';

class UsagePage extends StatefulWidget {
  final String tankName;
  const UsagePage({super.key, required this.tankName});

  @override
  State<UsagePage> createState() => _UsagePageState();
}

Widget UsageCharts(
    {required Map tank,
    required String user,
    required TabController flowRateTimeController,
    required TabController usageController,
    required BuildContext context}) {
  //print(tank['Tanks'][user]['FlowRate']['Day'].keys.toList());

  print("hello");
  return Column(
    children: [
      Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.02),
          child: Column(
            children: [
              Text(
                "Usage (L)",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                child: TabBar(
                  controller: flowRateTimeController,
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
              ),
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.3,
                child:
                    TabBarView(controller: flowRateTimeController, children: [
                  MyGraph(
                    graphMap: tank['Tanks'][user]['FlowRate']['Year'],
                  ),
                  MyGraph(
                    graphMap: tank['Tanks'][user]['FlowRate']['Month'],
                  ),
                  MyGraph(
                    graphMap: tank['Tanks'][user]['FlowRate']['Day'],
                  ),
                  MyGraph(
                    graphMap: tank['Tanks'][user]['FlowRate']['Hour'],
                  ),
                ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "Flow Rate (L/min)",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                child: TabBar(
                  controller: usageController,
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
              ),
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.3,
                child: TabBarView(controller: usageController, children: [
                  MyGraph(
                    graphMap: tank['Tanks'][user]['Usage']['Year'],
                  ),
                  MyGraph(
                    graphMap: tank['Tanks'][user]['Usage']['Month'],
                  ),
                  MyGraph(
                    graphMap: tank['Tanks'][user]['Usage']['Day'],
                  ),
                  MyGraph(
                    graphMap: tank['Tanks'][user]['Usage']['Hour'],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _UsagePageState extends State<UsagePage> with TickerProviderStateMixin {
  Query dbRef2 = FirebaseDatabase.instance.ref();
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('RealTimeDB/Tanks');
  DatabaseReference reference2 =
      FirebaseDatabase.instance.ref().child('RealTimeDB/Users');

  late TabController _flowRateTime;
  late TabController _usageTime;

  @override
  void initState() {
    super.initState();
    _flowRateTime = TabController(
      length: 4,
      vsync: this,
    );
    _usageTime = TabController(
      length: 4, // Adjust the length according to your needs
      vsync: this,
    );
  }

  @override
  void dispose() {
    _flowRateTime.dispose();
    _usageTime.dispose(); // Dispose _usageTime as well
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                child: FirebaseAnimatedList(
                  physics: const NeverScrollableScrollPhysics(),
                  query: dbRef2,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map tank = snapshot.value as Map;
                    tank['key'] = snapshot.key;

                    return UsageCharts(
                      tank: tank,
                      user: widget.tankName,
                      flowRateTimeController: _flowRateTime,
                      usageController: _usageTime,
                      context: context,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
