import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/webinar/countdown.dart';
import 'package:ocean_project/webinar/webinar_const.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Webinar extends StatefulWidget {
  @override
  _WebinarState createState() => _WebinarState();
}

class _WebinarState extends State<Webinar> {
  //< ijass part >
  String name;
  String phoneNumber;
  String email;
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  Widget _buildName() {
    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
        LengthLimitingTextInputFormatter(40),
      ],
      validator: (value) {
        if (value.isEmpty) {
          return 'name is required';
        } else if (value.length < 3) {
          return 'character should be morethan 2';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.drive_file_rename_outline),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: OutlineInputBorder(),
        hintText: "enter your name",
        labelText: 'Name',
      ),
      controller: nameController,
      onChanged: (value) {
        name = value;
      },
    );
  }

  Widget _buildphonenumber() {
    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r"^\d+\.?\d{0,2}"),
        ),
        LengthLimitingTextInputFormatter(10),
      ],
      validator: (value) {
        if (value.isEmpty) {
          return 'phone_number is required';
        } else if (value.length < 10) {
          return 'invalid phone_number';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone_android_outlined),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: OutlineInputBorder(),
        hintText: 'Enter Your Number',
        labelText: 'Phone Number',
      ),
      controller: phoneNumberController,
      onChanged: (value) {
        phoneNumber = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
      validator: (value) =>
          EmailValidator.validate(value) ? null : "please enter a valid email",
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: OutlineInputBorder(),
        hintText: 'Enter Your Email',
        labelText: 'Email',
      ),
      controller: emailController,
      onChanged: (value) {
        email = value;
      },
    );
  }

  void getData() async {
    http.Response htmlcontent = await http.get('assets/webinar_link.html');
    http.Response response = await http.get(
        """https://us-central1-ocean-live-project-ea2e7.cloudfunctions.net/sendMail?dest=$email&sub=Zoom div Link&html= <html> ${htmlcontent.body}

""");

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            // title: Text('TextField AlertDemo'),
            content: Container(
              height: 450,
              child: Padding(
                padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                child: Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 320,
                            child: Image.network("images/webinar/join.svg"),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Container(
                              height: 80, width: 300, child: _buildName()),
                          SizedBox(height: 15),
                          Container(
                              height: 75,
                              width: 300,
                              child: _buildphonenumber()),
                          SizedBox(height: 15),
                          Container(
                              height: 75, width: 300, child: _buildEmail()),
                          SizedBox(height: 15),
                          MaterialButton(
                              minWidth: 310,
                              color: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 30, right: 30),
                                child: Text(
                                  "Join",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (name != null &&
                                      email != null &&
                                      phoneNumber != null) {
                                    await _firestore
                                        .collection('webinar')
                                        .doc(phoneNumber)
                                        .set({
                                      'name': name,
                                      'email': email,
                                      'Phone_Number': phoneNumber
                                    });
                                  }
                                  getData();
                                  nameController.clear();
                                  emailController.clear();
                                  phoneNumberController.clear();
                                  Navigator.pop(context);
                                }
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
  //< ijass part end >

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'images/webinar/webinar bg.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Container(
          height: 700,
          width: 1300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  width: 900,
                  height: 580,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          height: 1000,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Timer(
                                onPressed: () {
                                  _displayDialog(context);
                                },
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Container(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image(
                                        image: NetworkImage(
                                            'images/webinar/register.svg')),
                                    Positioned(
                                      left: 50,
                                      child: GestureDetector(
                                        onTap: () {
                                          _displayDialog(context);
                                        },
                                        child: Image(
                                          image: NetworkImage(
                                              'images/webinar/playIcon.svg'),
                                          width: 90,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(
                                flex: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          width: 900,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cloud computing',
                                style: TextStyle(
                                    fontSize: 60,
                                    fontFamily: kfontname,
                                    color: Colors.grey[600]),
                              ),
                              SizedBox(height: 15),
                              Container(
                                width: 700,
                                child: Text(
                                  'Cloud computing is the on-demand availability of computer system resources, especially data storage and computing power, without direct active management by the user. The term is generally used to describe data centers available to many users over the Internet.',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: kfontname,
                                      color: Colors.grey[600]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  child: Container(
                    height: 700,
                    width: 500,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 20,
                          child: Image(
                            image: NetworkImage('images/webinar/notebook.svg'),
                            height: 680,
                          ),
                        ),
                        Positioned(
                          top: 30,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(15),
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Color(0xffCCEAF5),
                                    borderRadius: BorderRadius.circular(300),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Colors.grey[900].withOpacity(1),
                                          offset: Offset(0, 6))
                                    ]),
                              ),
                              Text(
                                'Mentor Name',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: kBlue,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
