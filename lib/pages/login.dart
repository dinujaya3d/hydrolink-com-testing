import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydrolink_testing/pages/phoneNum.dart';
import 'package:hydrolink_testing/services/auth_service.dart';
import 'signup.dart'; // Import the SignupPage

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  final String token;
  LoginPage({super.key, required this.onTap, required this.token});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errorMessage = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var _error;
  bool buttonClicked = false;

  void signUserIn() async {
    // show loading circle

    // sign user in with email and password
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message!;
      });
    }
  }

  void setButtonClicked(bool value) {
    setState(() {
      buttonClicked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  right: MediaQuery.of(context).size.width * 0.03,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to Hydrolink',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.onSecondary),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller:
                            emailController, // Add controller for email field
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: InputBorder.none,
                          fillColor: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.onSecondary),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller:
                            passwordController, // Add controller for password field
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password functionality
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (_) {
                        setButtonClicked(true);
                      },
                      onTapUp: (_) {
                        setButtonClicked(false);
                      },
                      onTapCancel: () {
                        setButtonClicked(false);
                      },
                      onTap: signUserIn,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        //margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: buttonClicked
                              ? Theme.of(context)
                                  .colorScheme
                                  .onTertiary
                                  .withOpacity(0.6)
                              : Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: buttonClicked
                              ? [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    offset: Offset(3, 3),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    offset: Offset(-3, -3),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    offset: Offset(6, 6),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    offset: Offset(-6, -6),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                ],
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.background,
                              fontWeight: FontWeight.bold,
                              //fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Spread the icons evenly
                      children: [
                        GestureDetector(
                          onTap: () => AuthService().signInwithGoogle(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: buttonClicked
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onTertiary
                                      .withOpacity(0.6)
                                  : Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(
                                  30), // Updated border radius
                              boxShadow: buttonClicked
                                  ? [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        offset: Offset(3, 3),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        offset: Offset(-3, -3),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        offset: Offset(6, 6),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        offset: Offset(-6, -6),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                    ],
                            ),
                            child: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                radius: 30, // Increase the size of the icon
                                child: Image.asset(
                                  'lib/assets/google.png',
                                  height: 45,
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => {},
                          child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onTertiary,
                              radius: 30, // Increase the size of the icon
                              child: Image.asset(
                                'lib/assets/facebook.png',
                                height: 50,
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhoneNumPage(
                                  token: widget.token,
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onTertiary,
                              radius: 30, // Increase the size of the icon
                              child: Image.asset(
                                'lib/assets/phone.png',
                                height: 50,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not signed in yet?'),
                        SizedBox(width: 8.0),
                        TextButton(
                          onPressed: () {
                            widget.onTap!();
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
