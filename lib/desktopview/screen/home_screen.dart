import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:ocean_project/alert/alert_msg.dart';
import 'package:ocean_project/desktopview/Components/how_it_works.dart';
import 'package:ocean_project/desktopview/Components/main_badget_widget.dart';

import 'package:ocean_project/desktopview/Components/our_client.dart';
import 'package:ocean_project/desktopview/Components/placement_company.dart';
import 'package:ocean_project/desktopview/Components/reviews.dart';
import 'package:ocean_project/desktopview/Components/slider_widget.dart';
import 'package:ocean_project/desktopview/Components/upcoming_course_widget.dart';
import 'package:ocean_project/desktopview/Components/what_is_new.dart';
import 'package:ocean_project/desktopview/screen/footer.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _firestore = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final keyIsFirstLoaded = 'is_first_loaded';
  String fullNameAlert;
  String phoneNumberAlert;
  String emailAlert;
  bool flag = true;
  Timer _timer;

  void initState() {
    // TODO: implement initState
    super.initState();
    //Navbar.visiblity = true;
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    // _timer = Timer(Duration(seconds: 0), () {
    //   showDialogIfFirstLoaded(context);
    // });
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SliderWidget(),
            MainBadgeWidget(),
            UpcomingCourse(),
            PlacementCompany(),
            ReviewsSection(),
            OurClient(),
            WhatIsNew(),
            HowItWorks(),
            Footer(),
          ],
        ),
      ),
    );
  }

  Future showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);

    //TODO make as isFirstLoaded == null
    if (isFirstLoaded == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertEnquiry(
            keyIsFirstLoaded: keyIsFirstLoaded,
          );
        },
      );
    }
  }
}
