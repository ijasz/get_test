import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/new_user_screen/registration.dart';
import 'package:ocean_project/desktopview/new_user_widget/otp_inputs.dart';
import 'package:ocean_project/desktopview/route/routing.dart';

import 'package:otp_text_field/otp_field.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timer_count_down/timer_count_down.dart';

class AlertOtp extends StatefulWidget {
  static String userID;
  @override
  _AlertOtpState createState() => _AlertOtpState();
}

class _AlertOtpState extends State<AlertOtp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String otp;
  TextEditingController _otp = TextEditingController();
  UserCredential userCredential;
  String count;
  bool isLogin = false;

  List<dynamic> otpCount(int count) {
    List<Widget> otp = [];
    for (int i = 0; i < count; i++) {
      otp.add(OTPInput());
    }
    otp.insert(0, SizedBox(width: 5));
    int lis = otp.length;
    otp.insert(lis, SizedBox(width: 5));
    return otp;
  }

  session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('login', 1);
    await prefs.setString('user', LogIn.registerNumber);
    print('Otp Submited');
  }

  _verifyPhone() async {
    try {
      setState(() {
        // Navbar.visiblity = false;
      });
      userCredential = await LogIn.confirmationResult.confirm(_otp.text);

      AlertOtp.userID = LogIn.confirmationResult.toString();
      AlertOtp.userID = LogIn.registerNumber;
      print('${AlertOtp.userID} ppppppppppppppppppp');
      userSession =
          await _firestore.collection('new users').doc(AlertOtp.userID).get();

      if (userSession.data() != null) {
        setState(() {
          isLogin = true;
        });

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => CoursesView()));
        Provider.of<OALive>(context, listen: false)
            .updateOA(routing: CoursesView());

        print('Otp.................got');

        //CoursesView() insted of Home,

        session();
      } else {
        Provider.of<Routing>(context, listen: false)
            .updateRouting(widget: Registration());
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'OTP Invalid',
            style: TextStyle(fontSize: 30.0),
          ),
        ],
      )));
    }
  }

  var userSession;
  getData() async {
    print(userSession.data() != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Stack(
        children: [
          Container(
            color: Color(0xff2B9DD1),
            width: double.infinity,
            child: Center(
              child: Container(
                width: 600.0,
                height: 1000,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 600.0,
                      height: 500.0,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      decoration: BoxDecoration(
                          color: Color(0xff006793),
                          borderRadius: BorderRadius.circular(6.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 350,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 55.0,
                                      width: 450,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: OTPTextField(
                                        length: 6,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        textFieldAlignment:
                                            MainAxisAlignment.spaceAround,
                                        fieldWidth: 50,
                                        onChanged: (value) {
                                          print(value);
                                        },
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        onCompleted: (value) {
                                          _otp.text = value;
                                        },
                                      ),
                                    ),
                                  ],
                                  // children: otpCount(6),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Countdown(
                                      seconds: 600,
                                      build:
                                          (BuildContext context, double time) =>
                                              Text(
                                        '${(time ~/ 60).toString().length == 1 ? "0" + (time ~/ 60).toString() : (time ~/ 60)} : ${(time % 60).toString().length == 1 ? "0" + (time % 60).toString() : (time % 60)}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 23.0,
                                        ),
                                      ),
                                      onFinished: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LogIn()));
                                      },
                                    ),
                                    SizedBox(
                                      width: 40.0,
                                    )
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RawMaterialButton(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xff014965),
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.0),
                                        width: 450.0,
                                        child: Text(
                                          'NEXT',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      elevation: 0.0,
                                      onPressed: () async {
                                        _verifyPhone();
                                      },
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MaterialButton(
                                      child: Icon(
                                        Icons.chevron_left,
                                        color: Color(0xff006793),
                                        size: 35.0,
                                      ),
                                      color: Colors.white,
                                      minWidth: 70.0,
                                      height: 70.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(70.0)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LogIn()));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
