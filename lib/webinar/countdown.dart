import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/webinar/webinar_const.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class Timer extends StatefulWidget {
  Timer({this.onPressed});

  Function onPressed;

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  bool timeUp = false;

  var sDate = DateTime(2021, 02, 28).difference(DateTime.now()).inDays;
  final sTime = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0)
      .difference(DateTime.now())
      .inHours;
  int sHours;
  var sMinute = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, DateTime.now().hour, 0)
      .difference(DateTime.now())
      .inMinutes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(DateFormat("yyyy-MM-dd- HH : mm").format(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 357,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 110,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: kBlue, width: 3),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SlideCountdownClock(
                        duration: Duration(
                            days: sDate,
                            hours: sHours = (sTime + 12),
                            minutes: sMinute),
                        separator: ' : ',
                        textStyle: TextStyle(
                            fontSize: 40, fontFamily: kfontname, color: kBlue),
                        separatorTextStyle:
                            TextStyle(fontSize: 35, color: kBlue),
                        shouldShowDays: true,
                        onDone: () {
                          setState(() {
                            timeUp = true;
                          });
                        },
                      ),
                      Container(
                        width: 290,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'DAYS',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: kfontname,
                                  color: kBlue),
                            ),
                            SizedBox(width: 1),
                            Text(
                              'HRS',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: kfontname,
                                  color: kBlue),
                            ),
                            SizedBox(width: 1),
                            Text(
                              'MIN',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: kfontname,
                                  color: kBlue),
                            ),
                            SizedBox(width: 1),
                            Text(
                              'SEC',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: kfontname,
                                  color: kBlue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: Text(
                      'Webinar nds in...',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: FlatButton(
              child: Text(
                'Register',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: kBlue,
              minWidth: double.infinity,
              height: 60,
              onPressed: widget.onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
