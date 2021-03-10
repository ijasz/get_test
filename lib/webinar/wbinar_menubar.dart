import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/ocean_icons.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/contact_us.dart';
import 'package:ocean_project/desktopview/screen/home_screen.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';
import 'package:ocean_project/webinar/webinar_const.dart';
import 'package:provider/provider.dart';

class WebinarMenu extends StatefulWidget {
  @override
  _WebinarMenuState createState() => _WebinarMenuState();
}

class _WebinarMenuState extends State<WebinarMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 80,
      decoration: BoxDecoration(color: Colors.grey[100], boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, -4)),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navbar.visiblity = true;
                    Navbar.isNotification = true;
                    Provider.of<Routing>(context, listen: false)
                        .updateRouting(widget: Home());
                    Provider.of<OALive>(context, listen: false)
                        .updateOA(routing: Navbar());
                  },
                  child: Icon(
                    Ocean.oa,
                    size: 60,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'ocean academy',
                  style: TextStyle(
                      fontFamily: 'Ubuntu',
                      inherit: false,
                      fontSize: 35,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            width: 400,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navbar.visiblity = true;
                    Navbar.isNotification = true;
                    Provider.of<Routing>(context, listen: false)
                        .updateRouting(widget: ContactUs());
                    Provider.of<OALive>(context, listen: false)
                        .updateOA(routing: Navbar());
                  },
                  child: Container(
                    child: Text(
                      'CONTACT',
                      style: TextStyle(
                          color: kBlue,
                          fontSize: 20,
                          fontFamily: kfontname,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navbar.visiblity = true;
                    Navbar.isNotification = true;
                    Provider.of<Routing>(context, listen: false)
                        .updateRouting(widget: LogIn());
                    Provider.of<OALive>(context, listen: false)
                        .updateOA(routing: Navbar());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: kBlue, width: 3),
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      'LOG IN',
                      style: TextStyle(
                          color: kBlue,
                          fontSize: 20,
                          fontFamily: kfontname,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
