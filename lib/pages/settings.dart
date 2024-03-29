import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydrolink_testing/pages/NewDevicePage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late User userFire; // Declare userFire with late keyword
  String nameUser = '';

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    userFire = FirebaseAuth.instance.currentUser!;
    nameUser = userFire.displayName!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
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
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.075,
              bottom: MediaQuery.of(context).size.height * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Account Information
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Account Logo
                    CircleAvatar(
                      child: Icon(Icons.person),
                      radius: 40,
                    ),
                    SizedBox(height: 16),
                    // User Name
                    Text(
                      nameUser,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    // User Email
                    Text(
                      'johndoe@example.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Connected Text
                    Text(
                      'Connected',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              // Change Account Information
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'Change Account Information',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                onTap: () {
                  // TODO: Implement change account information functionality
                  signUserOut();
                },
              ),
              // Connect a New Device
              ListTile(
                leading: Icon(Icons.devices),
                title: Text(
                  'Connect a New Device',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                onTap: () {
                  // TODO: Implement connect new device functionality
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewDevicePage()));
                },
              ),
              // Check for Connectivity
              ListTile(
                leading: Icon(Icons.wifi),
                title: Text(
                  'Check for Connectivity',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                onTap: () {
                  // TODO: Implement connectivity check functionality
                },
              ),
              // Set Water Levels
              ListTile(
                leading: Icon(Icons.opacity),
                title: Text(
                  'Set Water Levels',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                onTap: () {
                  // TODO: Implement set water levels functionality
                },
              ),
              // Change Language
              ListTile(
                leading: Icon(Icons.language),
                title: Text(
                  'Change Language',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                onTap: () {
                  // TODO: Implement change language functionality
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
