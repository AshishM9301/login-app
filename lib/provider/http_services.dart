import 'package:flutter_app/models/feed.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class HttpService {
  Future<List<Feed>> getPageFeed(token, id) async {
    String _token = token;
    final _url = Uri.https(
        'graph.facebook.com', '/${id}/feed', {'access_token': _token});

    final rlData = await http.get(_url);

    final data = JSON.jsonDecode(rlData.body);
    print(data);

    List<dynamic> res = data['data'];

    List<Feed> feeds = res
        .map(
          (dynamic item) => Feed.fromJson(item),
        )
        .toList();

    return feeds;
  }
}
