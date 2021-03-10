import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:ocean_project/alert/alert_text_field.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: DownloadPDFAlert(),
    ),
  ));
}

final _firestore = FirebaseFirestore.instance;

class DownloadPDFAlert extends StatefulWidget {
  @override
  _DownloadPDFAlertState createState() => _DownloadPDFAlertState();
}

class _DownloadPDFAlertState extends State<DownloadPDFAlert> {
  ConfirmationResult confirmationResult;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential userCredential;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  void fireStoreAddWithDownload() {
    _firestore.collection('download pdf').doc('+91 ${_mobile.text}').set({
      'name': _name.text,
      'email': _email.text,
      'mobile number': '+91 ${_mobile.text}',
    });
  }

  downloadAlert({widget, context}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 600,
              width: 1200,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.grey[500]),
                        iconSize: 30,
                        splashRadius: 25,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  Container(
                    child: widget,
                  ),
                ],
              ),
            ),
          );
        });
  }

  getDownloadOTP() async {
    confirmationResult =
        await _auth.signInWithPhoneNumber('+91 ${_mobile.text}');
  }

  Future<void> _invalidOTP() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(
                'Sorry',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              SizedBox(width: 15),
              Icon(
                FontAwesomeIcons.frown,
                color: Colors.red,
              )
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Enter valid OTP or Update Mobile Number',
                  style: TextStyle(color: Colors.grey[500], fontSize: 25),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Enter OTP'),
              color: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                Navigator.of(context).pop();
                downloadAlert(context: context, widget: otpPage(_mobile.text));
              },
            ),
            FlatButton(
              child: Text('Update Number'),
              color: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                Navigator.of(context).pop();
                downloadAlert(context: context, widget: getUserDetails());
              },
            ),
          ],
        );
      },
    );
  }

  verifyOTP() async {
    try {
      userCredential = await confirmationResult.confirm(_otp.text);
      print(userCredential);
      print('OTP submited');
      fireStoreAddWithDownload();
      fieldClear();
      Navigator.pop(context);
    } catch (e) {
      print('$e OTP faild');
      Navigator.of(context).pop();
      _invalidOTP();
    }
  }

  fieldClear() {
    _mobile.clear();
    _email.clear();
    _name.clear();
    _otp.clear();
  }

  Widget otpPage(String userMobileNumber) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            height: 500,
            width: 600,
            child: Image.network(
              'images/download pdf/otp service.svg',
              fit: BoxFit.contain,
            )),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertTextField(
                errorText: 'invalid OTP',
                hintText: 'Enter OTP',
                icon: Icon(Icons.lock_clock),
                controller: _otp,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 2),
                        blurRadius: 5)
                  ],
                  color: Colors.white,
                ),
                child: FlatButton(
                  height: 60.0,
                  color: Colors.white,
                  minWidth: 360,
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
                        'submit',
                        style: TextStyle(fontSize: 20.0, color: Colors.blue),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    verifyOTP();
                  },
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.grey[500], fontSize: 15),
                    children: [
                      TextSpan(text: 'Not Received OTP'),
                      TextSpan(
                          text: ' Update MobileNumber?',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              Navigator.pop(context);
                              await downloadAlert(
                                  context: context, widget: getUserDetails());
                            }),
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getUserDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            height: 500,
            width: 600,
            child: Image.network(
              'images/download pdf/mail.svg',
              fit: BoxFit.contain,
            )),
        Container(
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AlertTextField(
                errorText: 'invalid Name',
                hintText: 'Name',
                icon: Icon(Icons.person),
                controller: _name,
              ),
              AlertTextField(
                hintText: 'Mobile',
                errorText: 'Enter Valid Number',
                icon: Icon(Icons.phone_android),
                controller: _mobile,
              ),
              AlertTextField(
                hintText: 'Email',
                errorText: 'invalid Email',
                icon: Icon(Icons.email),
                controller: _email,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 2),
                        blurRadius: 5)
                  ],
                  color: Colors.white,
                ),
                child: FlatButton(
                  height: 60.0,
                  color: Colors.white,
                  minWidth: 360,
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
                        'Send to Mail',
                        style: TextStyle(fontSize: 20.0, color: Colors.blue),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    getDownloadOTP();
                    Navigator.pop(context);
                    await downloadAlert(
                        context: context, widget: otpPage(_mobile.text));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        height: 50,
        width: 300,
        child: TextButton(
          child: Text('Download'),
          onPressed: () async {
            await downloadAlert(context: context, widget: getUserDetails());

            // await _downloadAlert(
            //     context: context, widget: );
          },
        ),
      )),
    );
  }
}
