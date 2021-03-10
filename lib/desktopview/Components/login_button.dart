import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';

import 'package:ocean_project/desktopview/route/routing.dart';

import 'package:provider/provider.dart';

class LogInButton extends StatefulWidget {
  @override
  _LogInButtonState createState() => _LogInButtonState();
}

class _LogInButtonState extends State<LogInButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(20.0),
      minWidth: 150.0,
      color: Color(0xFF0091D2),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      onPressed: () {
        setState(() {
          //Navbar.visiblity = false;
          // print("${Navbar.visiblity}vvvvvvvvvvvvvvvvv");
        });

        ///todo:instead of resiter login will come
        Provider.of<Routing>(context, listen: false)
            .updateRouting(widget: CoursesView());

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => CoursesView()),
        // );
      },
      child: Text(
        "Log in",
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
