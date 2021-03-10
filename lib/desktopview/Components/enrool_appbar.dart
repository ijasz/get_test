import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/Components/enroll_new.dart';
import 'package:ocean_project/desktopview/Components/my_course.dart';
import 'package:ocean_project/desktopview/Components/main_notification.dart';
import 'package:ocean_project/desktopview/Components/user_profile.dart';
import 'package:ocean_project/desktopview/Components/ocean_icons.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/home_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;

class AppBarWidget extends StatefulWidget {
  AppBarWidget({this.userProfile});
  String userProfile;
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  String userProfile;
  session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('login', 1);
    await prefs.setString('user', OALive.stayUser);
    print("${OALive.stayUser}dddddddddddddddddddddddddddddddddddddd");
    OALive.stayUser = LogIn.registerNumber;
    print('Otp Submited');

    getProfilePicture();
  }

  getProfilePicture() async {
    var details =
        await _firestore.collection('new users').doc(OALive.stayUser).get();
    userProfile = details.data()['Profile Picture'];
    print(userProfile);
  }

  getImage() async {
    StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('new users').snapshots(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading.....");
          } else {
            final messages = snapshot.data.docs;
            for (var message in messages) {
              // ignore: unrelated_type_equality_checks
              if (OALive.stayUser == message.id) {
                final dbImage = message.data()['Profile Picture'];

                userProfile = dbImage;
              }
            }
          }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(OALive.stayUser);
    print('88888888888');
    print(LogIn.registerNumber);
    session();

    //getImage();
  }

  @override
  Widget build(BuildContext context) {
    session();
    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              height: 100.0,
              color: Color(0xff0091D2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<Routing>(context, listen: false)
                          .updateRouting(widget: Home());
                      Provider.of<OALive>(context, listen: false)
                          .updateOA(routing: Navbar());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Ocean.oa,
                          size: 70.0,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "ocean academy",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 35),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    width: 830.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          padding: EdgeInsets.all(20.0),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          onPressed: () {
                            Provider.of<SyllabusView>(context, listen: false)
                                .updateCourseSyllabus(routing: MyCourse());
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.view_agenda,
                                color: Color(0xFF0091D2),
                                size: 30.0,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "View My Courses",
                                style: TextStyle(
                                  color: Color(0xFF0091D2),
                                  fontSize: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          padding: EdgeInsets.all(20.0),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          onPressed: () {
                            Provider.of<SyllabusView>(context, listen: false)
                                .updateCourseSyllabus(routing: EnrollNew());
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.view_agenda,
                                color: Color(0xFF0091D2),
                                size: 30.0,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "View All Courses",
                                style: TextStyle(
                                  color: Color(0xFF0091D2),
                                  fontSize: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream:
                              _firestore.collection('new users').snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Loading.....");
                            } else {
                              final messages = snapshot.data.docs;
                              List<ProfilePictureDb> profile = [];

                              for (var message in messages) {
                                var id = OALive.stayUser != null
                                    ? OALive.stayUser
                                    : LogIn.registerNumber;
                                print("id variable");
                                print(id);
                                if (message.id == id) {
                                  final profileImage =
                                      message.data()['Profile Picture'];

                                  final pictures = ProfilePictureDb(
                                    profilePicture: profileImage,
                                    onpress: () {
                                      setState(() {
                                        ContentWidget.isShow =
                                            !ContentWidget.isShow;
                                      });

                                      Provider.of<UserProfiles>(context,
                                              listen: false)
                                          .updateUser(
                                              routing: User_Profile(
                                        isVisible: ContentWidget.isShow,
                                      ));
                                    },
                                  );
                                  // Text('$messageText from $messageSender');
                                  profile.add(pictures);
                                }
                              }
                              return MaterialButton(
                                child: Row(
                                  children: profile,
                                ),
                              );
                            }
                          },
                        ),
                        MaterialButton(
                          padding: EdgeInsets.all(10.0),
                          minWidth: 10.0,
                          hoverColor: Colors.white10,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(600.0))),
                          onPressed: () {
                            setState(() {
                              ContentWidget.isVisible =
                                  !ContentWidget.isVisible;
                            });
                            Provider.of<UserProfiles>(context, listen: false)
                                .updateUser(
                                    routing: Notification_onclick(
                              isVisible: ContentWidget.isVisible,
                            ));
                          },
                          child: Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.white,
                            size: 50.0,
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
        Visibility(
          visible: ContentWidget.isShow,
          child: Positioned(
            top: 90,
            right: 176,
            child: ClipPath(
              clipper: TraingleClipPath(),
              child: Container(
                height: 10,
                width: 10,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Visibility(
          visible: ContentWidget.isVisible,
          child: Positioned(
            top: 90,
            right: 63,
            // right: 23,
            child: ClipPath(
              clipper: TraingleClipPath(),
              child: Container(
                height: 10,
                width: 10,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
    //   ],
    // );
  }
}

class TraingleClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(5, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(5, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ProfilePictureDb extends StatefulWidget {
  String profilePicture;
  Function onpress;
  ProfilePictureDb({this.profilePicture, this.onpress});
  @override
  _ProfilePictureDbState createState() => _ProfilePictureDbState();
}

class _ProfilePictureDbState extends State<ProfilePictureDb> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(10.0),
      minWidth: 10.0,
      hoverColor: Colors.white10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(600.0))),
      onPressed: widget.onpress,
      child: widget.profilePicture != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.network(widget.profilePicture,
                  height: 60, width: 60, fit: BoxFit.cover),
            )
          : Icon(
              FontAwesomeIcons.solidUserCircle,
              size: 60,
              color: Colors.white,
            ),
    );
  }
}
