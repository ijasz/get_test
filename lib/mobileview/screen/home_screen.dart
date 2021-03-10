import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_project/alert/alert_msg.dart';
import 'package:ocean_project/mobileview/components/how_it_works.dart';
import 'package:ocean_project/mobileview/components/main_badget_widget.dart';
import 'package:ocean_project/mobileview/components/ocean_icons.dart';
import 'package:ocean_project/mobileview/components/placement_company.dart';
import 'package:ocean_project/mobileview/components/reviews.dart';
import 'package:ocean_project/mobileview/components/slider_widget.dart';
import 'package:ocean_project/mobileview/components/upcoming_course_widget.dart';
import 'package:ocean_project/mobileview/screen/footer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class Home extends StatelessWidget {
  GlobalKey<FormState> formKeyAlert = GlobalKey<FormState>();
  // final GlobalKey<FormState> _formKeyAlert = GlobalKey<FormState>();

  final _fullNameAlertController = TextEditingController();
  final _mobileAlertController = TextEditingController();
  final _emailAlertController = TextEditingController();
  final keyIsFirstLoaded = 'is_first_loaded';

  String fullNameAlert;
  String phoneNumberAlert;
  String emailAlert;

  bool flag = true;
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SliderWidget(),
            MainBadgeWidget(),
            UpcomingCourse(),
            PlacementCompany(),
            ReviewsSection(),
            HowItWorks(),
            Footer(),
          ],
        ),
      ),
    );
  }

  Future showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: flag,
        isOverlayTapDismiss: true,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          // side: BorderSide(color: Colors.red),
        ),
        titleStyle: TextStyle(
            color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 25),
        constraints: BoxConstraints.expand(width: 5000, height: 1000),
        //First to chars "55" represents transparency of color
        overlayColor: Color(0x55000000),
        alertElevation: 100,
        alertAlignment: Alignment.topCenter);
    if (isFirstLoaded == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertEnquiry(buttonName: 'Submit');
          AlertDialog(
            title: Center(
              child: Row(
                children: [
                  SizedBox(width: 120),
                  Text(
                    'OCEAN ACADAMEY',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.lightBlue),
                  ),
                  SizedBox(width: 92),
                  Container(
                    height: 28,
                    width: 39,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        prefs.setBool(keyIsFirstLoaded, false);
                      },
                      child: Icon(Icons.cancel_outlined, size: 25),
                    ),
                  ),
                ],
              ),
            ),
            content: Form(
              key: formKeyAlert,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20),
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.blue[50],
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blue[100],
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.blue[200],
                              child: Icon(
                                Ocean.oa,
                                size: 45,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          children: [
                            Text(
                              'Full Name',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff505050),
                              ),
                            ),
                            SizedBox(width: 43),
                            Container(
                              height: 60,
                              width: 350,
                              child: TextFormField(
                                onChanged: (value) {
                                  fullNameAlert = value;
                                },
                                controller: _fullNameAlertController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'name is required*';
                                  } else if (value.length < 3) {
                                    return 'character should be morethan 2*';
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r"[a-zA-Z]+|\s"),
                                  ),
                                  LengthLimitingTextInputFormatter(40),
                                ],
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.drive_file_rename_outline),
                                  errorStyle: TextStyle(
                                      fontSize: 11, color: Colors.redAccent),
                                  hintText: 'Enter Your Name',
                                  // labelText: 'Name',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Text(
                              'Mobile',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff505050),
                              ),
                            ),
                            SizedBox(width: 65),
                            Container(
                              height: 60,
                              width: 350,
                              child: TextFormField(
                                onChanged: (value) {
                                  phoneNumberAlert = value;
                                },
                                controller: _mobileAlertController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'phone_number is required';
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r"^\d+\.?\d{0,2}"),
                                  ),
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.phone_android_outlined),
                                  errorStyle: TextStyle(
                                      fontSize: 11, color: Colors.redAccent),
                                  hintText: 'Enter Your Mobile',
                                  // labelText: 'Mobile Number',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff505050),
                              ),
                            ),
                            SizedBox(width: 78),
                            Container(
                              height: 60,
                              width: 350,
                              child: TextFormField(
                                onChanged: (value) {
                                  emailAlert = value;
                                },
                                controller: _emailAlertController,
                                validator: (value) =>
                                    EmailValidator.validate(value)
                                        ? null
                                        : "Please enter a valid email*",
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s"),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  errorStyle: TextStyle(
                                      color: Colors.red, fontSize: 11),
                                  hintText: 'Enter Your Email',
                                  // labelText: 'Email',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.lightBlue,
                                    Colors.lightBlueAccent,
                                    Colors.blueAccent
                                  ]),
                                  borderRadius: BorderRadius.circular(50)),
                              child: FlatButton(
                                color: Colors.blue,
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                onPressed: () {
                                  if (formKeyAlert.currentState.validate()) {
                                    formKeyAlert.currentState.save();

                                    _firestore
                                        .collection('Alert_Contact_US')
                                        .add(
                                      {
                                        'Full Name': fullNameAlert,
                                        'Phone_Number': phoneNumberAlert,
                                        'Email': emailAlert
                                      },
                                    );
                                    _fullNameAlertController.clear();
                                    _mobileAlertController.clear();
                                    _emailAlertController.clear();
                                    // Close the dialog
                                    Navigator.of(context).pop();
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => HomePage(),
                                    //   ),
                                    // );
                                    prefs.setBool(keyIsFirstLoaded, false);

                                    // Navigator.of(dialogContext).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Row(
                                        children: [
                                          Icon(Icons.done_outline_outlined,
                                              color: Colors.white),
                                          SizedBox(width: 20),
                                          Text('Sent Successfully'),
                                        ],
                                      )),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
