import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/desktopview/Components/material_button.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';
import 'package:provider/provider.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/contact_us.dart';
import 'package:ocean_project/desktopview/screen/courses.dart';
import 'package:ocean_project/desktopview/screen/services.dart';
import 'home_screen.dart';
import 'about_us_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

subscribeDialog(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        content: Container(
          height: 300,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thanks for Subscribe',
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Image.network(
                  'https://tetranoodle.com/wp-content/uploads/2018/07/tick-gif.gif'),
            ],
          ),
        ),
      );
    },
  );
}

subscribeFaildDialog(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        content: Container(
          height: 300,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Check your Email',
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              Image.network(
                  'https://www.peppynite.com/templates/worlddealer/assets/img/wrong-symbol.gif'),
            ],
          ),
        ),
      );
    },
  );
}

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  TextEditingController _subscribe = TextEditingController();

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(70.0),
      color: Color(0xFF004478),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),

            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<Routing>(context, listen: false)
                              .updateRouting(widget: Home());
                        },
                        child: Text(
                          'OCEAN ACADEMY',
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: kfontname),
                        ),
                      ),
                      padding: EdgeInsets.only(right: 150.0),
                    ),
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.only(right: 300.0),
                      child: Text(
                        'Ocean was founded on the principle of building and implementing'
                        ' great ideas that drive progress for the students ond clients',
                        style: TextStyle(
                            height: 1.5,
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: kfontname),
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 50.0,
                            runSpacing: 30.0,
                            alignment: WrapAlignment.center,
                            children: [
                              Container(
                                width: 300.0,
                                child: TextField(
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  controller: _subscribe,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your Email',
                                    hintStyle: kbottom,

                                    // contentPadding: EdgeInsets.only(
                                    //     top: 10, bottom: 10, left: 38),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                  ),
                                ),
                              ),
                              FlatButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 35.0, vertical: 10.0),
                                color: Colors.white,
                                minWidth: 1.0,
                                height: 60.0,
                                child: Text(
                                  'SUBSCRIBE',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.blue,
                                    fontFamily: kfontname,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    side: BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    )),
                                onPressed: () {
                                  if (validateEmail(_subscribe.text)) {
                                    _firestore
                                        .collection('subscribed user')
                                        .doc(_subscribe.text)
                                        .set({
                                      'Email': _subscribe.text,
                                    });
                                    subscribeDialog(context);
                                    _subscribe.clear();
                                  } else {
                                    subscribeFaildDialog(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20.0),
                      child: Text(
                        '0413-2238675',
                        style: kbottom,
                      ),
                      //padding: EdgeInsets.only(left: 50.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 20.0),
                        child: Text(
                          'oceanacademy@gmail.com',
                          style: kbottom,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Navbar.menu.updateAll(
                                (key, value) => Navbar.menu[key] = false);
                            Navbar.menu["Contact Us"] = true;
                          });
                          Provider.of<Routing>(context, listen: false)
                              .updateRouting(
                            widget: ContactUs(),
                          );
                        },
                        child: Container(
                            child: Text(
                          'CONTACT US',
                          style: kbottom,
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<Routing>(context, listen: false)
                              .updateRouting(widget: Service());
                        },
                        child: Container(
                            child: Text(
                          'SERVICES',
                          style: kbottom,
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<Routing>(context, listen: false)
                              .updateRouting(widget: Course());
                        },
                        child: Container(
                            child: Text(
                          'COURSES',
                          style: kbottom,
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        child: Text(
                      'FAQ',
                      style: kbottom,
                    )),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        child: Text(
                      'HELP',
                      style: kbottom,
                    )),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FooterMouseRegion(text: "ABOUT US", widget: AboutUs()),
                    SizedBox(
                      height: 20.0,
                    ),
                    FooterMouseRegion(text: "WORK WITH US"),
                    SizedBox(
                      height: 20.0,
                    ),
                    FooterMouseRegion(text: "PRIVATE POLICIES"),
                    SizedBox(
                      height: 20.0,
                    ),
                    FooterMouseRegion(text: "TERMS AND CONDITIONS"),
                    SizedBox(
                      height: 20.0,
                    ),
                    FooterMouseRegion(text: "PRESS ENQUIRES"),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialFlatButton(
                icon: FontAwesomeIcons.facebookF,
                onPressed: () {},
              ),
              MaterialFlatButton(
                icon: FontAwesomeIcons.googlePlusG,
                onPressed: () {},
              ),
              MaterialFlatButton(
                icon: FontAwesomeIcons.linkedinIn,
                onPressed: () {},
              ),
              MaterialFlatButton(
                icon: FontAwesomeIcons.twitter,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  MouseRegion FooterMouseRegion({text, widget}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Provider.of<Routing>(context, listen: false)
              .updateRouting(widget: widget);
        },
        child: Container(
            child: Text(
          text,
          style: kbottom,
        )),
      ),
    );
  }
}
