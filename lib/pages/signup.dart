import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydrolink_testing/pages/login.dart'; // Import the LoginPage

class SignupPage extends StatefulWidget {
  final Function()? onTap;
  SignupPage({super.key, required this.onTap});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String errorMessage = '';
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var _error;

  void signUserUp() async {
    // show loading circle

    // sign user in with email and password
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        // show error message
        setState(() {
          _error = 'Passwords do not match';
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message!;
      });
    }
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
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        //color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                            confirmPasswordController, // Add controller for password field
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onTertiary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Implement sign up functionality
                        signUserUp();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: Text('Sign Up',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .background)),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Text(
                      'Or sign up with',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Spread the icons evenly
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.onTertiary,
                          radius: 30, // Increase the size of the icon
                          child: IconButton(
                            icon: Icon(Icons.g_translate),
                            color: Theme.of(context).colorScheme.background,
                            onPressed: () {
                              // TODO: Implement sign in with Google functionality
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.onTertiary,
                          radius: 30, // Increase the size of the icon
                          child: IconButton(
                            icon: Icon(Icons.facebook),
                            color: Theme.of(context).colorScheme.background,
                            onPressed: () {
                              // TODO: Implement sign in with Facebook functionality
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.onTertiary,
                          radius: 30, // Increase the size of the icon
                          child: IconButton(
                            icon: Icon(Icons.window),
                            color: Theme.of(context).colorScheme.background,
                            onPressed: () {
                              // TODO: Implement sign in with Microsoft functionality
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center the text horizontally
                      children: [
                        Text('Already have an account?'),
                        SizedBox(width: 8.0),
                        TextButton(
                          onPressed: () {
                            widget.onTap!();
                          },
                          child: Text(
                            'Login',
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
