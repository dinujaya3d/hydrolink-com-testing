import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:hydrolink8/screens/hidden_drawer.dart';
import 'package:hydrolink_testing/pages/HomePage.dart';
import 'package:hydrolink_testing/pages/login.dart';
import 'package:hydrolink_testing/pages/login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginOrRegisterPage();
          }
        }),
      ),
    );
  }
}
