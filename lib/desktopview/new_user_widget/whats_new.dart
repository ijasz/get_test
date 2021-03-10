import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhatIsNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
          width: 800.0,
          child: Column(
            children: [
              Text(
                'What’s New at Ocean Academy',
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'We release a new platform innovation every month to stay on the leading edge of human transformation. Here’s what’s coming up next for Mindvalley All Access Members.',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            Spacer(),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                width: 400.0,
                child: Column(
                  children: [
                    Text(
                      'Ocean Academy Launches Its Own Private Social Network for Learners',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Coming soon: our human to human matching engine will be able to introduce you to potential friends, partners and even dates with surprising accuracy.",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Image.asset(
                  'assets/images/what\'s new.png',
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
