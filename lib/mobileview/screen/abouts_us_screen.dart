import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/mobileview/components/container_widget.dart';
import 'package:ocean_project/mobileview/components/navigation_bar.dart';
import 'package:ocean_project/mobileview/constants.dart';
import 'package:ocean_project/mobileview/screen/footer.dart';
import 'package:ocean_project/text.dart';

class AboutUs extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopNavigationBar(
                title: "About Us",
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'About us Ocean Academy',
                          style: TextStyle(
                              color: Color(0xff0091d2),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: kfontname),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                      width: 20.0,
                    ),
                    Text(
                      aboutcontent1,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: kcontentcolor,
                          height: 1.5,
                          fontFamily: kfontname),
                    ),
                    SizedBox(
                      height: 20.0,
                      width: 20.0,
                    ),
                    Text(
                      aboutcontent2,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: kcontentcolor,
                          height: 1.5,
                          fontFamily: kfontname),
                    ),
                    SizedBox(
                      height: 40.0,
                      width: 30.0,
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 150.0,
                                height: 150.0,
                                //height: 300,
                                margin:
                                    EdgeInsets.fromLTRB(80.0, 0.0, 0.0, 50.0),
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(
                                    image: AssetImage('images/lap.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              Container(
                                width: 150.0,
                                height: 150.0,
                                margin:
                                    EdgeInsets.fromLTRB(20.0, 60.0, 0.0, 20.0),
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0)),
                                  child: Image(
                                    image: AssetImage('images/lap.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(0xff0091d2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                      width: 20.0,
                    ),
                    Text(
                      aboutcontent3,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: kcontentcolor,
                          height: 1.5,
                          fontFamily: kfontname),
                    ),
                    SizedBox(
                      height: 20.0,
                      width: 20.0,
                    ),
                    Text(
                      aboutcontent4,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: kcontentcolor,
                          height: 1.5,
                          fontFamily: kfontname),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Column(
                children: [
                  Text(
                    "Meet our Mentors",
                    style: TextStyle(
                        color: Color(0xff0091d2),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: kfontname),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Wrap(alignment: WrapAlignment.center, children: [
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('trainer').snapshots(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading.....");
                    } else {
                      final messages = snapshot.data.docs;
                      List<ContainerWidget> trainerContent = [];
                      //List<String> subjects = [];
                      for (var message in messages) {
                        // if (message.data()['coursename'] == "python") {
                        final trainerName = message.data()['trainername'];
                        final trainerDesignation =
                            message.data()['designation'];
                        final trainerImage = message.data()['img'];

                        final messageContent = ContainerWidget(
                          designation: trainerDesignation,
                          trainerName: trainerName,
                          image: trainerImage,
                        );
                        trainerContent.add(messageContent);
                        // }
                      }
                      return Wrap(
                        children: trainerContent,
                      );
                    }
                  },
                ),
              ]),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
