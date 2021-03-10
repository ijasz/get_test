import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/mobileview/components/main_title_widget.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

final _firestore = FirebaseFirestore.instance;

class ReviewsSection extends StatefulWidget {
  @override
  _ReviewsSectionState createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  void plus() {
    List<Color> choice = [
      Colors.green[300],
      Colors.purple[300],
      Colors.blue[300],
      Colors.green,
    ];
    for (int i = 0; i <= choice.length - 1; i++) {
      if (i % choice.length == 0) {
        print(choice[i]);
      } else if (i % choice.length == 1) {
        print(choice[i]);
      } else if (i % choice.length == 2) {
        print(choice[i]);
      } else if (i % choice.length == 3) {
        print(choice[i]);
      }
    }
  }

  @override
  // ignore: must_call_super
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 40,
            left: 0,
            child: Icon(
              Icons.circle,
              size: 200.0,
              color: Colors.red[200],
            ),
          ),
          Positioned(
            right: 100,
            top: 100,
            child: Icon(
              Icons.circle,
              size: 150.0,
              color: Colors.blue[200],
            ),
          ),
          Positioned(
            left: 170,
            top: 10,
            child: Icon(
              Icons.circle,
              size: 50.0,
              color: Colors.deepPurple[400],
            ),
          ),
          Positioned(
            right: 20,
            top: 10,
            child: Icon(
              Icons.circle,
              size: 80.0,
              color: Colors.green[400],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainTitleWidget(
                    title: "Reviews",
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('reviews').snapshots(),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Loading.....");
                        } else {
                          final messages = snapshot.data.docs;
                          int i = 0;
                          List<ReviewLable> reviewContent = [];
                          for (var message in messages) {
                            final userName = message.data()['name'];
                            final userReviewTaken =
                                message.data()['ratingsite'];
                            final userReview = message.data()['content'];
                            final messageReview = ReviewLable(
                              name: userName,
                              reviewtaken: userReviewTaken,
                              content: userReview,
                              color: i % 4 == 0
                                  ? Colors.green[300]
                                  : i % 4 == 1
                                      ? Colors.purple[300]
                                      : i % 4 == 2
                                          ? Colors.blue[300]
                                          : Colors.green[300],
                            );
                            reviewContent.add(messageReview);
                            i = i + 1;
                          }
                          return Row(
                            children: reviewContent,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              // Row(
              //   children: [
              //     StreamBuilder<QuerySnapshot>(
              //       stream: _firestore.collection('ratings').snapshots(),
              //       // ignore: missing_return
              //       builder: (context, snapshot) {
              //         if (!snapshot.hasData) {
              //           return Text("Loading.....");
              //         } else {
              //           final messages = snapshot.data.docs;
              //           List<StarRating> rateReview = [];
              //
              //           for (var message in messages) {
              //             final userReviewSite = message.data()['ratingsite'];
              //             final userReviewCount = message.data()['rate'];
              //             final rating = StarRating(
              //               ratingSite: userReviewSite,
              //               ratings: userReviewCount,
              //             );
              //             // Text('$messageText from $messageSender');
              //             rateReview.add(rating);
              //           }
              //           return Wrap(
              //             children: rateReview,
              //           );
              //         }
              //       },
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ReviewLable extends StatelessWidget {
  ReviewLable({this.color, this.content, this.name, this.reviewtaken});
  final Color color;
  String name;
  String content;
  String reviewtaken;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      height: 200.0,
      width: 300.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    FontAwesomeIcons.quoteRight,
                    color: Colors.white,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        '$content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    FontAwesomeIcons.quoteRight,
                    color: Colors.white,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '- $name, $reviewtaken',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  StarRating({this.ratings, this.ratingSite});
  final String ratings;
  final String ratingSite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.yellow,
          height: 350,
        ),
        Container(
          height: 150.0,
          width: 150.0,
          decoration: BoxDecoration(
            color: Color(0xff4285B7),
            borderRadius: BorderRadius.circular(75.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$ratings",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 190.0, bottom: 50.0),
          child: Icon(
            Icons.star_half,
            color: Colors.yellow[700],
            size: 40,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 130.0, bottom: 160.0),
          child: Icon(
            Icons.star,
            color: Colors.yellow[700],
            size: 40,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 200.0),
          child: Icon(
            Icons.star,
            color: Colors.yellow[700],
            size: 40,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 130.0, bottom: 160.0),
          child: Icon(
            Icons.star,
            color: Colors.yellow[700],
            size: 40,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 190.0, bottom: 50.0),
          child: Icon(
            Icons.star,
            color: Colors.yellow[700],
            size: 40,
          ),
        ),
        Positioned(
          top: 250.0,
          child: Column(
            children: [
              Text(
                '$ratingSite',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color(0xff003A5D),
                ),
              ),
              SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {},
                  starCount: 5,
                  rating: 4.9,
                  size: 40.0,
                  isReadOnly: true,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  color: Colors.yellow[700],
                  borderColor: Colors.yellow[700],
                  spacing: 0.0),
            ],
          ),
        ),
      ],
    );
  }
}
