import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Google Sign in
  signInwithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    // return await FirebaseAuth.instance.signInWithCredential(credential);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signINwithPhone(String phone, String otp) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: phone,
      smsCode: otp,
    );
    print(otp.toString() + ' ' + phone.toString());

    var credentials =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(otp.toString() + ' ' + credentials.user.toString());
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
