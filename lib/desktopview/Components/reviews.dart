import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/desktopview/Components/main_title_widget.dart';
import 'package:ocean_project/desktopview/review/reviews.dart';

import 'package:readmore/readmore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

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
    var finding = plus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/oa_bg.png'))),
      padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
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
                height: 50.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 80.0,
                    ),
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
              SizedBox(
                height: 80.0,
              ),
              ReView(),
            ],
          ),
        ],
      ),
    );
  }
}

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
      height: 250.0,
      width: 600.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    child: ReadMoreText(
                      '$content',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      trimLines: 1,
                      colorClickableText: Colors.white,
                      moreStyle: TextStyle(
                        color: Colors.white,
                      ),
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
                  '- $name,$reviewtaken',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
