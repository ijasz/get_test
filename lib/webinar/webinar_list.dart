import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/webinar/single_wbinar.dart';
import 'package:provider/provider.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class WebinarCard extends StatefulWidget {
  @override
  _WebinarCardState createState() => _WebinarCardState();
}

class _WebinarCardState extends State<WebinarCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        alignment: WrapAlignment.center,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('free_webinar').snapshots(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading.....");
              } else {
                final messages = snapshot.data.docs;

                List<WebinarCardDb> courseList = [];
                for (var message in messages) {
                  final courseName = message.data()['course'];
                  final trainerName = message.data()['trainer name'];
                  Timestamp time = message.data()['timestamp'];
                  final payment = message.data()['payment'];
                  final designation = message.data()['designation'];
                  final trainerImage = message.data()['trainer image'];
                  print(time);
                  var date = DateFormat.yMd().format(time.toDate());
                  print(date);
                  var timing = DateFormat.jms().format(time.toDate());
                  print(timing);

                  final webinar = WebinarCardDb(
                    topic: courseName,
                    webinarType: payment,
                    mentorDesignation: designation,
                    mentorName: trainerName,
                    mentorImage: trainerImage,
                    date: date.toString(),
                    time: timing.toString(),
                    onPressed: () async {
                      print(payment);
                      Provider.of<Routing>(context, listen: false)
                          .updateRouting(
                              widget: SingleWebinarScreen(
                        topic: courseName,
                        payment: payment,
                      ));
                    },
                  );

                  courseList.add(webinar);
                }

                return Wrap(
                  alignment: WrapAlignment.center,
                  children: courseList,
                );
              }
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('paid_webinar').snapshots(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading.....");
              } else {
                final messages = snapshot.data.docs;

                List<WebinarCardDb> courseList = [];
                for (var message in messages) {
                  final courseName = message.data()['course'];
                  final trainerName = message.data()['trainer name'];
                  Timestamp time = message.data()['timestamp'];
                  final payment = message.data()['payment'];
                  final designation = message.data()['designation'];
                  final trainerImage = message.data()['trainer image'];
                  print(time);
                  var date = DateFormat.yMd().format(time.toDate());
                  print(date);
                  var timing = DateFormat.jms().format(time.toDate());
                  print(timing);

                  final webinar = WebinarCardDb(
                    topic: courseName,
                    webinarType: payment,
                    mentorDesignation: designation,
                    mentorName: trainerName,
                    mentorImage: trainerImage,
                    date: date.toString(),
                    time: timing.toString(),
                    onPressed: () async {
                      print(payment);

                      Provider.of<Routing>(context, listen: false)
                          .updateRouting(
                              widget: SingleWebinarScreen(
                        topic: courseName,
                        payment: payment,
                      ));
                    },
                  );

                  courseList.add(webinar);
                }

                return Wrap(
                  alignment: WrapAlignment.center,
                  children: courseList,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class WebinarCardDb extends StatefulWidget {
  WebinarCardDb(
      {this.time,
      this.date,
      this.topic,
      this.mentorDesignation,
      this.mentorName,
      this.mentorImage,
      this.webinarType,
      this.onPressed});
  String mentorName;
  Function onPressed;
  String mentorDesignation;
  String time;
  String date;
  String webinarType;
  String topic;
  String mentorImage;
  @override
  _WebinarCardDbState createState() => _WebinarCardDbState();
}

class _WebinarCardDbState extends State<WebinarCardDb> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFF1E1E1E),
      ),
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.topic,
                  style: TextStyle(
                      color: Color(0xFF36BAFF),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Gilroy"),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "DATE :",
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Gilroy"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.date,
                      style: TextStyle(
                          color: Color(0xFF36BAFF),
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Gilroy"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "TIME :",
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Gilroy"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.time,
                      style: TextStyle(
                          color: Color(0xFF36BAFF),
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Gilroy"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.webinarType,
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Gilroy"),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  minWidth: 250,
                  height: 50,
                  child: RaisedButton(
                      child: Text(
                        "REGISTER NOW",
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Gilroy"),
                      ),
                      color: Color(0xFF36BAFF),
                      onPressed: widget.onPressed),
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(120.0),
                  child: Image.network(widget.mentorImage,
                      height: 160, width: 160, fit: BoxFit.cover),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.mentorName,
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Gilroy"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.mentorDesignation,
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Gilroy"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
