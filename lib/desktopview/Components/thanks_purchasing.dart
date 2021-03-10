import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/my_course.dart';
import 'package:ocean_project/desktopview/route/routing.dart';

import 'package:ocean_project/desktopview/screen/footer.dart';
import 'package:provider/provider.dart';

class ThanksForPurchasing extends StatefulWidget {
  @override
  _ThanksForPurchasingState createState() => _ThanksForPurchasingState();
}

class _ThanksForPurchasingState extends State<ThanksForPurchasing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Text(
              'Thanks for purchasing!',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 30),
            Container(
                height: 200,
                child: Icon(
                  Icons.check_circle,
                  size: 200,
                  color: Colors.green,
                )),
            SizedBox(height: 30),
            Text('Your payment has been made successfully',
                style: TextStyle(fontSize: 20, color: Color(0xff333333))),
            SizedBox(height: 40),
            Container(
              height: 70,
              width: 200,
              child: FlatButton(
                color: Color(0xff0091D2),
                onPressed: () {
                  Provider.of<SyllabusView>(context, listen: false)
                      .updateCourseSyllabus(routing: MyCourse());
                },
                child: Text("Go to Courses",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            SizedBox(height: 50),
            Footer()
          ],
        ),
      ),
    );
  }
}
