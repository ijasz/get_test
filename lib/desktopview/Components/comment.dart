import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/constants.dart';

class TextWidget extends StatelessWidget {
  final String title;
  TextWidget({this.title});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 200.0),
        child: Text(
          title,
          style: contentTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
