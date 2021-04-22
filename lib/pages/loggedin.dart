import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    print('/n ${user.providerData.single.providerId} /n');

    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 8,
          ),
          Text(
            'Logged In',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 25,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoURL),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Name: ' + user?.displayName,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Email: ' + user.email,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                user.providerData.single.providerId == 'google.com'
                    ? provider.googleLogout()
                    : provider.facebookLogout();
              },
              child: Text('Logout'))
        ],
      ),
    );
  }
}
