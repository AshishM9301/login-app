import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/feed.dart';
import 'package:flutter_app/models/post.dart';
import 'package:flutter_app/pages/feed.dart';
import 'package:flutter_app/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class PageList extends StatefulWidget {
  var data;
  PageList({this.data});

  @override
  _PageListState createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  bool loading = false;
  var _data;
  var res;
  @override
// ignore: must_call_super
  void initState() {
    _data = widget.data;
  }

  Future<List<PostFeed>> _getAdminPageData() async {
    String _token =
        'EAAXwHr7r2YcBAKbCa9Wk3lJlGU8yeMOMS0ylety8V1NZAaNs2UmxQ6NBS4dZCX0Amt90ouZCFuCRo6liKIfQxalTNyJZBlMZBVzYrBBvE40i3A4y2yg8TfNnBuJjZAfLlG2fOOYOfqphinM4fBtqjHsQqw0zgKbZCBX5sZAomnjbhSSVRN25hxQFypz5epqKZCZAHotLQiXd4HawZDZD';

    final url = Uri.https(
        'graph.facebook.com', '/me/accounts', {'access_token': _token});

    final rlData = await http.get(url);

    final data = JSON.jsonDecode(rlData.body);

    print('Data of data ::: ${data['data']}');

    List<dynamic> body = data['data'];

    List<PostFeed> posts = body
        .map(
          (dynamic item) => PostFeed.fromJson(item),
        )
        .toList();

    print('${posts}');

    setState(() {
      _data = posts;
    });

    print('Hello :::::: ${_data}');

    print('Post //// ${data['data'][0]['name']}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      alignment: Alignment.center,
      child: ListView(
        children: [
          _data == null
              ? Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Empty',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        onPressed: _getAdminPageData,
                        child: Text('See Admin Pages & Post'),
                      )
                    ],
                  ))
              : Container(
                  child: Column(
                    children: _data
                        .map<Widget>(
                          (PostFeed postFeed) => Card(
                            margin: EdgeInsets.all(10),
                            child: Container(
                                width: 200,
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FacebookFeed(
                                                  token: postFeed.access_token,
                                                  id: postFeed.id,
                                                )))
                                  },
                                  child: Text('${postFeed.name}'),
                                )),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ],
      ),
    );
  }
}
