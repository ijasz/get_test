import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/review/stars.dart';

class TrustPilotReview extends StatefulWidget {
  @override
  _TrustPilotReviewState createState() => _TrustPilotReviewState();
}

class _TrustPilotReviewState extends State<TrustPilotReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370.0,
      height: 130,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image(
            image: AssetImage('images/trustpilotReview.png'),
          ),
          Positioned(
            bottom: 0.0,
            left: 10.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stars(
                  iconColor: Colors.white,
                  containerSize: 40.0,
                  iconBgColor: Colors.green,
                  starRating: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
