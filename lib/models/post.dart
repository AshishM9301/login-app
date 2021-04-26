import 'package:flutter/foundation.dart';

class PostFeed {
  final String name;
  final String id;
  // ignore: non_constant_identifier_names
  final String access_token;
  final String body;

  PostFeed({
    @required this.name,
    @required this.access_token,
    @required this.id,
    @required this.body,
  });

  factory PostFeed.fromJson(Map<String, dynamic> json) {
    return PostFeed(
      name: json['name'] as String,
      id: json['id'] as String,
      access_token: json['access_token'] as String,
      body: json['body'] as String,
    );
  }
}
