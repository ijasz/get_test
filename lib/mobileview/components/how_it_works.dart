import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/mobileview/components/main_title_widget.dart';
import 'package:ocean_project/mobileview/constants.dart';
import 'package:ocean_project/text.dart';

class HowItWorks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[100],
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 50,
            right: 10,
            child: Transform.rotate(
                angle: -170.2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  height: 10.0,
                  width: 50.0,
                )),
          ),
          Positioned(
            top: 68,
            right: -15,
            child: Transform.rotate(
                angle: -170.2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  height: 16.0,
                  width: 80.0,
                )),
          ),
          Positioned(
            left: -100,
            child: Icon(
              FontAwesomeIcons.dotCircle,
              size: 200.0,
              color: Colors.grey[350],
            ),
          ),
          Positioned(
            bottom: 188,
            right: 10,
            child: Transform.rotate(
                angle: -170.2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  height: 10.0,
                  width: 50.0,
                )),
          ),
          Positioned(
            bottom: 170,
            right: -15,
            child: Transform.rotate(
                angle: -170.2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  height: 16.0,
                  width: 80.0,
                )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 40.0,
                  children: [
                    Column(
                      children: [
                        MainTitleWidget(
                          title: 'How It Works',
                        ),
                        Text(
                          "We provide training in both Online and Offline modes",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'images/local_lesson.gif',
                          width: 250.0,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Offline Training',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blue[200],
                              fontWeight: FontWeight.bold,
                              fontFamily: kfontname),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: 400.0,
                          child: Text(
                            offlinetrainingcontent,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontFamily: kfontname,
                                color: kcontentcolor,
                                height: 1.5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'images/online_lesson.gif',
                          width: 250.0,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Online Live Training',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blue[200],
                              fontWeight: FontWeight.bold,
                              fontFamily: kfontname),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: 400.0,
                          child: Text(
                            onlinetrainingcontent,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: kcontentcolor,
                                height: 1.5,
                                fontFamily: kfontname),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'images/online_lesson.gif',
                          width: 250.0,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Online Video Training',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blue[200],
                              fontWeight: FontWeight.bold,
                              fontFamily: kfontname),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: 400.0,
                          child: Text(
                            onlinetrainingcontent,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: kcontentcolor,
                                height: 1.5,
                                fontFamily: kfontname),
                          ),
                        ),
                      ],
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
