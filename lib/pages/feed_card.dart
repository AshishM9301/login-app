import 'package:flutter/cupertino.dart';

class FeedCard extends StatelessWidget {
  final text;

  FeedCard(@required this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      height: 40,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Text(text),
    );
  }
}
