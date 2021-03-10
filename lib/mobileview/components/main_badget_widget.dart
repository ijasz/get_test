import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/mobileview/components/badge_widget.dart';
import 'package:ocean_project/mobileview/components/comment.dart';
import 'package:ocean_project/text.dart';

import 'main_title_widget.dart';

class MainBadgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MainTitleWidget(
        title: "Our journey through the years",
      ),
      SizedBox(
        height: 10.0,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextWidget(
          title: ourjourneycontent,
        ),
      ),
      Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: BadgeWidget(
                icon: FontAwesomeIcons.award,
                heading: "5500+ Students trained",
                title: ourjourneycontent1,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: BadgeWidget(
                icon: FontAwesomeIcons.award,
                heading: "50+ Free seminars",
                title: ourjourneycontent2,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: BadgeWidget(
                icon: FontAwesomeIcons.award,
                heading: "6 International workshops",
                title: ourjournerycontent3,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
