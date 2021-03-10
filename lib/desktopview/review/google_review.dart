import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/review/stars.dart';

class GoogleReview extends StatefulWidget {
  @override
  _GoogleReviewState createState() => _GoogleReviewState();
}

class _GoogleReviewState extends State<GoogleReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: AssetImage('images/googleReview.png'),
            width: 300,
          ),
          Positioned(
            bottom: 5.0,
            right: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student Review',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700]),
                ),
                Stars(
                  iconColor: Colors.green,
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
