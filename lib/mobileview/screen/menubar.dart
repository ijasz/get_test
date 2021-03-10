import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ocean_project/mobileview/components/ocean_icons.dart';
import 'package:ocean_project/mobileview/constants.dart';
import 'package:ocean_project/mobileview/route/routing.dart';
import 'package:ocean_project/mobileview/screen/abouts_us_screen.dart';
import 'package:ocean_project/mobileview/screen/contact_us_screen.dart';
import 'package:ocean_project/mobileview/screen/courses_screen.dart';
import 'package:ocean_project/mobileview/screen/home_screen.dart';
import 'package:ocean_project/mobileview/screen/services_screen.dart';
import 'package:provider/provider.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  Map menu = {
    'Home': true,
    'About Us': false,
    'Service': false,
    'Course': false,
    'Contact Us': false,
  };
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Gilroy'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFFECF5FF),
          leading: GestureDetector(
            onTap: () {
              setState(() {
                visibility = !visibility;
              });
            },
            child: Icon(
              Icons.menu,
              size: 25.0,
              color: Color(0xFF0091D2),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Ocean.oa,
                size: 35.0,
                color: Color(0xFF0091D2),
              ),
              Text(
                "ocean academy",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0091D2),
                    fontSize: 20),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Provider.of<Routing>(context, listen: false)
                    .updateRouting(widget: Home());
              },
              child: Icon(
                Icons.home,
                size: 25.0,
                color: Color(0xFF0091D2),
              ),
            ),
            SizedBox(
              width: 20.0,
            )
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Consumer<Routing>(
                      builder: (context, routing, child) {
                        return routing.route;
                      },
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: visibility,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: Color(0xFFECF5FF),
                  width: 200.0,
                  height: 250.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Center(
                      //   child: Text(
                      //     "* To login pls use pc",
                      //     style: TextStyle(color: Colors.red),
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                      menuItem(text: "Home", widget: Home()),
                      menuItem(text: "About Us", widget: AboutUs()),
                      menuItem(text: "Service", widget: Service()),
                      menuItem(text: "Courses", widget: Courses()),
                      menuItem(text: "Contact Us", widget: ContactUs()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector menuItem({text, widget}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          menu.updateAll((key, value) => menu[key] = false);
          menu[text] = true;
          visibility = false;
        });
        Provider.of<Routing>(context, listen: false)
            .updateRouting(widget: widget);
      },
      child: Text(
        text,
        style: TextStyle(
            color: menu[text] == true ? Colors.blue : Color(0xFF155575),
            //color: Colors.red,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: kfontname),
      ),
    );
  }
}
