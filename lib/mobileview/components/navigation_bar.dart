import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/mobileview/constants.dart';
import 'ocean_icons.dart';

class TopNavigationBar extends StatelessWidget {
  final String title;
  TopNavigationBar({this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Color(0xff0091D2),
          height: 130,
          width: double.infinity,
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 50),
          child: Center(
            child: AutoSizeText(
              title,
              maxLines: 1,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                wordSpacing: 1.8,
                fontFamily: kfontname,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Icon(
            Icons.circle,
            size: 35,
            color: Color(0xffBFD400),
          ),
        ),
        Positioned(
          top: 50,
          left: 30,
          child: Icon(
            Icons.circle,
            size: 35,
            color: Color(0xffF8BE5A),
          ),
        ),
        Positioned(
          top: 80,
          left: 68,
          child: Icon(
            Ocean.line_circleshape,
            size: 40,
            color: Color(0xffFFD444),
          ),
        ),
        Positioned(
          top: 5,
          right: 15,
          child: Icon(
            Icons.circle,
            size: 35,
            color: Color(0xffBFD400),
          ),
        ),
        Positioned(
          top: 50,
          right: 40,
          child: Icon(
            Icons.circle,
            size: 35,
            color: Color(0xffF8BE5A),
          ),
        ),
        Positioned(
          top: 45,
          right: 1,
          child: Transform.rotate(
            angle: -0.3,
            child: Icon(
              Ocean.a,
              size: 32,
              color: Color(0xff00FFB9),
            ),
          ),
        ),
        Positioned(
          top: 90,
          right: 17,
          child: Transform.rotate(
            angle: -0.3,
            child: Icon(
              Ocean.a,
              size: 35,
              color: Color(0xffFF00FF),
            ),
          ),
        ),
        Positioned(
          top: 80,
          right: 70,
          child: Icon(
            Ocean.line_circleshape,
            size: 40,
            color: Color(0xffFFD444),
          ),
        )
      ],
    );
  }
}
