import 'package:flutter/material.dart';

class ListViewSeperator extends StatelessWidget {
  final String text;
  ListViewSeperator({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        "Dilivery Date: " + text,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
      ),
    );
  }
}
