import 'package:flutter/material.dart';
import 'package:ocean_project/mobileview/constants.dart';

class TextWidget extends StatelessWidget {
  final String title;
  TextWidget({this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.justify,
      style:
          TextStyle(fontFamily: kfontname, color: kcontentcolor, height: 1.5),
    );
  }
}
