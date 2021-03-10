import 'package:flutter/material.dart';
import 'package:ocean_project/mobileview/constants.dart';

class MainTitleWidget extends StatelessWidget {
  final String title;
  MainTitleWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    alignment: Alignment.centerLeft,
                    width: 800.0,
                    height: 15,
                    color: Colors.grey[200],
                  ),
                ),
                Positioned(
                  child: Container(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontFamily: kfontname),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
