import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ocean_project/desktopview/Components/courses_widget.dart';
import 'package:ocean_project/desktopview/Components/enrool_appbar.dart';
import 'package:ocean_project/desktopview/Components/main_notification.dart';

import 'package:ocean_project/desktopview/Components/user_profile.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/course_details.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'zoom_integration.dart';

Map<String, String> courses_icon = {
  'C':
      'https://firebasestorage.googleapis.com/v0/b/ocean-live.appspot.com/o/courses_icon%2Fc.png?alt=media&token=4e2c22c6-8364-4bfc-b49e-d9fdab591bba',
};
final _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class HorizontalMenu extends StatefulWidget {
  List<String> courseList = [];
  static Widget customWidget;
  Map menu = {};
  List<String> batchId = [];
  List<String> courseIcon = [];
  HorizontalMenu({this.courseList, this.menu, this.batchId, this.courseIcon});
  @override
  _HorizontalMenuState createState() => _HorizontalMenuState();
}

class _HorizontalMenuState extends State<HorizontalMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('${widget.courseList} ====================================');
    //HorizontalMenu.customWidget = EnrollNew();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.courseList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10.0),
            child: MouseRegion(
              child: ListTile(
                hoverColor: Colors.white,
                leading: ClipRRect(
                  child: widget.courseIcon[index] != null
                      ? Container(
                          height: 40,
                          width: 40,
                          child: Image.network(
                            widget.courseIcon[index],
                            fit: BoxFit.cover,
                            alignment: Alignment.centerLeft,
                          ),
                        )
                      : Container(
                          height: 40,
                          width: 40,
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/Flask.png?alt=media&token=91bae082-5f81-4372-8d3a-cbf3bc14419a',
                            fit: BoxFit.cover,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                  borderRadius: BorderRadius.circular(500),
                ),
                title: MouseRegion(
                  child: courseEnroll(
                    text: widget.courseList[index],
                    color: widget.menu[index],
                  ),
                ),
                onTap: () {
                  print("welcome batchid ${widget.batchId[index]}");
                  setState(() {
                    widget.menu
                        .updateAll((key, value) => widget.menu[key] = false);
                    widget.menu[index] = true;
                  });
                  Provider.of<SyllabusView>(context, listen: false)
                      .updateCourseSyllabus(
                    routing: ContentWidget(
                      course: widget.courseList[index],
                      batchid: widget.batchId[index],
                      //batchid: "OCNBK08",
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}

Widget courseEnroll({text, color}) {
  return Text(
    text,
    style: TextStyle(
      color: color == true ? Colors.blue : Colors.white,
      fontSize: 20.0,
    ),
  );
}

// ignore: must_be_immutable
class CoursesView extends StatefulWidget {
  static String courseEnroll;
  static String studentname;
  static bool isCheckCourse = true;
  static String studentemail;
  static List batchId = [];
  String course;
  String trainer;
  String sess;
  String desc;
  bool isEnroll = false;
  String userID;
  bool visible;

  CoursesView(
      {this.course,
      this.sess,
      this.trainer,
      this.desc,
      this.userID,
      this.visible});
  @override
  _CoursesViewState createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  void batch_id() async {
    print("---------------------------");
    print("${LogIn.registerNumber}register number");
    await for (var snapshot in _firestore
        .collection('new users')
        .where("Phone Number", isEqualTo: LogIn.registerNumber)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        CoursesView.batchId = message.data()['batchid'];
        print("${CoursesView.batchId}listlistlistttttttttttttttt");
      }
    }
    print("---------------------------");
  }

  bool visibility = true;

  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LogIn.registerNumber = (prefs.getString('user') ?? null);
    userCourses();
    batch_id();
  }

  @override
  void initState() {
    getSession();

    // TODO: implement initState
    super.initState();
  }

  String batchid;
  String test;

  userCourses() async {
    var course = await _firestore
        .collection("new users")
        .doc(LogIn.registerNumber)
        .get();
    CoursesView.courseEnroll = course.data()["First Name"];
    CoursesView.studentemail = course.data()["E Mail"];
    print('${CoursesView.courseEnroll}jjjjjjjjjjj');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: kfontname),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarWidget(),
        ),
        body: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Consumer<CourseProvide>(
                        builder: (context, routing, child) {
                      return routing.routing;
                    }),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Consumer<SyllabusView>(
                        builder: (context, routing, child) {
                      return routing.routing;
                    }),
                  ),
                )
              ],
            ),
            Consumer<UserProfiles>(builder: (context, routing, child) {
              return routing.route;
            }),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ContentWidget extends StatefulWidget {
  static bool isVisible = false;
  static bool isShow = false;
  String course;
  String batchid;
  String trainername;
  String description;
  String duration;
  String startDate;

  ContentWidget(
      {this.course,
      this.batchid,
      this.trainername,
      this.duration,
      this.description,
      this.startDate});

  @override
  _ContentWidgetState createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  String description;
  String trainername;

  userCoursesName() async {
    var course =
        await _firestore.collection("course").doc(widget.batchid).get();
    description = course.data()["coursedescription"];
    trainername = course.data()["trainername"];

    //batchid = course.data()["batchid"];
    print('${description}jjjjjjjjjjjfdgdghhhhhhhhhhhhhhhhhhhhhhhh');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCoursesName();
  }

  @override
  Widget build(BuildContext context) {
    print("OA ${widget.batchid}");
    return Container(
      //margin: const EdgeInsets.all(15.0),
      padding: EdgeInsets.all(40.0),
      width: 1300,
      height: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "☺",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Hi ${CoursesView.courseEnroll},you are enroll in ${widget.course} course",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textBaseline: TextBaseline.ideographic,
              children: [
                Row(
                  children: [
                    OutlineButton(
                      borderSide: BorderSide(color: Colors.blue),
                      padding: EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 17.0),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          OnlineCourse.visiblity = false;
                        });
                        Provider.of<SyllabusView>(context, listen: false)
                            .updateCourseSyllabus(
                                routing: CourseDetails(
                          course: widget.course,
                          trainer: trainername,
                          sess: widget.startDate,
                          desc: description,
                          batch: widget.batchid,
                        ));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.menu_book,
                            color: Color(0xFF0091D2),
                            size: 30.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "View Syllabus",
                            style: TextStyle(
                              color: Color(0xFF0091D2),
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('course')
                  .doc(widget.batchid)
                  .collection("schedule")
                  .snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading.....");
                } else {
                  final messages = snapshot.data.docs;
                  List<CourseContent> courseContent = [];
                  //List<String> subjects = [];
                  for (var message in messages) {
                    //if ((message.data()['coursename'] == widget.course)) {
                    final messageText = message.data()['date_and_time'];
                    final messagebatch = message.data()['description'];
                    final messageSender = message.data()['zoom_link'];
                    final messageTrainer = message.data()['zoom_password'];
                    final messageFinish = message.data()['finish'];
                    final messageCoursedescription =
                        message.data()['description'];
                    final messageTopic = message.data()['topicCover'];
                    final messageContent1 = message.id;
                    final messageContent2 = message.data()['date'];
                    final messageContent3 = message.data()['time'];
                    final messageContent = CourseContent(
                      name: messageText,
                      coursename: widget.course,
                      finish: messageFinish,
                      coursedescription: messageCoursedescription,
                      topicCover: messageTopic,
                      title: messageContent1,
                      date: messageContent2,
                      time: messageContent3,
                      trainername: messageTrainer,
                      batchid: messagebatch,
                    );
                    courseContent.add(messageContent);
                    //  }
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: courseContent,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CourseContent extends StatefulWidget {
  final String coursename;
  final String trainername;
  final String name;
  final String finish;
  final String coursedescription;
  final String batchid;
  final String topicCover;
  final String title;
  final String time;
  final String date;
  final String schedule;
  CourseContent(
      {this.coursename,
      this.batchid,
      this.name,
      this.finish,
      this.coursedescription,
      this.title,
      this.time,
      this.date,
      this.schedule,
      this.topicCover,
      this.trainername});

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  @override
  String zoomLink =
      "https://us04web.zoom.us/j/73962946984?pwd=TDRmWGJDZ1ZqbWZSNVlLMnNwWjdhQT09#success";
  Widget build(BuildContext context) {
    print("${CoursesView.courseEnroll}fffffffffffff");
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  //margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(15.0),
                  //height: 300.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.title}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text("${widget.coursedescription}"),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        "Scheduled At",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined),
                              Text("${widget.date}"),
                              SizedBox(
                                width: 20.0,
                              ),
                              Icon(Icons.access_time),
                              Text("${widget.time}"),
                            ],
                          ),
                          Row(
                            children: [
                              MaterialButton(
                                padding: EdgeInsets.all(20.0),
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(05.0))),
                                onPressed: () {
                                  Provider.of<SyllabusView>(context,
                                          listen: false)
                                      .updateCourseSyllabus(
                                          routing: ZoomIntegration());
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.videocam,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "Join here",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                      ),
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  Map menu = {};
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: CoursesView.isCheckCourse,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        //width: 250.0,
        color: Color(0xff006793),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              //color: Color(0xff006793).withOpacity(0.5),
              child: Column(
                children: [
                  Text(
                    "Courses",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('new users').snapshots(),
                    // ignore: missing_return
                    builder: (context1, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Loading.....");
                      } else {
                        final messages = snapshot.data.docs;

                        //userCourses();
                        int pos = 0;
                        List<String> courseList = [];
                        List<String> courseIconList = [];
                        List<String> batchId = [];

                        for (var message in messages) {
                          if (message.id == LogIn.registerNumber) {
                            final messageSender = message.data()['Courses'];

                            final batch = message.data()['batchid'];
                            print(batch);
                            print(messageSender);

                            for (var i in messageSender) {
                              menu[pos++] = false;
                              courseList.add(i);
                              courseIconList.add(courses_icon[i]);
                            }
                            for (var i in batch) {
                              batchId.add(i);
                            }
                          }
                        }

                        return HorizontalMenu(
                          courseList: courseList,
                          menu: menu,
                          batchId: batchId,
                          courseIcon: courseIconList,
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
    );
  }
}

class CourseEnroll extends StatefulWidget {
  String coursename;

  static String selectedCourse;
  static List<String> subject = [];
  bool isColor;

  CourseEnroll({this.coursename, this.isColor});

  @override
  _CourseEnrollState createState() => _CourseEnrollState();
}

class _CourseEnrollState extends State<CourseEnroll> {
  Map menu = {};

  void getMessage() async {
    final message = await _firestore.collection('course').get();

    for (var courses in message.docs) {
      CourseEnroll.subject.add(courses.data()['coursename']);
    }

    print("${CourseEnroll.subject} thamizh");
    List<bool> isSubject = [];
    for (int i = 0; i < CourseEnroll.subject.length; i++) {
      if (i == 0) {
        isSubject.add(true);
      }
      isSubject.add(false);
    }
    print("${isSubject} bool");
    for (int i = 0; i < CourseEnroll.subject.length; i++) {
      menu.addAll({CourseEnroll.subject[i]: isSubject[i]});
    }
    print("$menu dictionary");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildListTile(
            text: '${widget.coursename}',
            widget: CourseContent(
              coursename: "${CourseEnroll.selectedCourse}",
            ),
            color: widget.isColor),
      ],
    );
  }

  ListTile buildListTile({widget, text, color}) {
    print("MethodListTile $text");
    return ListTile(
      onTap: () {
        setState(() {
          //contentWidget = widget
          menu.updateAll((key, value) => menu[key] = false);
          menu[text] = true;

          //CourseEnroll.selectedCourse = text;
          print(menu);
        });
        print("jayalatha ${CourseEnroll.selectedCourse}");
        // Provider.of<Routing>(context, listen: false)
        //     .updateRouting(widget: widget);
      },
      leading: Icon(
        Icons.close,
        size: 20.0,
      ),
      title: MouseRegion(
        child: Text(
          text,
          style: TextStyle(
            color: color ? Colors.blue : Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
