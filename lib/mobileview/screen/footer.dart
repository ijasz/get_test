import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/mobileview/components/material_button.dart';
import 'package:ocean_project/mobileview/constants.dart';

const kbottom = TextStyle(
    color: Colors.white,
    fontSize: 15.0,
    fontWeight: FontWeight.normal,
    fontFamily: kfontname);

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
            color: Color(0xFF004478),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'OCEAN ACADEMY',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: kfontname),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  'Ocean was founded on the principle of building and implementing'
                  ' great ideas that drive progress for the students ond clients',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: kfontname,
                      height: 1.5),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Home",
                      style: kbottom,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "About Us",
                      style: kbottom,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Service",
                      style: kbottom,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Courses",
                      style: kbottom,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Contact Us",
                      style: kbottom,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialFlatButton(
                          icon: FontAwesomeIcons.facebookF,
                          onPressed: () {},
                        ),
                        MaterialFlatButton(
                          icon: FontAwesomeIcons.googlePlusG,
                          onPressed: () {},
                        ),
                        MaterialFlatButton(
                          icon: FontAwesomeIcons.linkedinIn,
                          onPressed: () {},
                        ),
                        MaterialFlatButton(
                          icon: FontAwesomeIcons.twitter,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    Text(
                      '0413-2238675',
                      style: kbottom,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "oceanacademy@gmail.com",
                      style: kbottom,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
