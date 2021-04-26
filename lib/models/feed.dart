import 'package:flutter/foundation.dart';

class Feed {
  final String story;
  final String id;
  // ignore: non_constant_identifier_names
  final String message;
  final DateTime date;

  Feed({
    this.story,
    @required this.message,
    @required this.id,
    @required this.date,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      story: json['story'] as String,
      id: json['id'] as String,
      message: json['message'] as String,
      date: json['date'] as DateTime,
    );
  }
}
