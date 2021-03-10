import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_project/mobileview/components/main_title_widget.dart';

class UpcomingCourse extends StatefulWidget {
  @override
  _UpcomingCourseState createState() => _UpcomingCourseState();
}

class _UpcomingCourseState extends State<UpcomingCourse> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -100,
          child: Icon(
            FontAwesomeIcons.circle,
            size: 150.0,
            color: Colors.lightBlue[200],
          ),
        ),
        Positioned(
          top: 100,
          left: -100,
          child: Icon(
            Icons.circle,
            size: 150.0,
            color: Colors.pinkAccent,
          ),
        ),
        Positioned(
          bottom: 10,
          left: 100,
          child: Icon(
            Icons.circle,
            size: 120.0,
            color: Colors.lime,
          ),
        ),
        Positioned(
          top: 80,
          right: 50,
          child: Icon(
            Icons.circle,
            size: 180.0,
            color: Colors.lightBlue,
          ),
        ),
        Positioned(
            top: 0,
            right: 40,
            child: Text(
              '°',
              style: TextStyle(fontSize: 80, color: Colors.yellow),
            )),
        Positioned(
          top: 50,
          right: 15,
          child: Transform.rotate(
              angle: -170.2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                height: 10.0,
                width: 70.0,
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainTitleWidget(
                title: "Upcoming Courses",
              ),
              SizedBox(
                height: 40.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('course').snapshots(),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Loading.....");
                        } else {
                          final messages = snapshot.data.docs;
                          List<UpcomingCoursesImages> bubbles = [];
                          for (var message in messages) {
                            final messageImage = message.data()['img'];
                            final bubble = UpcomingCoursesImages(
                              imagePath: messageImage,
                            );
                            // Text('$messageText from $messageSender');
                            bubbles.add(bubble);
                          }
                          return Wrap(
                            children: bubbles,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UpcomingCoursesImages extends StatelessWidget {
  UpcomingCoursesImages({this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          height: 200.0,
          child: Image(
            image: NetworkImage('$imagePath'),
          ),
        ),
      ),
    );
  }
}
