import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_project/desktopview/screen/contact_us.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'ocean_icons.dart';

class PopupDialog extends StatefulWidget {
  @override
  _PopupDialogState createState() => _PopupDialogState();
}

class _PopupDialogState extends State<PopupDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final _fullNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  String fullName;
  String phoneNumber;
  String email;

  @override
  Widget build(BuildContext context) {
    return null;
  }

  onAlertWithStylePressed(dialogContext) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: true,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(
            color: Colors.red,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.red,
        ),
        constraints: BoxConstraints.expand(width: 5000, height: 1000),
        //First to chars "55" represents transparency of color
        overlayColor: Color(0x55000000),
        alertElevation: 0,
        alertAlignment: Alignment.topCenter);

    var alert = Alert(
      context: context,
      style: alertStyle,
      title: "Quick Enquiry",
      desc: "Ocean Acadamey",
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue[50],
                    child: CircleAvatar(
                      radius: 50,
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
                            fullName = value;
                          },
                          controller: _fullNameController,
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
                            phoneNumber = value;
                          },
                          controller: _mobileController,
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
                            email = value;
                          },
                          controller: _emailController,
                          validator: (value) => EmailValidator.validate(value)
                              ? null
                              : "Please enter a valid email*",
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                              RegExp(r"\s"),
                            ),
                          ],
                          decoration: InputDecoration(
                            errorStyle:
                                TextStyle(color: Colors.red, fontSize: 11),
                            hintText: 'Enter Your Email',
                            // labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                ],
              )
            ],
          ),
        ),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              _firestore.collection('Alert_Contact_US').add(
                {
                  'Full Name': fullName,
                  'Phone_Number': phoneNumber,
                  'Email': email
                },
              );
              _fullNameController.clear();
              _mobileController.clear();
              _emailController.clear();

              // Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Submitted Successfully'),
                ),
              );
              // Navigator.of(context).pop();
              // Navigator.of(context, rootNavigator: true).pop('dialog');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ContactUs(),
                ),
              );
            }
          },
          // onPressed: () => Navigator.pop(dialogContext),
          color: Color(0xff0091D2),
          radius: BorderRadius.circular(10.0),
        ),
      ],
    );
    alert.show();
  }
}
