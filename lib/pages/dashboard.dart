import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hydrolink_testing/components/percentage.dart';
import 'package:hydrolink_testing/components/percentage2.dart';
import 'package:hydrolink_testing/components/waterflow.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String user = 'HYD00001';

  String _selectedControlType = 'Manual';
  double _percentageValue = 0.0;
  bool _switchValue = false;

  Query dbRef2 = FirebaseDatabase.instance.ref();
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Tanks');

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void manSwitchChanged(bool value) {
    Map<String, bool> tanks = {
      'ManSwitch': value,
    };
    reference.child(user).update(tanks).then((value) => null);
    setState(() {
      _switchValue = value;
    });
  }

  Widget Dash({required Map tank}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.04,
              bottom: MediaQuery.of(context).size.height * 0.04),
          child: Text(
            'Hydro Level',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.7 + 20,
          width: MediaQuery.of(context).size.width,
          child: Percentage(
            value: tank[user]['Water'].toDouble(),
            onTap: (value) => {manSwitchChanged(value)},
            switchValue: tank[user]['ManSwitch'],
          ),
        ),
        Row(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.35 + 20,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: WaterflowIndicator(),
                ),
                const Text(
                  "Water Flow",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.35 + 20,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: PercentageSmall(),
                ),
                const Text(
                  "Battery",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.04,
              bottom: MediaQuery.of(context).size.height * 0.04),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: MediaQuery.of(context).size.width * 0.41,
                      top: 10,
                    ),
                    child: Text("Control Type",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 15,
                        )),
                  ),
                  DropdownButton(
                    value: _selectedControlType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedControlType = newValue!;
                      });
                    },
                    dropdownColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    underline: Container(),
                    items: <String>['Manual', 'Auto']
                        .map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10,
                                right: MediaQuery.of(context).size.width * 0.4),
                            child: Text(value,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 20,
                                )),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 183, 206, 245),
      body: Container(
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
                  //print(student['HYD00002']['Percentage'].toString());
                  return Dash(tank: tank);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
