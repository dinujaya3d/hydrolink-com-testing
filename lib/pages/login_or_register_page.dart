import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hydrolink_testing/pages/login.dart';
import 'package:hydrolink_testing/pages/signup.dart';

class LoginOrRegisterPage extends StatefulWidget {
  final String token;
  const LoginOrRegisterPage({super.key, required this.token});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // initially show login page
  bool showLoginPage = true;

  // toggle between login and register pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages, token: widget.token);
    } else {
      return SignupPage(
        onTap: togglePages,
      );
    }
  }
}
