import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ocean_project/desktopview/Components/courses_widget.dart';
import 'package:ocean_project/desktopview/Components/my_course.dart';
import 'package:ocean_project/desktopview/Components/payment.dart';
import 'package:ocean_project/desktopview/Components/thanks_purchasing.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';

import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/about_us_screen.dart';
import 'package:ocean_project/desktopview/screen/courses.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseDetails extends StatefulWidget {
  String course;
  String trainer;
  String sess;
  String desc;
  String batch;
  String section;
  String chapter;

  CourseDetails({this.course, this.sess, this.trainer, this.desc, this.batch});

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  // void subMessage() async {
  //   final message = await _firestore
  //       .collection('course')
  //       .doc('4dLAoNlHzfdUeT2Gkwk6')
  //       .collection("syllabus")
  //       .get();
  //   for (var courses in message.docs) {
  //     print(courses.data());
  //   }
  //   // print(syllabus);
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // subMessage();
  // }

  String syllabusid;

  void studentId() async {
    await for (var snapshot in _firestore
        .collection('course')
        .where("coursename", isEqualTo: widget.course)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        //print(message.documentID);
        syllabusid = message.id;

        print("${syllabusid}iiii");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentId();
  }

  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 260.0,
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.0, vertical: 60.0),
                  color: Color(0xff004B71),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Provider.of<Routing>(context, listen: false)
                                    .updateRouting(widget: Course());
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ),
                          ),
                          Text(
                            'Online Course',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                      Text(
                        '${widget.course} Certificate Development Course',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Provider.of<Routing>(context, listen: false)
                              .updateRouting(widget: AboutUs());
                        },
                        child: Text(
                          '${widget.trainer}',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Online Course',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.dashboard,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '${widget.sess} Session',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20.0),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.video,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'By Zoom',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100.0, vertical: 60.0),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CourseDetailsHeadingText(
                                      title: 'Course Details'),
                                  SizedBox(height: 30.0),
                                  Container(
                                    width: 1100.0,
                                    child: Text(
                                      "${widget.desc}",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey[700]),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1100,
                          padding: EdgeInsets.symmetric(horizontal: 100.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CourseDetailsHeadingText(
                                title: 'Table Of Contents',
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: _firestore
                                    .collection('course')
                                    .doc(widget.batch)
                                    .collection('syllabus')
                                    .snapshots(),
                                // ignore: missing_return
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("Loading........");
                                  } else {
                                    final messages = snapshot.data.docs;
                                    List<CourseDescription> courseDetails = [];
                                    print("${syllabusid}tjtjtjtj");
                                    String messageContent;
                                    //List<String> subjects = [];
                                    for (var message in messages) {
                                      List<Widget> chapterWidget = [];
                                      // if (message.data()['coursename'] ==
                                      //     widget.course) {
                                      final messageText =
                                          message.data()[widget.trainer];
                                      final messageSender =
                                          message.data()[widget.course];
                                      final messageSession =
                                          message.data()[widget.sess];
                                      final messageCoursedescription =
                                          message.data()[widget.desc];
                                      final messageTopic =
                                          message.data()['section'];
                                      for (var i = 0;
                                          i < message.data()["chapter"].length;
                                          i++) {
                                        if ((chapterWidget == null)) {
                                          return Container(
                                            height: 700,
                                            width: 500,
                                            color: Colors.pinkAccent,
                                          );
                                        } else {
                                          messageContent =
                                              message.data()["chapter"][i];
                                          chapterWidget.add(
                                            Container(
                                              color: Colors.grey[100],
                                              padding: EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      messageContent,
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                          print(messageContent);
                                          print("${widget.batch}iiii");
                                        }
                                      }

                                      final messageDubble = CourseDescription(
                                        trainername: messageText,
                                        coursename: messageSender,
                                        session: messageSession,
                                        coursedescription:
                                            messageCoursedescription,
                                        topic: messageTopic,
                                        chapterWidget: chapterWidget,
                                      );
                                      courseDetails.add(messageDubble);
                                      // subjects.add(message.data()["coursename"]);
                                      // print(subjects);
                                      print(messages);
                                      // }
                                    }
                                    return Column(
                                      children: courseDetails,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: OnlineCourse.visiblity,
              child: Positioned(
                top: 100,
                right: 100.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 530.0,
                    width: 500.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 30.0,
                          ),
                        ]),
                    child: Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore.collection('course').snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Loading.....");
                            } else {
                              final messages = snapshot.data.docs;
                              List<VisibleWidget> courseImage = [];
                              //List<String> subjects = [];
                              for (var message in messages) {
                                if (message.data()['coursename'] ==
                                    widget.course) {
                                  final courseRate = message.data()['rate'];
                                  final contentImage = message.data()['img'];
                                  final messageCourse =
                                      message.data()['coursename'];
                                  final courseBatchid =
                                      message.data()['batchid'];
                                  final imageContent1 = message.data()['time'];
                                  final imageContent2 = message.data()['date'];

                                  final imageContent3 =
                                      message.data()['duration'];

                                  final images = VisibleWidget(
                                    image: contentImage,
                                    collection1: imageContent1,
                                    collection2: imageContent2,
                                    collection3: imageContent3,
                                    rupees: courseRate,
                                    courseName: messageCourse,
                                    batchid: courseBatchid,
                                  );

                                  courseImage.add(images);
                                }
                              }

                              print("${widget.course} jaya");
                              return Column(
                                children: courseImage,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//style: TextStyle(fontSize: 20.0),
class CourseDescription extends StatelessWidget {
  String coursename;
  String trainername;
  String session;
  String coursedescription;
  String topic;
  List<Widget> chapterWidget = [];

  CourseDescription({
    this.coursename,
    this.trainername,
    this.session,
    this.coursedescription,
    this.topic,
    this.chapterWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 20.0,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black, width: 1.0)),
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          child: Column(
            children: [
              ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$topic",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                children: chapterWidget,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}

class CourseDetailsHeadingText extends StatelessWidget {
  CourseDetailsHeadingText({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700]),
      ),
    );
  }
}

class VisibleWidget extends StatefulWidget {
  String courseName;
  String batchid;
  String image;
  String collection1;
  String collection2;
  String collection3;
  String rupees;

  VisibleWidget(
      {this.collection1,
      this.image,
      this.collection2,
      this.collection3,
      this.rupees,
      this.courseName,
      this.batchid});

  @override
  _VisibleWidgetState createState() => _VisibleWidgetState();
}

class _VisibleWidgetState extends State<VisibleWidget> {
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("${widget.courseName}"),
          content: Container(
            height: 670,
            width: 400,
            child: RazorPayWeb(
              amount: widget.rupees,
              courseImage: widget.image,
              courseName: widget.courseName,
              course: [widget.courseName],
              batchid: [widget.batchid],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context1).pop();
              },
            ),
          ],
        );
      },
    );
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                // width: 500,
                height: 260,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    image: NetworkImage('${widget.image}'),
                    fit: BoxFit.cover,

                    // height: 100.0,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.rupeeSign),
                      Text(
                        '${widget.rupees}',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  RawMaterialButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      'Enroll Now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.blue),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.blue, width: 2.0)),
                    onPressed: () async {
                      print("OALIVE ${OALive.stayUser}");
                      var userSession = await _firestore
                          .collection('new users')
                          .doc(OALive.stayUser != null
                              ? OALive.stayUser
                              : LogIn.registerNumber)
                          .get();
                      print(userSession.data());
                      //print(OT)

                      if (userSession.data() != null) {
                        setState(() {
                          isLogin = true;
                        });
                        _showDialog();
                      } else {
                        Provider.of<Routing>(context, listen: false)
                            .updateRouting(widget: LogIn());
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.timelapse,
                    color: Colors.blue,
                    size: 22.0,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Time',
                    style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                    child: Text(
                      '${widget.collection1}',
                      style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.date_range,
                    color: Colors.blue,
                    size: 20.0,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Date',
                    style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                    child: Text(
                      '${widget.collection2}',
                      style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.time_to_leave,
                    color: Colors.blue,
                    size: 20.0,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hours',
                    style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                    child: Text(
                      '${widget.collection3}',
                      style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
