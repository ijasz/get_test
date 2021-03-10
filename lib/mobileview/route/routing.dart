import 'package:flutter/material.dart';
import 'package:ocean_project/mobileview/screen/home_screen.dart';

class Routing extends ChangeNotifier {
  Widget route = Home();
  void updateRouting({Widget widget}) {
    route = widget;
    notifyListeners();
  }
}
