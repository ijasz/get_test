import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'rectangular_raw_material_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContainerWidget extends StatefulWidget {
  String trainerName;
  String designation;
  String image;
  String fbLink;
  String gmailLink;
  String linkedinLink;
  String twitterLink;

  ContainerWidget(
      {this.trainerName,
      this.designation,
      this.image,
      this.fbLink,
      this.gmailLink,
      this.linkedinLink,
      this.twitterLink});

  @override
  _ContainerWidgetState createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  _getFbLink() async {
    String url = '${widget.fbLink}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _getGmailLink() async {
    String url = '${widget.gmailLink}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _getLinkedinLink() async {
    String url = '${widget.linkedinLink}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _getTwitterLink() async {
    String url = '${widget.twitterLink}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50.0),
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      height: 320.0,
      width: 265.0,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 155,
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${widget.image}'),
                  fit: BoxFit.cover,
                )),
          ),
          // SizedBox(
          //   height: 15.0,
          // ),
          Text(
            "${widget.trainerName}",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          // SizedBox(
          //   height: 15.0,
          // ),
          Text(
            widget.designation,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 15.0,
            ),
          ),
          // SizedBox(
          //   height: 15.0,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RectangularMaterialButton(
                icon: FontAwesomeIcons.facebookF,
                onPressed: () {
                  _getFbLink();
                },
              ),
              RectangularMaterialButton(
                icon: FontAwesomeIcons.googlePlusG,
                onPressed: () {
                  _getGmailLink();
                },
              ),
              RectangularMaterialButton(
                icon: FontAwesomeIcons.linkedinIn,
                onPressed: () {
                  _getLinkedinLink();
                },
              ),
              RectangularMaterialButton(
                icon: FontAwesomeIcons.twitter,
                onPressed: () {
                  _getTwitterLink();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
