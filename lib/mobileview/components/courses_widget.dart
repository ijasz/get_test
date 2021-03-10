import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_project/mobileview/screen/courses_screen.dart';

// ignore: must_be_immutable
class CourseWidget extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  List<String> subjects = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        (Courses.isSelected[0] == true)
            ? StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('course').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;

                    List<MessageBubble> messageBubbles = [];
                    for (var message in messages) {
                      final messageText = message.data()['trainername'];
                      final messageSender = message.data()['coursename'];
                      final messageSession = message.data()['session'];
                      final messageTime = message.data()['time'];
                      final messageImage = message.data()['img'];
                      final messageBubble = MessageBubble(
                        trainername: messageText,
                        coursename: messageSender,
                        session: messageSession,
                        time: messageTime,
                        image: messageImage,
                      );
                      // Text('$messageText from $messageSender');
                      messageBubbles.add(messageBubble);
                      //subjects.add(message.data()["coursename"]);
                      //print(subjects);
                    }

                    return Wrap(
                      children: messageBubbles,
                    );
                  }
                },
              )
            : StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('offline_course').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;

                    List<MessageBubble> offlineCourse = [];
                    for (var message in messages) {
                      final messageText = message.data()['trainername'];
                      final messageSender = message.data()['coursename'];
                      final messageSession = message.data()['session'];
                      final messageTime = message.data()['time'];
                      final messageImage = message.data()['img'];

                      final messageCourse = MessageBubble(
                        trainername: messageText,
                        coursename: messageSender,
                        session: messageSession,
                        time: messageTime,
                        image: messageImage,
                        //description: messageDescription,
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
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {this.coursename, this.trainername, this.session, this.time, this.image});
  final String coursename;
  final String trainername;
  final String session;
  final String time;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Provider.of<Routing>(context, listen: false).updateRouting(
        //     widget: CourseDetails(
        //       course: coursename,
        //     ));
      },
      child: Container(
        margin: EdgeInsets.all(35.0),
        //padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        height: 310.0,
        width: 355.0,
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
                image: NetworkImage('$image'),
                // width: 350.0,
                // height: 100.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "$coursename full package course | $trainername | Ocean Academy",
                style: TextStyle(
                  //fontSize: 15.0,
                  color: Colors.black87,
                ),
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
                  Text("$time hr"),
                  Icon(
                    Icons.web_sharp,
                    color: Color(0xff3B7EB6),
                  ),
                  Text("$session sessions"),
                  Icon(
                    Icons.video_call,
                    color: Color(0xff3B7EB6),
                  ),
                  Text("by zoom"),
                  SizedBox(
                    width: 100.0,
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
