import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hydrolink_testing/components/percentage.dart';
import 'package:hydrolink_testing/components/percentage2.dart';
import 'package:hydrolink_testing/components/waterflow.dart';
import 'package:hydrolink_testing/pages/AddDevicePage.dart';
import 'package:hydrolink_testing/pages/NewDevicePage.dart';
import 'package:hydrolink_testing/pages/usage_page.dart';
import 'package:hydrolink_testing/pages/usage_page.dart';

class Dashboard extends StatefulWidget {
  final String userUid;
  final String token;
  Dashboard({super.key, required this.userUid, required this.token});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String user = 'HYD00005';

  String _selectedControlType = 'Manual';
  double _percentageValue = 0.0;
  bool _switchValue = false;
  //bool _auto = false;

  Query dbRef2 = FirebaseDatabase.instance.ref();
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('RealTimeDB/Tanks');
  DatabaseReference reference2 =
      FirebaseDatabase.instance.ref().child('RealTimeDB/Users');
  DatabaseReference reference3 =
      FirebaseDatabase.instance.ref().child('RealTimeDB/Notifications');

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

  void updateMessageId(String messageId, String allUsers) {
    List users = allUsers.split(',');
    if (users.contains(messageId)) {
      //
    } else if (messageId != 'No token') {
      users.add(messageId);
      String updateText = users.join(',');
      Map<String, String> messageIdMap = {
        'users': updateText,
      };
      reference3.child(user).update(messageIdMap).then((value) => null);
    }
  }

  void ctrlTypeChanged(String? value) {
    Map<String, bool> tanks = {
      'Auto': value == 'Manual' ? false : true,
    };
    reference.child(user).update(tanks).then((value) => null);
    setState(() {
      _selectedControlType = value!;
    });
  }

  void addTankInRealTimeDB() async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDevicePage()),
    );

    // Check if the result is not null and has 8 characters
    if (result != null && result.length == 10) {
      // Perform the necessary operations with the obtained code
      // For now, I'm just printing it. You can update it accordingly.
      print('Obtained Code: $result');

      // Add your logic to update the database or perform other actions.
    }
  }

  void addUserInRealTimeDB(String userUID) {
    Map<String, String> newUserTank = {
      'Tank 01': 'None',
      'Selected Tank': 'None',
    };
    Map<String, Map> newUser = {
      userUID: newUserTank,
    };
    reference2.update(newUser).then((value) => null);
    reference2.child(userUID).update(newUserTank).then((value) => null);
  }

  Widget Dash(
      {required Map tank, required String userUID, required String token}) {
    if (tank['Users'][userUID] != null) {
      //_switchValue = true;
    } else {
      addUserInRealTimeDB(userUID);
    }
    ;
    if (tank['Users'][userUID]['Selected Tank'] != 'None') {
      user = tank['Users'][userUID]['Selected Tank'];
      updateMessageId(token, tank['Notifications'][user]['users']);
    }
    // print('man Switch' + tank['Tanks'][user]['ManSwitch'].toString());
    // print('Water' + tank['Tanks'][user]['Water'].toString());
    // print("UserUID: " + userUID);
    // print("User Name : " + userUID);
    // print("User Data: " + tank['Users'][userUID].toString());
    // print('Parameters' + tank['Parameters']['Tanks'].keys.toList().toString());
    // print("token dash 2" + widget.token);
    // print("Width");
    // print(MediaQuery.of(context).size.width);
    // print("Height");
    // print(MediaQuery.of(context).size.height);

    return tank['Users'][userUID]['Selected Tank'] == 'None'
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.35,
                    bottom: MediaQuery.of(context).size.height * 035),
                child: Column(
                  children: [
                    Text(
                      'No Tank Selected. Add one.',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewDevicePage()));
                          },
                          child: Text(
                            'Add Tank',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        : Column(
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
                  value: tank['Tanks'][user]['Water'].toDouble(),
                  onTap: (value) => {manSwitchChanged(value)},
                  switchValue: tank['Tanks'][user]['ManSwitch'],
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
                      Text(
                        "Water Flow",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
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
                      Text(
                        "Battery",
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
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.04,
                        bottom: MediaQuery.of(context).size.height * 0.04,
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: MediaQuery.of(context).size.width *
                                        0.41,
                                    top: 10,
                                  ),
                                  child: Text("Control Type",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        fontSize: 15,
                                      )),
                                ),
                                Row(
                                  children: [
                                    DropdownButton(
                                      value: _selectedControlType,
                                      onChanged: (String? newValue) {
                                        ctrlTypeChanged(newValue!);
                                      },
                                      dropdownColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      underline: Container(),
                                      items: <String>['Manual', 'Auto']
                                          .map<DropdownMenuItem<String>>(
                                        (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4),
                                              child: Text(value,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                    fontSize: 20,
                                                  )),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UsagePage(
                                  tankName: user,
                                )),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width * 0.025,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.025),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.trending_up,
                              size: 40,
                            ),
                            Text(
                              "Usage",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            )
                          ],
                        )),
                  )
                ],
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    print("Token dash 1: " + widget.token);
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

                  return Dash(
                      tank: tank, userUID: widget.userUid, token: widget.token);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
