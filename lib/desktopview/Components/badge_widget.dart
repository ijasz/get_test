import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/constants.dart';

class BadgeWidget extends StatelessWidget {
  final IconData icon;
  final String heading, title;
  BadgeWidget({this.icon, this.heading, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          Icon(
            icon,
            size: 50.0,
            color: textColor,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            heading,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: textColor,
              fontFamily: kfontname,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            title,
            style: otherSmallContentTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
    );
  }
}
