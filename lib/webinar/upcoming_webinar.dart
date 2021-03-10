import 'package:flutter/material.dart';
import 'package:ocean_project/webinar/webinar_list.dart';

class UpcomingWebinar extends StatefulWidget {
  @override
  _UpcomingWebinarState createState() => _UpcomingWebinarState();
}

class _UpcomingWebinarState extends State<UpcomingWebinar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebinarCard(),
    );
  }
}
