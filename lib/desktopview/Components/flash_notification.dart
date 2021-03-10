import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';
import 'package:ocean_project/webinar/single_wbinar.dart';
import 'package:ocean_project/webinar/upcoming_webinar.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;

class FlashNotification extends StatefulWidget {
  FlashNotification(
      {this.joinButton,
      this.dismissNotification,
      this.joinButtonName,
      this.webinar,
      this.upcomingButton});
  Function upcomingButton;
  Function joinButton;
  Function dismissNotification;
  String joinButtonName = 'JOIN';
  Map webinar;

  @override
  _FlashNotificationState createState() => _FlashNotificationState();
}

class _FlashNotificationState extends State<FlashNotification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('@@@@@@@@@@@@@@@@@@@@@@@@');
    print(widget.webinar);

    return Container(
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('free_webinar').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;
                    List<FlashDb> webinarContent = [];

                    for (var message in messages) {
                      if (message.id == 'Flutter') {
                        final freeWebinarContent = message.data()['course'];
                        final payment = message.data()['payment'];
                        final webinar = FlashDb(
                          content: freeWebinarContent,
                          joinButton: widget.joinButton,
                          dismissNotification: widget.dismissNotification,
                          payment: payment,
                        );
                        // Text('$messageText from $messageSender');
                        webinarContent.add(webinar);
                      }
                    }
                    return Container(
                      child: Column(
                        children: webinarContent,
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  child: Text(
                    "Upcoming",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontFamily: kfontname),
                  ),
                  height: 40,
                  color: Colors.white,
                  onPressed: () {
                    Provider.of<Routing>(context, listen: false)
                        .updateRouting(widget: UpcomingWebinar());
                  },
                ),
              ),
            ],
          ),
          IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: widget.dismissNotification),
        ],
      ),
    );
  }
}

class FlashDb extends StatefulWidget {
  Function joinButton;
  Function upcomingButton;
  Function dismissNotification;
  String joinButtonName = 'JOIN';
  String content;
  String payment;
  FlashDb(
      {this.content,
      this.joinButton,
      this.dismissNotification,
      this.joinButtonName,
      this.payment,
      this.upcomingButton});

  @override
  _FlashDbState createState() => _FlashDbState();
}

class _FlashDbState extends State<FlashDb> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 20),
                children: [
              TextSpan(text: widget.content),
              TextSpan(
                  text: ' Value based webinar ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'Now'),
            ])),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: FlatButton(
            child: Text(
              "Join",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: kfontname),
            ),
            height: 40,
            color: Colors.white,
            onPressed: () {
              {
                Provider.of<Routing>(context, listen: false).updateRouting(
                    widget: SingleWebinarScreen(
                  topic: widget.content,
                  payment: widget.payment,
                ));
              }
            },
          ),
        ),
      ],
    );
  }
}
