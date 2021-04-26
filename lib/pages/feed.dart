import 'package:flutter/material.dart';
import 'package:flutter_app/models/feed.dart';
import 'package:flutter_app/pages/feed_card.dart';
import 'package:flutter_app/provider/http_services.dart';

class FacebookFeed extends StatefulWidget {
  final token;
  final id;
  final HttpService httpService = HttpService();

  FacebookFeed({this.token, this.id});

  @override
  _FacebookFeedState createState() => _FacebookFeedState();
}

class _FacebookFeedState extends State<FacebookFeed> {
  var _token;
  var _id;

  @override
  void initState() {
    // TODO: implement initState
    //
    _token = widget.token;
    _id = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: widget.httpService.getPageFeed(_token, _id),
          builder: (BuildContext context, AsyncSnapshot<List<Feed>> snapshot) {
            if (snapshot.hasData) {
              List<Feed> feeds = snapshot.data;
              return Column(
                children: feeds
                    .map<Widget>((Feed feed) => (Card(
                        child: feed.story == null
                            ? FeedCard('${feed.message}')
                            : feed.message == null
                                ? FeedCard('${feed.story}')
                                : FeedCard('Nothing Posted'))))
                    .toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
