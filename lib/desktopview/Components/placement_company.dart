import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_project/desktopview/Components/comment.dart';
import 'package:ocean_project/desktopview/Components/main_title_widget.dart';
import 'package:ocean_project/text.dart';

class PlacementCompany extends StatelessWidget {
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
                title: "Our student got placement",
              ),
              SizedBox(
                height: 40.0,
              ),
              TextWidget(
                title: placementcontent,
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
                stream: _firestore.collection('Company').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;
                    List<CompanyLogo> companyLogo = [];

                    for (var message in messages) {
                      final logoImage = message.data()['Company'];
                      final logos = CompanyLogo(
                        companyLogoImage: logoImage,
                      );
                      // Text('$messageText from $messageSender');
                      companyLogo.add(logos);
                    }
                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 50.0,
                      children: companyLogo,
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

class CompanyLogo extends StatelessWidget {
  final String companyLogoImage;
  CompanyLogo({this.companyLogoImage});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage("$companyLogoImage,"),
      width: 200.0,
    );
  }
}
