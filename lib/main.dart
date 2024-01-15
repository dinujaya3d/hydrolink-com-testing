import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrolink_testing/firebase_options.dart';
//import 'package:hydrolink/components/percentage.dart';
import 'package:hydrolink_testing/pages/HomePage.dart';
import 'package:hydrolink_testing/pages/auth_page.dart';
//import 'package:hydrolink_testing/pages/login.dart';
//import 'package:hydrolink_testing/pages/signup.dart';
import 'package:hydrolink_testing/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
