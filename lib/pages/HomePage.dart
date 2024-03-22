import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hydrolink_testing/pages/NewDevicePage.dart';
import 'package:hydrolink_testing/pages/dashboard.dart';
import 'package:hydrolink_testing/pages/settings.dart';

class HomePage extends StatefulWidget {
  String token;
  HomePage({super.key, required this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

String _tokenGlobal = '';

class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('Token: $token');
    _tokenGlobal = token! == null ? 'NoToken' : token;
    return token;
  }
}

void getToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String deviceToken = await messaging.getToken() ?? 'null';
  _tokenGlobal = deviceToken == 'null' ? 'No token' : deviceToken;
  print("Token global home page: " + _tokenGlobal);
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  late User userFire; // Declare userFire with late keyword
  late List<Widget> _pages; // Declare _pages with late keyword
  final PushNotificationService _notificationService =
      PushNotificationService();

  @override
  void initState() {
    super.initState();
    userFire =
        FirebaseAuth.instance.currentUser!; // Initialize userFire in initState
    String nameUser = "Unknown User";
    try {
      String nameUser = userFire.displayName!; // Initialize _pages in initState
    } catch (e) {
      String nameUser = userFire.email!; // Initialize _pages in initState
    }
    print(nameUser);
    //FirebaseUser user = FirebaseAuth.getInstance().getCurrentUser();

    print("token global home page: " + widget.token);

    //String name = userFire.getDisplayName();
    _pages = [
      SettingsPage(),
      Dashboard(
          userUid: userFire != null ? userFire.uid : 'No UID',
          token: widget.token),
      // const Center(
      //   child: Text(
      //     "Support",
      //     style: TextStyle(
      //       fontSize: 30,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      NewDevicePage(),
    ];
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _pages[_selectedIndex],
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      bottomNavigationBar: GNav(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        selectedIndex: _selectedIndex,
        tabs: const [
          GButton(
            icon: Icons.settings_applications,
            text: 'Settings',
          ),
          GButton(
            icon: Icons.home,
            text: 'Dashboard',
          ),
          GButton(
            icon: Icons.help_center_rounded,
            text: 'Support',
          ),
        ],
        onTabChange: (value) {
          _navigateBottomBar(value);
        },
      ),
    );
  }
}
