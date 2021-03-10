import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/Components/my_course.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

final _firestore = FirebaseFirestore.instance;

// void main() {
//   runApp(MaterialApp(home: Certificate()));
// }

class Certificate extends StatefulWidget {
  @override
  _CertificateState createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CoursesView.isCheckCourse = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      CoursesView.isCheckCourse = true;
                      Provider.of<CourseProvide>(context, listen: false)
                          .updateCourseName(
                              routing: CourseList(),
                              isCheck: CoursesView.isCheckCourse);
                      Provider.of<SyllabusView>(context, listen: false)
                          .updateCourseSyllabus(
                        routing: MyCourse(),
                      );
                    },
                    child:
                        Icon(Icons.chevron_left, size: 70, color: Colors.blue)),
                Text('Certificates',
                    style: TextStyle(fontSize: 27, color: Colors.blue)),
              ],
            ),
            SizedBox(height: 50),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('Certificate').snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading.....");
                } else {
                  final messages = snapshot.data.docs;
                  List<CertificateDb> data = [];

                  for (var message in messages) {
                    final dbcourseName = message.data()['courseName'];
                    final dbimage = message.data()['image'];
                    final sample = CertificateDb(
                      image: dbimage,
                      course: dbcourseName,
                    );
                    // Text('$messageText from $messageSender');
                    data.add(sample);
                  }
                  return Wrap(
                    spacing: 60,
                    runSpacing: 80,
                    children: data,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class CertificateDb extends StatefulWidget {
  String image;
  String course;

  CertificateDb({this.image, this.course});

  @override
  _CertificateDbState createState() => _CertificateDbState();
}

class _CertificateDbState extends State<CertificateDb> {
  bool isVisible = false;
  bool isTouching = false;

  launchURL() async {
    final url = '${widget.image}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void mouseEnter(PointerEvent details) {
    setState(() {
      isTouching = true;
    });
  }

  void mouseExit(PointerEvent details) {
    setState(() {
      isTouching = false;
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 20, spreadRadius: 0.8),
            ],
          ),
          child: Column(
            children: [
              GestureDetector(
                child: MouseRegion(
                  onEnter: mouseEnter,
                  onExit: mouseExit,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: EdgeInsets.all(20),
                              height: 210,
                              width: 350,
                              child: Image.network('${widget.image}')),
                        ],
                      ),
                      isTouching
                          ? Visibility(
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  height: 180,
                                  width: 300,
                                  color: Colors.black54,
                                  child: GestureDetector(
                                      onTap: () {
                                        launchURL();
                                      },
                                      child: Icon(Icons.download_rounded,
                                          color: Colors.white)),
                                ),
                              ),
                            )
                          : Visibility(
                              visible: isVisible,
                              child: Center(
                                child: Positioned(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 180,
                                    width: 300,
                                    color: Colors.black54,
                                    child: GestureDetector(
                                        onTap: () {
                                          launchURL();
                                        },
                                        child: Icon(Icons.download_rounded,
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '${widget.course} Certificate',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
