import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_project/desktopview/Components/comment.dart';
import 'package:ocean_project/desktopview/Components/main_title_widget.dart';
import 'package:ocean_project/text.dart';

class OurClient extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              MainTitleWidget(
                title: "Our Clients",
              ),
              SizedBox(
                height: 40.0,
              ),
              TextWidget(
                title: clientcontent,
              ),
            ],
          ),
          SizedBox(
            height: 100.0,
          ),
          Wrap(
            spacing: 60.0,
            runSpacing: 100.0,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('Client').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;
                    List<CollegeLogo> collegeLogo = [];

                    for (var message in messages) {
                      final logoImage = message.data()['Client'];
                      final logos = CollegeLogo(
                        collegeLogoImage: logoImage,
                      );
                      // Text('$messageText from $messageSender');
                      collegeLogo.add(logos);
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 300),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 50.0,
                        runSpacing: 30,
                        children: collegeLogo,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}

class CollegeLogo extends StatelessWidget {
  final String collegeLogoImage;
  CollegeLogo({this.collegeLogoImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(500),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10)
          ]),
      child: Image(
        image: NetworkImage("$collegeLogoImage,"),
        width: 100.0,
        // fit: BoxFit.fitWidth,
      ),
    );
  }
}
