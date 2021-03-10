import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ocean_project/desktopview/screen/home_screen.dart';
import 'new_user_screen/log_in.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int x = (prefs.getInt('login') ?? 0);
  Widget screen = x == 0 ? LogIn() : Home();

  Firebase.initializeApp();
  await runApp(MaterialApp(
    theme: ThemeData(fontFamily: kfontname),
    supportedLocales: [
      Locale('en'),
    ],
    home: screen,
  ));
}
