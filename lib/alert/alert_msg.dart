import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'alert_text_field.dart';

final _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class AlertEnquiry extends StatefulWidget {
  AlertEnquiry(
      {this.buttonName = 'Submit',
      this.queryField = true,
      this.pdfLink,
      this.keyIsFirstLoaded});
  final String buttonName;
  bool queryField;
  String pdfLink;
  final keyIsFirstLoaded;
  @override
  _AlertEnquiryState createState() => _AlertEnquiryState();
}

class _AlertEnquiryState extends State<AlertEnquiry> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _query = TextEditingController();

  bool isEmail = false;
  bool isName = false;
  bool isPhoneNumber = false;
  bool isQuery = false;

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool nameValidation(String value) {
    Pattern pattern = r"[a-zA-Z]+|\s";
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool phoneNumberValidation(String value) {
    Pattern pattern = r'^\d+\.?\d{0,2}';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      // backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        width: 400.0,
        height: widget.queryField ? 680 : 560,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // close icon
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    iconSize: 30,
                    splashRadius: 30,
                    color: Colors.grey,
                    onPressed: () {
                      print('close Alert');
                      Navigator.pop(context);
                    },
                  )
                ],
              ),

              // ocean logo
              Container(
                child: Expanded(
                  child: Image(
                    image: AssetImage('images/alert.png'),
                    width: 350,
                  ),
                ),
              ),
              //text field
              AlertTextField(
                errorText: 'invalid Name',
                hintText: 'Name',
                icon: Icon(Icons.person),
                controller: _name,
                onChanged: (value) {
                  setState(() {
                    if (nameValidation(_name.text) && _name.text.length > 3) {
                      setState(() {
                        isName = true;
                      });
                    } else {
                      setState(() {
                        isName = false;
                      });
                    }
                  });
                },
                suffixIcon: isName != true
                    ? Icon(
                        Icons.close,
                        color: Colors.red,
                      )
                    : Icon(Icons.check, color: Colors.green),
              ),
              AlertTextField(
                  hintText: 'Mobile',
                  errorText: 'Enter Valid Number',
                  icon: Icon(Icons.phone_android),
                  controller: _mobile,
                  suffixIcon: isPhoneNumber != true
                      ? Icon(
                          Icons.close,
                          color: Colors.red,
                        )
                      : Icon(Icons.check, color: Colors.green),
                  onChanged: (value) {
                    setState(() {
                      if (_mobile.text.length == 10 &&
                          phoneNumberValidation(_mobile.text)) {
                        setState(() {
                          isPhoneNumber = true;
                        });
                      } else {
                        setState(() {
                          isPhoneNumber = false;
                        });
                      }
                    });
                  }),
              AlertTextField(
                hintText: 'Email',
                errorText: 'invalid Email',
                icon: Icon(Icons.email),
                controller: _email,
                suffixIcon: isEmail != true
                    ? Icon(
                        Icons.close,
                        color: Colors.red,
                      )
                    : Icon(Icons.check, color: Colors.green),
                onChanged: (value) {
                  setState(() {
                    if (validateEmail(_email.text)) {
                      setState(() {
                        isEmail = true;
                      });
                    } else {
                      setState(() {
                        isEmail = false;
                      });
                    }
                  });
                },
              ),
              Visibility(
                visible: widget.queryField,
                child: AlertQueryField(
                  hintText: 'Query',
                  errorText: 'Enter your Query',
                  icon: Icon(
                    Icons.question_answer_rounded,
                  ),
                  controller: _query,
                  suffixIcon: isQuery != true
                      ? Icon(
                          Icons.close,
                          color: Colors.red,
                        )
                      : Icon(Icons.check, color: Colors.green),
                  onChanged: (value) {
                    setState(() {
                      if (_query.text.isNotEmpty && _query.text.length > 6) {
                        isQuery = true;
                      } else {
                        isQuery = false;
                      }
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: FlatButton(
                  minWidth: 363.0,
                  color: Colors.blue,
                  height: 50.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    widget.buttonName,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  onPressed: () async {
                    if (widget.queryField) {
                      if (validateEmail(_email.text) &&
                          _mobile.text.length >= 10 &&
                          nameValidation(_name.text) &&
                          _name.text.length > 3 &&
                          _query.text.length > 6) {
                        print(' with query done');
                        firestoreAddQuickEnquiry();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool(widget.keyIsFirstLoaded, false);
                        Navigator.of(context).pop();
                        Flushbar(
                          icon: Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                          message: "Sent Successfully",
                          duration: Duration(seconds: 2),
                        )..show(context);
                      } else {
                        print('fill all field');
                      }
                    } else {
                      if (validateEmail(_email.text) &&
                          _mobile.text.length >= 10 &&
                          nameValidation(_name.text) &&
                          _name.text.length > 3) {
                        print('without query field');
                        fireStoreAddWithDownload();
                        var url = widget.pdfLink;
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      } else {
                        print('fill all field');
                      }
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: FlatButton(
                  minWidth: 363.0,
                  color: Colors.redAccent,
                  height: 50.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    'Close',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fireStoreAddWithDownload() {
    _firestore.collection('download pdf').doc().set({
      'name': _name.text,
      'email': _email.text,
      'phonenumber': _mobile.text,
    });
  }

  void firestoreAddQuickEnquiry() {
    _firestore.collection('Quick Enquiry').add({
      'name': _name.text,
      'email': _email.text,
      'phonenumber': _mobile.text,
      'query': _query.text
    });
  }
}
