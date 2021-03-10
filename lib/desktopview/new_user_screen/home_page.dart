import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThamizhHome extends StatefulWidget {
  ThamizhHome({this.userID});
  final String userID;
  @override
  _ThamizhHomeState createState() => _ThamizhHomeState();
}

class _ThamizhHomeState extends State<ThamizhHome> {
  List<Widget> userField = [];
  var userInfo;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  getData() async {
    userInfo =
        await _firestore.collection('new users').doc(widget.userID).get();

    Map userDetails = userInfo.data();

    userDetails.forEach((key, value) {
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            padding: EdgeInsets.all(5.0),
            child: Text(
              '${key}',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            padding: EdgeInsets.all(5.0),
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
          ),
        ],
      );
      setState(() {
        userField.add(row);
      });
    });
    print(userField);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: userField,
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: Text(
                        'Sing Out',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                      color: Colors.redAccent,
                      height: 200.0,
                      minWidth: 200.0,
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LogIn()));
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        setState(() async {
                          await prefs.setInt('login', 0);
                        });
                        print('SingOut Code');
                        //TODO: write SingOut code;
                      },
                    )
                  ],
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
