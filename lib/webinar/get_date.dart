import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class GetDate {
  int yearFormat;
  int monthFormat;
  int dayFormat;
  int hourFormat;
  int minuteFormat;
  GetDate() {
    getDateAndTime();
  }
  getDateAndTime() async {
    var getDate =
        await _firestore.collection('webinar').doc('free_webinar').get();
    var date = getDate.data()['datetime'];
    print(date);
    formatTimes(date);
    // print(formatTimes(date));
  }

  formatTimes(Timestamp timestamp) {
    var year = DateFormat('y');
    var month = DateFormat('MM');
    var day = DateFormat('d');
    var hour = DateFormat('hh');
    var minute = DateFormat('mm');

    yearFormat = int.parse(year.format(timestamp.toDate()));
    monthFormat = int.parse(month.format(timestamp.toDate()));
    dayFormat = int.parse(day.format(timestamp.toDate()));
    hourFormat = int.parse(hour.format(timestamp.toDate()));
    minuteFormat = int.parse(minute.format(timestamp.toDate()));
  }
}
