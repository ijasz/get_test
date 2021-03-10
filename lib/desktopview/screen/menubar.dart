import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ocean_project/desktopview/Components/flash_notification.dart';
import 'package:ocean_project/desktopview/Components/ocean_icons.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/contact_us.dart';
import 'package:ocean_project/desktopview/screen/courses.dart';
import 'package:ocean_project/desktopview/screen/services.dart';
import 'package:ocean_project/webinar/single_wbinar.dart';
import 'package:ocean_project/webinar/upcoming_webinar.dart';
import 'package:ocean_project/webinar/webinar.dart';
import 'package:ocean_project/webinar/webinar_list.dart';
import 'package:ocean_project/webinar/webinar_page.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'about_us_screen.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Navbar extends StatefulWidget {
  static bool visiblity = true;
  static bool isNotification = true;
  static Map menu = {
    'Home': true,
    'About Us': false,
    'Services': false,
    'Course': false,
    'Contact Us': false,
    'Career': false,
  };

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  Timestamp timestamp;
  void retriveTime() async {
    await for (var snapshot in _firestore
        .collection('webinar_time')
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        timestamp = message.data()['timeStamp'];
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retriveTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Visibility(
            visible: Navbar.isNotification,
            child: FlashNotification(
              dismissNotification: () {
                setState(() {
                  Navbar.isNotification = false;
                });
              },
              upcomingButton: () {
                setState(() {
                  Navbar.visiblity = false;
                  Navbar.isNotification = false;
                });
              },
            ),
          ),
          Visibility(
            visible: Navbar.visiblity,
            child: Container(
              color: Color(0xFFECF5FF),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navbar.isNotification = true;
                        Provider.of<Routing>(context, listen: false)
                            .updateRouting(widget: Home());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Ocean.oa,
                            size: 50.0,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "ocean academy",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0091D2),
                                fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        menuItem(text: 'Home', widget: Home()),
                        SizedBox(
                          width: 60.0,
                        ),
                        menuItem(text: 'About Us', widget: AboutUs()),
                        SizedBox(
                          width: 60.0,
                        ),
                        menuItem(text: 'Services', widget: Service()),
                        SizedBox(
                          width: 60.0,
                        ),
                        menuItem(text: 'Course', widget: Course()),
                        SizedBox(
                          width: 60.0,
                        ),
                        menuItem(text: 'Contact Us', widget: ContactUs()),
                        SizedBox(
                          width: 60.0,
                        ),
                        menuItem(text: 'Career', widget: Home()),
                        SizedBox(
                          width: 60.0,
                        ),
                        MaterialButton(
                          padding: EdgeInsets.all(20.0),
                          minWidth: 150.0,
                          color: Color(0xFF0091D2),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          onPressed: () {
                            print('${OALive.stayUser} Stay user');

                            ///todo:instead of resiter login will come
                            Provider.of<Routing>(context, listen: false)
                                .updateRouting(widget: LogIn());
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Gilroy"),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              //
            ),
          ),
          Expanded(
            child: Consumer<Routing>(
              builder: (context, routing, child) {
                return routing.route;
              },
            ),
          ),
        ],
      ),
    );
  }

  MouseRegion menuItem({text, widget}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Text(
          text,
          style: TextStyle(
              color: Navbar.menu[text] ? Colors.blue : Color(0xFF155575),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Gilroy"),
        ),
        onTap: () {
          setState(() {
            Navbar.menu.updateAll((key, value) => Navbar.menu[key] = false);
            Navbar.menu[text] = true;
            print(text);
          });
          Provider.of<Routing>(context, listen: false)
              .updateRouting(widget: widget);
        },
      ),
    );
  }
}
