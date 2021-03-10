import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/alert/alert_text_field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/course_details.dart';
import 'package:ocean_project/desktopview/screen/courses.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;

class CoursesWidget extends StatefulWidget {
  @override
  _CoursesWidgetState createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  List<String> subjects = [];
  @override
  void initState() {
    // TODO: implement initState
    // getMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (Course.isSelected[0] == true)
            ? StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('offline_course').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;

                    List<OfflineCourse> offlineCourse = [];
                    for (var message in messages) {
                      final messageText = message.data()['trainername'];
                      final messageSender = message.data()['coursename'];
                      final messageDuration = message.data()['duration'];
                      final messagePdflink = message.data()['pdflink'];
                      final messageImage = message.data()['img'];

                      final messageCourse = OfflineCourse(
                        trainername: messageText,
                        coursename: messageSender,
                        duration: messageDuration,
                        pdflink: messagePdflink,
                        image: messageImage,
                      );
                      // Text('$messageText from $messageSender');
                      offlineCourse.add(messageCourse);
                      subjects.add(message.data()["coursename"]);
                      print(subjects);
                    }

                    return Wrap(
                      alignment: WrapAlignment.center,
                      children: offlineCourse,
                    );
                  }
                },
              )
            : StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('course').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;

                    List<OnlineCourse> messageBubbles = [];
                    for (var message in messages) {
                      final messageText = message.data()['trainername'];
                      final messageSender = message.data()['coursename'];
                      final messageDuration = message.data()['duration'];
                      final messageTime = message.data()['time'];
                      final messageDate = message.data()['date'];
                      final messageImage = message.data()['img'];
                      final messageDescription =
                          message.data()['coursedescription'];
                      final messageBatchid = message.data()['batchid'];
                      final messageBubble = OnlineCourse(
                        trainername: messageText,
                        coursename: messageSender,
                        duration: messageDuration,
                        time: messageTime,
                        date: messageDate,
                        image: messageImage,
                        description: messageDescription,
                        batchid: messageBatchid,
                      );
                      // Text('$messageText from $messageSender');
                      messageBubbles.add(messageBubble);
                      subjects.add(message.data()["coursename"]);
                      print(subjects);
                    }

                    return Wrap(
                      alignment: WrapAlignment.center,
                      children: messageBubbles,
                    );
                  }
                },
              ),
      ],
    );
  }
}

class OnlineCourse extends StatefulWidget {
  static bool visiblity = false;
  static String syllabusId;
  OnlineCourse(
      {this.coursename,
      this.trainername,
      this.duration,
      this.time,
      this.date,
      this.image,
      this.description,
      this.batchid});
  final String coursename;
  final String trainername;
  final String duration;
  final String time;
  final String image;
  final String description;
  final String batchid;
  final String date;

  @override
  _OnlineCourseState createState() => _OnlineCourseState();
}

class _OnlineCourseState extends State<OnlineCourse> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //studentId();
        print("${OnlineCourse.syllabusId}");
        print("${widget.coursename}jayalatha");
        print("jaya");
        setState(() {
          OnlineCourse.visiblity = true;
        });

        print(widget.coursename);
        Provider.of<Routing>(context, listen: false).updateRouting(
            widget: CourseDetails(
          batch: widget.batchid,
          course: widget.coursename,
          trainer: widget.trainername,
          sess: widget.time,
          desc: widget.description,
        ));
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: EdgeInsets.all(35.0),
          //padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          height: 330.0,
          width: 350.0,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 350,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    alignment: Alignment.centerRight,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "${widget.coursename} full package course | ${widget.trainername} | Ocean Academy",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[600],
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Color(0xff3B7EB6),
                        ),
                        Text(
                          "${widget.duration} hr",
                          style: otherSmallContentTextStyle,
                        ),
                        Icon(
                          Icons.web_sharp,
                          color: Color(0xff3B7EB6),
                        ),
                        Text(
                          "${widget.date}",
                          style: otherSmallContentTextStyle,
                        ),
                        Icon(
                          Icons.video_call,
                          color: Color(0xff3B7EB6),
                        ),
                        Text(
                          "${widget.time} P.M",
                          style: otherSmallContentTextStyle,
                        ),
                        // Text(
                        //   "Click Here",
                        //   style: TextStyle(
                        //       color: Color(0xff3B7EB6),
                        //       fontWeight: FontWeight.bold,
                        //       fontFamily: kfontname),
                        // ),
                      ],
                    ),
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

class OfflineCourse extends StatefulWidget {
  static String userID;
  OfflineCourse({
    this.coursename,
    this.trainername,
    this.duration,
    this.pdflink,
    this.image,
  });
  final String coursename;
  final String trainername;
  final String duration;
  final String pdflink;
  final String image;

  @override
  _OfflineCourseState createState() => _OfflineCourseState();
}

class _OfflineCourseState extends State<OfflineCourse> {
  ConfirmationResult confirmationResult;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential userCredential;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  void fireStoreAddWithDownload() {
    _firestore.collection('download pdf').doc('+91 ${_mobile.text}').set({
      'name': _name.text,
      'email': _email.text,
      'mobile number': '+91 ${_mobile.text}',
    });
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool isName = true;
  bool isEmail = true;
  bool isNumber = true;
  getUserData(context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 600,
              width: 1200,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.grey[500]),
                        iconSize: 30,
                        splashRadius: 25,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: 500,
                            width: 600,
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/download%20pdf%20svgs%2Fmail.svg?alt=media&token=ee065fd0-9616-43b1-9316-f31399fb9442',
                              fit: BoxFit.contain,
                            )),
                        Container(
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AlertTextField(
                                suffixIcon: isName
                                    ? null
                                    : Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                hintText: 'Name',
                                icon: Icon(Icons.person),
                                controller: _name,
                              ),
                              AlertTextField(
                                suffixIcon: isNumber
                                    ? null
                                    : Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                hintText: 'Mobile',
                                errorText: 'Enter Valid Number',
                                icon: Icon(Icons.phone_android),
                                inputFormatters: [
                                  FilteringTextInputFormatter(
                                      RegExp(r'^\d+\.?\d{0,2}'),
                                      allow: true),
                                ],
                                controller: _mobile,
                              ),
                              AlertTextField(
                                hintText: 'Email',
                                suffixIcon: isEmail
                                    ? null
                                    : Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                icon: Icon(Icons.email),
                                controller: _email,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(0, 2),
                                        blurRadius: 5)
                                  ],
                                  color: Colors.white,
                                ),
                                child: FlatButton(
                                  height: 60.0,
                                  color: Colors.white,
                                  minWidth: 360,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0)),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 30,
                                          height: 30,
                                          child: Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/download%20pdf%20svgs%2Fmail%20service.svg?alt=media&token=49ae698d-0e63-453e-ac4d-f45924d51b9b')),
                                      SizedBox(width: 6),
                                      Text(
                                        'Send to Mail',
                                        style: TextStyle(
                                            fontSize: 20.0, color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    if (validateEmail(_email.text) &&
                                        _mobile.text.length == 10 &&
                                        (_name.text.length > 3)) {
                                      print(_mobile.text);
                                      getDownloadOTP();
                                      Navigator.pop(context);
                                      otpPage(_mobile.text, context);
                                    } else if (_email.text.isEmpty &&
                                        _mobile.text.isEmpty &&
                                        _name.text.isEmpty) {
                                      fillAllFieldsDialog(context);
                                    } else if (_name.text.length < 3) {
                                      invalidNameDialog(context);
                                    } else if (_mobile.text.length != 10) {
                                      invalidNumberDialog(context);
                                    } else if (!validateEmail(_email.text)) {
                                      invalidMailDialog(context);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  getDownloadOTP() async {
    confirmationResult =
        await _auth.signInWithPhoneNumber('+91 ${_mobile.text}');
  }

  verifyOTP() async {
    if (_mobile.text.length > 10) {
      try {
        userCredential = await confirmationResult.confirm(_otp.text);
        print(userCredential);
        print(confirmationResult);
        print('OTP submited');
        fireStoreAddWithDownload();

        fieldClear();
        Navigator.pop(context);
      } catch (e) {
        print('$e OTP faild');
        Navigator.pop(context);
        _invalidOTP();
      }
    } else {
      Navigator.pop(context);
      _invalidOTP();
    }
  }

  Future<void> _invalidOTP() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(
                'Sorry',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              SizedBox(width: 15),
              Icon(
                FontAwesomeIcons.frown,
                color: Colors.red,
              )
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Enter valid OTP or Update Mobile Number',
                  style: TextStyle(color: Colors.grey[500], fontSize: 25),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Enter OTP'),
              color: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                Navigator.pop(context);
                otpPage(_mobile.text, context);
              },
            ),
            FlatButton(
              child: Text('Update Number'),
              color: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                Navigator.pop(context);
                getUserData(context);
              },
            ),
          ],
        );
      },
    );
  }

  fieldClear() {
    _mobile.clear();
    _email.clear();
    _name.clear();
    _otp.clear();
  }

  otpPage(String userMobileNumber, context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 600,
              width: 1200,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.grey[500]),
                        iconSize: 30,
                        splashRadius: 25,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: 500,
                            width: 600,
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/download%20pdf%20svgs%2Fotp%20service.svg?alt=media&token=d5935912-85b6-447d-b495-ef8fbd1de381',
                              fit: BoxFit.contain,
                            )),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AlertTextField(
                                errorText: 'invalid OTP',
                                hintText: 'Enter OTP',
                                icon: Icon(Icons.lock_clock),
                                letterSpacing: 20,
                                controller: _otp,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(0, 2),
                                        blurRadius: 5)
                                  ],
                                  color: Colors.white,
                                ),
                                child: FlatButton(
                                  height: 60.0,
                                  color: Colors.white,
                                  minWidth: 360,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0)),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 30,
                                          height: 30,
                                          child: Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/download%20pdf%20svgs%2Fmail%20service.svg?alt=media&token=49ae698d-0e63-453e-ac4d-f45924d51b9b')),
                                      SizedBox(width: 6),
                                      Text(
                                        'submit',
                                        style: TextStyle(
                                            fontSize: 20.0, color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    if (_mobile.text.length >= 10) {
                                      try {
                                        userCredential =
                                            await confirmationResult
                                                .confirm(_otp.text);
                                        print('OTP submited');
                                        fireStoreAddWithDownload();
                                        Navigator.pop(context);
                                        fieldClear();
                                        mailSendedDialog(context);
                                      } catch (e) {
                                        print('$e OTP faild');
                                        Navigator.pop(context);
                                        _invalidOTP();
                                      }
                                    } else {
                                      Navigator.pop(context);
                                      _invalidOTP();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 15),
                                    children: [
                                      TextSpan(text: 'Not Received OTP'),
                                      TextSpan(
                                          text: ' Update MobileNumber?',
                                          style: TextStyle(color: Colors.blue),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              Navigator.pop(context);
                                              getUserData(context);
                                            }),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  mailSendedDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.transparent,
          content: Container(
            height: 300,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Mail has been send',
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.network(
                    'https://cdn.dribbble.com/users/493409/screenshots/3070302/043_success-mail.gif'),
              ],
            ),
          ),
        );
      },
    );
  }

  invalidMailDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.transparent,
          content: Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Invalid E-Mail',
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  invalidNumberDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.transparent,
          content: Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Invalid Mobile Number',
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  invalidNameDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.transparent,
          content: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name should be Greaterthan 3 letter',
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  fillAllFieldsDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.transparent,
          content: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Fill All the Fields',
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(35.0),
      //padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      height: 310.0,
      width: 350.0,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image(
              image: NetworkImage('${widget.image}'),
              // width: 350.0,
              // height: 100.0,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "${widget.coursename} full package course | ${widget.trainername} | Ocean Academy",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  //mainAxisAli gnment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.schedule,
                      color: Color(0xff3B7EB6),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("${widget.duration} duration"),
                    SizedBox(
                      width: 30.0,
                    ),
                    MaterialButton(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(05.0))),
                      onPressed: () async {
                        await getUserData(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.download_sharp,
                            color: Color(0xff3B7EB6),
                            size: 20.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Download pdf",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
