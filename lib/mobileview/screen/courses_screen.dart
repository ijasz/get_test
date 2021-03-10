import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ocean_project/mobileview/components/courses_widget.dart';
import 'package:ocean_project/mobileview/components/navigation_bar.dart';
import 'package:ocean_project/mobileview/constants.dart';
import 'package:ocean_project/mobileview/screen/footer.dart';

class Courses extends StatefulWidget {
  static List<bool> isSelected;
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  void initState() {
    Courses.isSelected = [
      true,
      false,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Ubuntu'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            //padding: EdgeInsets.symmetric(vertical: 80.0),
            //color: Colors.greenAccent,

            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    top: 1000,
                    right: -50.0,
                    child: Icon(
                      Icons.circle,
                      size: 100.0,
                      color: Colors.lightGreen,
                    ),
                  ),
                  Positioned(
                    top: 400,
                    right: 200.0,
                    child: Icon(
                      Icons.circle,
                      size: 100.0,
                      color: Colors.lightBlue,
                    ),
                  ),
                  Positioned(
                    top: 600,
                    right: 200.0,
                    child: Icon(
                      Icons.circle,
                      size: 100.0,
                      color: Colors.lightBlue,
                    ),
                  ),
                  Positioned(
                    top: 600,
                    right: -50.0,
                    child: Icon(
                      Icons.circle,
                      size: 100.0,
                      color: Colors.lightGreen,
                    ),
                  ),
                  Positioned(
                    top: 200,
                    right: -50.0,
                    child: Icon(
                      Icons.circle,
                      size: 100.0,
                      color: Colors.lightGreen,
                    ),
                  ),
                  Positioned(
                    top: 1000,
                    left: -50,
                    child: Icon(
                      Icons.circle,
                      size: 100.0,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  Positioned(
                    top: 600,
                    left: -50,
                    child: Icon(
                      Icons.circle,
                      size: 100.0,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: -50,
                    child: Icon(
                      Icons.circle,
                      size: 100.0,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  Positioned(
                      top: 40,
                      right: 40,
                      child: Text(
                        '°',
                        style: TextStyle(fontSize: 100, color: Colors.yellow),
                      )),
                  Positioned(
                    top: 40,
                    right: 40.0,
                    child: Transform.rotate(
                        angle: -170.2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          height: 10.0,
                          width: 100.0,
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TopNavigationBar(
                        title: "Course",
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: LayoutBuilder(builder: (context, constraints) {
                            return ToggleButtons(
                                focusColor: Colors.white,
                                color: Color(0xff0091d2),
                                borderColor: Colors.white,
                                fillColor: Color(0xff0091d2),
                                borderWidth: 2,
                                selectedBorderColor: Color(0xff0091d2),
                                selectedColor: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                                constraints: BoxConstraints.expand(
                                    width: constraints.maxWidth / 2 - 2 * 1.5,
                                    height: 30.0),
                                children: [
                                  Text(
                                    'Online Courses',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: kfontname,
                                    ),
                                  ),
                                  Text('Offline Courses',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: kfontname,
                                      )),
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    for (int i = 0;
                                        i < Courses.isSelected.length;
                                        i++) {
                                      Courses.isSelected[i] = i == index;
                                    }
                                  });
                                },
                                isSelected: Courses.isSelected);
                          }),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Center(
                        child: Courses.isSelected[0] == true
                            ? Wrap(
                                runSpacing: 30.0,
                                alignment: WrapAlignment.center,
                                children: [
                                    CourseWidget(),
                                  ])
                            : Wrap(
                                runSpacing: 30.0,
                                alignment: WrapAlignment.center,
                                children: [
                                    CourseWidget(),
                                  ]),
                      ),
                      Footer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
