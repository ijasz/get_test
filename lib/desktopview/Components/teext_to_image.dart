import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/constants.dart';

// ignore: must_be_immutable
class TextToImage extends StatelessWidget {
  String topic;
  String content;
  String photo;
  TextToImage({this.topic, this.content, this.photo});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 100),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(left: 50.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic,
                    style: TextStyle(
                        color: Color(0xff0091d2),
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: kfontname),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(content,
                      textAlign: TextAlign.justify, style: contentTextStyle),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              width: 350.0,
              height: 350.0,
              //height: 300,
              child: Image(
                image: NetworkImage(photo),
                fit: BoxFit.contain,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
