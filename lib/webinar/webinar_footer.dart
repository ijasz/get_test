import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/desktopview/Components/ocean_icons.dart';

class WebinarFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(color: Colors.grey[200], boxShadow: [
        // BoxShadow(
        //     color: Colors.black.withOpacity(0.2),
        //     blurRadius: 6,
        //     offset: Offset(0, -3))
      ]),
      child: Row(
        children: [
          Spacer(),
          Container(
            width: 350,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Ocean.oa,
                  size: 40,
                  color: Colors.blue,
                ),
                Text(
                  'ocean academy',
                  style: TextStyle(
                      fontFamily: 'Ubuntu',
                      inherit: false,
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Spacer(
            flex: 11,
          ),
          Container(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    'Terms',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                ),
                TextButton(
                  child: Text(
                    'Privacy',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                ),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.facebookF,
                      size: 20,
                    ),
                    splashRadius: 20,
                    color: Colors.grey[700],
                    onPressed: () {}),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.googlePlusG,
                      size: 20,
                    ),
                    splashRadius: 20,
                    color: Colors.grey[700],
                    onPressed: () {}),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.twitter,
                      size: 20,
                    ),
                    splashRadius: 20,
                    color: Colors.grey[700],
                    onPressed: () {}),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.linkedinIn,
                      size: 20,
                    ),
                    splashRadius: 20,
                    color: Colors.grey[700],
                    onPressed: () {}),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
