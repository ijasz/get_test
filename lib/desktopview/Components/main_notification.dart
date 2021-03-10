import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';

import 'package:ocean_project/desktopview/Components/notification.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/route/routing.dart';

import 'package:provider/provider.dart';

// ignore: camel_case_types
class Notification_onclick extends StatefulWidget {
  Notification_onclick({@required this.isVisible, this.image});

  final bool isVisible;
  final String image;

  @override
  _Notification_onclickState createState() => _Notification_onclickState();
}

// ignore: camel_case_types
class _Notification_onclickState extends State<Notification_onclick> {
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getSession();
    print("${LogIn.registerNumber}gfhcghfhgfrrrrrrrr");
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 45,
      child: Visibility(
        visible: widget.isVisible,
        child: Container(
          // height: 400,
          width: 500,
          decoration: BoxDecoration(
              color: Colors.blue[50],
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 6)
              ],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8))),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                // height: 70,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3,
                      offset: Offset(0, 6))
                ]),
                child: Column(
                  children: [
                    Row(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('new users')
                              .doc(LogIn.registerNumber)
                              .collection("specificnotification")
                              .snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                child: Text(
                                    " there are no notification send for you"),
                              );
                            } else {
                              final messages = snapshot.data.docs;
                              List<UserNotificationDb> notifyData = [];

                              for (var message in messages) {
                                final messageDescription =
                                    message.data()['description'];
                                final sampleNotify = UserNotificationDb(
                                  description: messageDescription,
                                );
                                // Text('$messageText from $messageSender');
                                if (notifyData.length < 1) {
                                  notifyData.add(sampleNotify);
                                }
                              }
                              print("rrrrrrrrrrrrrrrr");
                              print(notifyData);

                              return Column(
                                children: notifyData,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('new users')
                              .doc(LogIn.registerNumber)
                              .collection("notification")
                              .snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                  " there are no notification send for you");
                            } else {
                              final messages = snapshot.data.docs;
                              List<UserNotificationDb> notifyData = [];

                              for (var message in messages) {
                                final messageDescription =
                                    message.data()['description'];
                                final sampleNotify = UserNotificationDb(
                                  description: messageDescription,
                                );
                                // Text('$messageText from $messageSender');
                                if (notifyData.length < 1) {
                                  notifyData.add(sampleNotify);
                                }
                              }
                              return Column(
                                children: notifyData,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('new users')
                              .doc(LogIn.registerNumber)
                              .collection("Subject Notification")
                              .snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                  " there are no notification send for you");
                            } else {
                              final messages = snapshot.data.docs;
                              List<UserNotificationDb> notifyData = [];

                              for (var message in messages) {
                                final messageDescription =
                                    message.data()['description'];
                                final sampleNotify = UserNotificationDb(
                                  description: messageDescription,
                                );
                                // Text('$messageText from $messageSender');
                                if (notifyData.length < 1) {
                                  notifyData.add(sampleNotify);
                                }
                              }
                              return notifyData.isNotEmpty
                                  ? Column(
                                      children: notifyData,
                                    )
                                  : Text("theare are no notification");
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                child: Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                minWidth: 200,
                color: Colors.blue[100],
                onPressed: () {
                  setState(() {
                    ContentWidget.isVisible = !ContentWidget.isVisible;
                  });
                  print("isCheckCourse${CoursesView.isCheckCourse}");
                  Provider.of<SyllabusView>(context, listen: false)
                      .updateCourseSyllabus(routing: User());
                  Provider.of<CourseProvide>(context, listen: false)
                      .updateCourseName(routing: CourseList(), isCheck: false);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserNotificationDb extends StatefulWidget {
  String description;
  UserNotificationDb({this.description});
  @override
  _UserNotificationDbState createState() => _UserNotificationDbState();
}

class _UserNotificationDbState extends State<UserNotificationDb> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          // height: 100,
          // width: 100,
          child: Image.asset(
            "images/alert.png",
            width: 100,
          ),
        ),
        Container(
          width: 350,
          child: Text(
            "${widget.description}dsdfdsfdfsd",
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            // softWrap: true,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
