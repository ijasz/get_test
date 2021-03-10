import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/review/google_review.dart';
import 'package:ocean_project/desktopview/review/trustpilot_review.dart';

import 'just_dial.dart';

class ReView extends StatefulWidget {
  @override
  _ReViewState createState() => _ReViewState();
}

class _ReViewState extends State<ReView> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 40,
      runSpacing: 40.0,
      children: [
        GoogleReview(),
        JusDialReview(),
        TrustPilotReview(),
      ],
    );
  }
}
