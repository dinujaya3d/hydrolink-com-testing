import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hydrolink_testing/pages/HomePage.dart';
import 'package:hydrolink_testing/pages/login_or_register_page.dart';
import 'package:hydrolink_testing/services/auth_service.dart';

class OtpVerifyPage extends StatefulWidget {
  final String verificationID; // Add this line
  final String token;

  OtpVerifyPage(
      {super.key,
      required this.verificationID,
      required this.token}); // Add this line
  @override
  _OtpVerifyPageState createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  final TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithCredential(AuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);
      // TODO: Navigate to the next screen
    } catch (e) {
      // TODO: Handle sign-in failure
    }
  }

  Future<void> _verifyPhoneNumber(String verificationId, String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: '123456',
    );
    //AuthService().signINwithPhone(verificationId, smsCode);
    await _signInWithCredential(credential);
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _signInWithCredential(credential);
      // TODO: Navigate to the next screen
    } catch (e) {
      // TODO: Handle sign-in with Google failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Enter OTP',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Theme.of(context).colorScheme.onSecondary,
              filled: true,
              showFieldAsBox: true,
              onCodeChanged: (String code) {
                setState(() {
                  otpController.text = otpController.text + code;
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ElevatedButton(
              onPressed: () async {
                try {
                  // TODO: Verify OTP
                  String otp = otpController.text;
                  // TODO: Get the verification ID from previous screen
                  //String verificationId = '';
                  //_verifyPhoneNumber(verificationId, otp);
                  AuthService().signINwithPhone(widget.verificationID, otp);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                token: widget.token,
                              )));
                } catch (e) {
                  print(e.toString());
                }
                ;
              },
              child: Text('Verify OTP'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginOrRegisterPage(token: widget.token)),
                );
              },
              child: Text(
                'Sign In another way!!!',
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: otpController,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 5) {
              FocusScope.of(context).nextFocus();
            }
          } else {
            if (index > 0) {
              FocusScope.of(context).previousFocus();
            }
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
