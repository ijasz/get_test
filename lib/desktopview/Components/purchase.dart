import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/Components/my_course.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:provider/provider.dart';

class Purchase extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 5),
                IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                  ),
                  color: Colors.blue,
                  iconSize: 50,
                  splashRadius: 30,
                  onPressed: () {
                    CoursesView.isCheckCourse = true;
                    Provider.of<CourseProvide>(context, listen: false)
                        .updateCourseName(
                            routing: CourseList(),
                            isCheck: CoursesView.isCheckCourse);
                    Provider.of<SyllabusView>(context, listen: false)
                        .updateCourseSyllabus(
                      routing: MyCourse(),
                    );
                  },
                ),
                Text(
                  'Purchases',
                  style: TextStyle(
                      fontSize: 25,
                      color: Color(0xff2B9DD1),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              width: 1565,
              child: Divider(
                thickness: 0.1,
                color: Colors.black26,
              ),
            ),
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 110,
                    child: Text(
                      'Thumbnail',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 170,
                    child: Text(
                      'Course Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 120,
                    child: Text(
                      'Purchased Date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 120,
                    child: Text(
                      'Total Amount',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 120,
                    child: Text(
                      'Paid Via',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 120,
                    child: Text(
                      'Status',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1565,
              child: Divider(
                thickness: 0.1,
                color: Colors.black26,
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('new users')
                  .doc(LogIn.registerNumber)
                  .collection("payment")
                  .snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading.....");
                } else {
                  final messages = snapshot.data.docs;
                  List<Purchasedatabase> data = [];

                  for (var message in messages) {
                    final course = message.data()['coursename'];
                    final dbpaidvia = message.data()['paid_via'];
                    final dbpurchaseddate = message.data()['date'];
                    final dbtotalamount = message.data()['amount'];
                    final dbstatus = message.data()['status'];
                    final dbthumbnail = message.data()['image'];
                    final sample = Purchasedatabase(
                      course: course,
                      paidvia: dbpaidvia,
                      purchaseddate: dbpurchaseddate,
                      totalamount: dbtotalamount,
                      status: dbstatus,
                      thumbnail: dbthumbnail,
                    );
                    // Text('$messageText from $messageSender');
                    data.add(sample);
                    print(data);
                  }
                  return Column(
                    children: data,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Purchasedatabase extends StatelessWidget {
  Purchasedatabase(
      {this.course,
      this.paidvia,
      this.purchaseddate,
      this.status,
      this.thumbnail,
      this.totalamount});

  String course;
  String paidvia;
  String purchaseddate;
  String status;
  String thumbnail;
  String totalamount;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.center,
            width: 110,
            child: Image.network(
              "$thumbnail",
              height: 40,
              width: 40,
            ),
          ),
          Container(
              alignment: Alignment.center, width: 170, child: Text('$course')),
          Container(
              alignment: Alignment.center,
              width: 120,
              child: Text('$purchaseddate')),
          Container(
              alignment: Alignment.center,
              width: 120,
              child: Text('${totalamount}')),
          Container(
              alignment: Alignment.center, width: 120, child: Text('$paidvia')),
          Container(
              alignment: Alignment.center, width: 120, child: Text('$status')),
        ],
      ),
      Container(
        // padding: EdgeInsets.only(left: 70, right: 50),
        width: double.infinity,
        child: Divider(
          indent: 130,
          endIndent: 130,
          thickness: 0.1,
          color: Colors.black26,
        ),
      ),
    ]);
  }
}
