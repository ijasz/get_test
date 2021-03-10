import 'package:flutter/material.dart';

import '../constants.dart';

class BadgeWidget extends StatelessWidget {
  final IconData icon;
  final String heading, title;
  BadgeWidget({this.icon, this.heading, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40.0,
          color: textColor,
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(
          heading,
          style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: textColor,
              fontFamily: kfontname),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: kfontname, color: kcontentcolor, height: 1.5),
        ),
      ],
    );
  }
}
