import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/page_list.dart';
import 'package:flutter_app/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class LoggedInWidget extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  void startFacebookFeed(BuildContext ctx) async {
    final provider = Provider.of<GoogleSignInProvider>(ctx, listen: false);

    final token = provider.facebookToken;

    final url = Uri.https(
        'graph.facebook.com', '/me/accounts', {'access_token': token});

    final rlData = await http.get(url);

    final data = JSON.jsonDecode(rlData.body);
    print('Data rendered ${data}');

    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return PageList(
            data: data[0],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
            'Email: ' + user.providerData.single?.email,
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
            child: Text('Logout'),
          ),
          user.providerData.single.providerId == 'facebook.com'
              ? RaisedButton(
                  onPressed: () => startFacebookFeed(context),
                  child: Text('Page Posts'),
                )
              : Text(
                  user.providerData.single.providerId,
                  style: TextStyle(color: Colors.grey),
                ),
        ],
      ),
    );
  }
}
