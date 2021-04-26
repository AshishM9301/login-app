import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSigningIn;
  bool _isFacebookSignIn;
  String facebookToken;

  GoogleSignInProvider() {
    _isSigningIn = false;
    _isFacebookSignIn = false;
  }

  bool get isSigningIn => _isSigningIn;
  bool get isFacebookSignIn => _isFacebookSignIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  set isFacebookSignIn(bool isFacebookSignIn) {
    _isFacebookSignIn = isFacebookSignIn;
    notifyListeners();
  }

  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();

    print(user);

    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      print('mn ${credential}');

      await FirebaseAuth.instance.signInWithCredential(credential);

      isSigningIn = false;
    }
  }

  void logout() async {
    FirebaseAuth.instance.signOut();
  }

  void googleLogout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future facebookLogin() async {
    isFacebookSignIn = true;

    final result = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']);

    switch (result.status) {
      case LoginStatus.success:
        print('There you got here');

        facebookToken = result.accessToken.token;

        final AuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken.token);
        // Once signed in, return the UserCredential
        //

        await FirebaseAuth.instance.signInWithCredential(credential);

        print('kjuweashdnfl ${isFacebookSignIn}');

        isFacebookSignIn = false;

        break;

      case LoginStatus.cancelled:
        isFacebookSignIn = false;
        print('Cancelled By user');
        break;
      case LoginStatus.failed:
        isFacebookSignIn = false;
        print('Error');
        break;

      default:
        break;
    }
  }

  getFacebookToken() async {
    return facebookToken;
  }

  void facebookLogout() async {
    await FacebookAuth.instance.logOut();
    FirebaseAuth.instance.signOut();
  }
}
