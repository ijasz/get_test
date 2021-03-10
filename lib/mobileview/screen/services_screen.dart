import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ocean_project/mobileview/components/card_design.dart';
import 'package:ocean_project/mobileview/components/navigation_bar.dart';
import 'package:ocean_project/mobileview/constants.dart';
import 'package:ocean_project/mobileview/screen/footer.dart';
import 'package:ocean_project/text.dart';

class Service extends StatefulWidget {
  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Center(
            child: Column(
              children: [
                TopNavigationBar(
                  title: "Service",
                ),
                SizedBox(
                  height: 50.0,
                ),
                ContainerServiceWidget(),
                ContainerServiceWidget(),
                ContainerServiceWidget(),
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TitleWidget(
                    title: serviceheading1,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ImageWidget(
                  photo: 'images/working.jpg',
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ContentWidget(
                    content: servicecontent1,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TitleWidget(
                    title: serviceheading2,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ImageWidget(
                  photo: 'images/working.jpg',
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ContentWidget(
                    content: servicecontent2,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TitleWidget(
                    title: serviceheading3,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ImageWidget(
                  photo: 'images/working.jpg',
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ContentWidget(
                    content: servicecontent3,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TitleWidget(
                    title: serviceheading4,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ImageWidget(
                  photo: 'images/working.jpg',
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ContentWidget(
                    content: servicecontent4,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  final String content;
  ContentWidget({this.content});
  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: TextAlign.justify,
      style: TextStyle(color: kcontentcolor, height: 1.5),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  TitleWidget({this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontFamily: kfontname),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String photo;
  ImageWidget({this.photo});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 150,
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: AssetImage(photo),
            ),
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        ),
        Container(
          width: 150.0,
          //height: 300,
          margin: EdgeInsets.fromLTRB(60.0, 70.0, 0.0, 0.0),
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
            child: Image(
              image: AssetImage(
                photo,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xff0091d2),
          ),
        ),
      ],
    );
  }
}
