import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ocean_project/mobileview/constants.dart';
import 'package:ocean_project/text.dart';

class SliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 250,
      color: Color(0xff006a97),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: -300,
            child: Transform.rotate(
              angle: -1,
              child: Container(
                color: Color(0xff0091D2),
                height: 300.0,
                width: 600.0,
              ),
            ),
          ),
          Positioned(
            right: -150,
            child: Container(
              child: Icon(
                Icons.circle,
                size: 270.0,
                color: Color(0xff069bdb),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  homepageheading,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: (18.0 / 720) * MediaQuery.of(context).size.height,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: kfontname,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  homepagecontent,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontFamily: kfontname, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
