import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/comment.dart';
import 'package:ocean_project/text.dart';

import 'badge_widget.dart';
import 'main_title_widget.dart';

class MainBadgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: Color(0xFFF7F7F7),
        child: Column(children: [
          SizedBox(
            height: 30.0,
          ),
          MainTitleWidget(
            title: "Our journey through the years",
          ),
          SizedBox(
            height: 30.0,
          ),
          TextWidget(
            title: ourjourneycontent,
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: BadgeWidget(
                    icon: Icons.account_balance,
                    heading: "5500+ Students trained",
                    title: ourjourneycontent2,
                  ),
                ),
                Expanded(
                  child: BadgeWidget(
                    icon: Icons.account_balance,
                    heading: "50+ Free seminars",
                    title: ourjournerycontent3,
                  ),
                ),
                Expanded(
                  child: BadgeWidget(
                    icon: Icons.account_balance,
                    heading: "6 International workshops",
                    title: ourjourneycontent4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ]),
      ),
    );
  }
}
