import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/alert/alert_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final _firestore = FirebaseFirestore.instance;

class DownloadAlert extends StatefulWidget {
  DownloadAlert(
      {this.buttonName = 'Send Mail',
      this.queryField = true,
      this.pdfLink,
      this.keyIsFirstLoaded});
  final String buttonName;
  bool queryField;
  String pdfLink;
  final keyIsFirstLoaded;
  @override
  _DownloadAlertState createState() => _DownloadAlertState();
}

class _DownloadAlertState extends State<DownloadAlert> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _email = TextEditingController();

  bool isEmail = false;
  bool isName = false;
  bool isPhoneNumber = false;
  bool isQuery = false;
  bool isEmpty = true;

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
    return Container(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
            suffixIcon: isEmpty
                ? null
                : isName != true
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
              suffixIcon: isEmpty
                  ? null
                  : isPhoneNumber != true
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
            suffixIcon: isEmpty
                ? null
                : isEmail != true
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 3),
                    blurRadius: 6)
              ],
              color: Colors.white,
            ),
            child: FlatButton(
              height: 60.0,
              color: Colors.white,
              minWidth: 350,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0)),
              child: Row(
                children: [
                  Container(
                      width: 30,
                      height: 30,
                      child: Image.network(
                          'images/download pdf/mail service.svg')),
                  SizedBox(width: 6),
                  Text(
                    widget.buttonName,
                    style: TextStyle(fontSize: 20.0, color: Colors.blue),
                  ),
                ],
              ),
              onPressed: () async {
                if (validateEmail(_email.text) &&
                    _mobile.text.length >= 10 &&
                    nameValidation(_name.text) &&
                    _name.text.length > 3) {
                  print('without query field');
                  fireStoreAddWithDownload();
                  Navigator.pop(context);
                  var url = widget.pdfLink;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                } else {
                  setState(() {
                    isEmpty = false;
                  });
                  print('fill all field');
                }
              },
            ),
          ),
        ],
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
}
