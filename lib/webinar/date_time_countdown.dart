import 'package:flutter/material.dart';

import 'package:ocean_project/webinar/countdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Timer(),
    );
  }
}
