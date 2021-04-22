import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Setup/Signin.dart';
import 'package:flutter_app/pages/loggedin.dart';
import 'package:flutter_app/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key key, @required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);

            print('kujhsand ${provider.isFacebookSignIn}');

            if (provider.isSigningIn || provider.isFacebookSignIn) {
              print('Hello');
              return buildLoading();
            } else if (snapshot.hasData) {
              print(snapshot);
              return LoggedInWidget();
            } else {
              return LoginPage();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() => Center(
        child: CircularProgressIndicator(),
      );
}
