import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'rectangular_raw_material_button.dart';

// ignore: must_be_immutable
class ContainerWidget extends StatelessWidget {
  String trainerName;
  String designation;
  String image;

  ContainerWidget({
    this.trainerName,
    this.designation,
    this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50.0),
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      height: 320.0,
      width: 255.0,
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
                  image: NetworkImage('$image'),
                  fit: BoxFit.cover,
                )),
          ),
          // SizedBox(
          //   height: 15.0,
          // ),
          Text(
            "$trainerName",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          // SizedBox(
          //   height: 15.0,
          // ),
          Text(
            "$designation at Ocean",
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
                onPressed: () {},
              ),
              RectangularMaterialButton(
                icon: FontAwesomeIcons.googlePlusG,
                onPressed: () {},
              ),
              RectangularMaterialButton(
                icon: FontAwesomeIcons.linkedinIn,
                onPressed: () {},
              ),
              RectangularMaterialButton(
                icon: FontAwesomeIcons.twitter,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
