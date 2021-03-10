import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:http/http.dart' as http;

import 'package:ocean_project/webinar/wbinar_menubar.dart';
import 'package:ocean_project/webinar/webinar_const.dart';
import 'package:ocean_project/webinar/webinar_footer.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class WebinarScreen extends StatefulWidget {
  Timestamp timestamp;
  var webinar;
  WebinarScreen({this.timestamp, this.webinar});
  @override
  _WebinarScreenState createState() => _WebinarScreenState();
}

class _WebinarScreenState extends State<WebinarScreen> {
  bool timeUp;
  var sDate;

  /// Ijass work start
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
    http.Response response = await http.get(
        """https://us-central1-ocean-live-project-ea2e7.cloudfunctions.net/sendMail?dest=fotic78205@geeky83.com&sub=Zoom Link&html= <!DOCTYPE html>
<html>
<style>
table, th, td {
  border: 1px solid red;
  border-collapse: collapse;
}
</style>
<body>

<table border="outline">
<tbody>

<tr>
<td style="font-weight:bold;width:180px">Full Name</td>
<td>$name</td>
</tr>

<tr>
<td style="font-weight:bold;width:180px">Phone Number</td>
<td>$phoneNumber</td>
</tr>

<tr>
<td style="font-weight:bold;width:180px">Email</td>
<td>$email</td>
</tr>

</tbody>
</table>

</body>
</html>""");

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  /// Ijass work end
  /// jayalatha

  int yearFormat;
  int monthFormat;
  int dayFormat;
  int hourFormat;
  int minuteFormat;

  void retriveTime() {
    print('=============');
    var year = DateFormat('y');
    var month = DateFormat('MM');
    var day = DateFormat('d');
    var hour = DateFormat('hh');
    var minute = DateFormat('mm');

    yearFormat = int.parse(year.format(widget.timestamp.toDate()));
    monthFormat = int.parse(month.format(widget.timestamp.toDate()));
    dayFormat = int.parse(day.format(widget.timestamp.toDate()));
    hourFormat = int.parse(hour.format(widget.timestamp.toDate()));
    minuteFormat = int.parse(minute.format(widget.timestamp.toDate()));

    sDate =
        DateTime(yearFormat, monthFormat, dayFormat, hourFormat, minuteFormat)
            .difference(DateTime.now())
            .inSeconds;
  }

  /// jayalatha

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retriveTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              WebinarMenu(),

              Container(
                alignment: Alignment.center,
                height: 40,
                color: Colors.blue,
                child: Text(
                    'From the Master Energy Healer with 200,000 Ocean Academy Students Since 2012',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 1000,
                child: Text(
                  'Heal Your Past. Clear Your Blocks. And Turn 2021 Into Your Most Abundant Year Yet.',
                  style: kHeaddingTitle,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 1000,
                child: Text(
                  'Discover eye-opening insights into the world of abundance blocks and how they prevent you every day from manifesting thewealth you deserve.',
                  style: TextStyle(
                      inherit: false,
                      fontSize: 20,
                      color: Color(0xffFF757575),
                      fontFamily: kfontname,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              //mentor image and name and login
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 3),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 550,
                              width: 800,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  'https://i.insider.com/54e75c79eab8ea2e0cd8ea8d?width=1100&format=jpeg&auto=webp',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 800,
                              height: 70,
                              color: Colors.grey[200],
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'With Steve Jobs',
                                style: TextStyle(
                                    inherit: false,
                                    fontSize: 30,
                                    color: Colors.grey[700],
                                    fontFamily: kfontname,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )),
                    Spacer(),
                    // Join and timer
                    Container(
                      width: 450,
                      height: 630,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: kBlue, width: 3),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///TODO TextField and timer join button
                          //timer
                          Column(
                            children: [
                              Container(
                                width: 600,
                                height: 100,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 110,
                                      decoration: BoxDecoration(

                                          // border: Border.all(
                                          //     color: kBlue, width: 3),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 47,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Positioned(
                                                      bottom: 0,
                                                      child:
                                                          SlideCountdownClock(
                                                        duration: Duration(
                                                            seconds: sDate),
                                                        separator: ' : ',
                                                        textStyle: TextStyle(
                                                            fontSize: 40,
                                                            fontFamily:
                                                                kfontname,
                                                            color: kBlue),
                                                        separatorTextStyle:
                                                            TextStyle(
                                                                fontSize: 35,
                                                                color: kBlue),
                                                        shouldShowDays: true,
                                                        onDone: () {
                                                          setState(() {
                                                            print(
                                                                DateTime.now());
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 290,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'DAYS',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily: kfontname,
                                                          color: kBlue),
                                                    ),
                                                    SizedBox(width: 1),
                                                    Text(
                                                      'HRS',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily: kfontname,
                                                          color: kBlue),
                                                    ),
                                                    SizedBox(width: 1),
                                                    Text(
                                                      'MIN',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily: kfontname,
                                                          color: kBlue),
                                                    ),
                                                    SizedBox(width: 1),
                                                    Text(
                                                      'SEC',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily: kfontname,
                                                          color: kBlue),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 40,
                                child: Text(
                                  'Webinar Start In...',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                color: Colors.blue,
                                width: double.infinity,
                              ),
                            ],
                          ),

                          Form(
                            key: _formKey,
                            child: Container(
                              height: 240,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildName(),
                                  _buildphonenumber(),
                                  _buildEmail(),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 0),
                            child: MaterialButton(
                                child: Text(
                                  'Join',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                color: kBlue,
                                minWidth: double.infinity,
                                height: 60,
                                elevation: 0,
                                hoverElevation: 0,
                                onPressed: () async {
                                  print('1');
                                  if (_formKey.currentState.validate()) {
                                    print('2');
                                    if (name != null &&
                                        email != null &&
                                        phoneNumber != null) {
                                      print('3');
                                      _firestore
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
                                  }
                                }),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 16),
                                  text:
                                      'By clicking the button above, you are creating an account with Ocean Academy and agree to our ',
                                  children: [
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print('Privacy Policy taped');
                                          },
                                        text: 'Privacy Policy',
                                        style: TextStyle(color: kBlue)),
                                    TextSpan(text: ' and '),
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print('Terms of Use taped');
                                          },
                                        text: 'Terms of Use',
                                        style: TextStyle(color: kBlue)),
                                    TextSpan(
                                        text: ', including receiving emails. '),
                                  ]),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Spacer(flex: 3)
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                alignment: Alignment.center,
                height: 200,
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 1000,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.group,
                                    size: 40,
                                    color: Colors.grey[800],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '100+',
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        inherit: false,
                                        color: Colors.grey[800]),
                                  ),
                                ],
                              ),
                              Text(
                                'STUDENTS ENROLLED',
                                style: kContentSubtitle,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 60,
                            child: Divider(
                              thickness: 60,
                              color: Colors.grey[500],
                            ),
                            width: 3,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    size: 40,
                                    color: Colors.grey[800],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '90 Minutes',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        inherit: false,
                                        color: Colors.grey[800]),
                                  ),
                                ],
                              ),
                              Text(
                                'MASTERCLASS',
                                style: kContentSubtitle,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 60,
                            child: Divider(
                              thickness: 60,
                              color: Colors.grey[500],
                            ),
                            width: 3,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.award,
                                    size: 35,
                                    color: Colors.grey[800],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '1,000+',
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        inherit: false,
                                        color: Colors.grey[800]),
                                  ),
                                ],
                              ),
                              Text(
                                'STORIES ON OCEAN ACADEMY',
                                style: kContentSubtitle,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              //Watch The Preview For This Masterclass
              Text(
                'Watch The Preview For This Masterclass',
                style: kTitle,
              ),
              SizedBox(height: 20),
              Container(
                height: 510,
                width: 870,
                color: Colors.lightBlue[100],
              ),
              SizedBox(height: 40),
              Text(
                'What You’ll Learn',
                style: kTitle,
              ),
              SizedBox(height: 40),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: 1000,
                    child: Text(
                      '1. How abundance blocks are holding you back from wealth',
                      style: kContentTitle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.only(left: 25),
                    width: 1000,
                    child: Text(
                      'Discover eye-opening insights into the world of abundance blocks and how they prevent you every day from manifesting thewealth you deserve.',
                      style: kContentSubtitle,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 1000,
                    child: Text(
                      '1. How abundance blocks are holding you back from wealth',
                      style: kContentTitle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.only(left: 25),
                    width: 1000,
                    child: Text(
                      'Discover eye-opening insights into the world of abundance blocks and how they prevent you every day from manifesting thewealth you deserve.',
                      style: kContentSubtitle,
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.symmetric(vertical: 50),
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'About Mentor',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.grey[100],
                          height: 650,
                          width: 500,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'Christie Marie Sheldon, a fully realized intuitive healer and author, is the #1 in-demand author at Mindvalley committed to using her gift to help people eliminate their energy blocks, raise their vibrations and manifest their ideal realities.',
                                  style: kContentSubtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'Christie Marie Sheldon, a fully realized intuitive healer and author, is the #1 in-demand author at Mindvalley committed to using her gift to help people eliminate their energy blocks, raise their vibrations and manifest their ideal realities.',
                                  style: kContentSubtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'Christie Marie Sheldon, a fully realized intuitive healer and author, is the #1 in-demand author at Mindvalley committed to using her gift to help people eliminate their energy blocks, raise their vibrations and manifest their ideal realities.',
                                  style: kContentSubtitle,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 50),
                        Container(
                          height: 650,
                          width: 500,
                          child: Image(
                            image: NetworkImage(
                                'https://addicted2success.com/wp-content/uploads/2017/11/10-Things-We-Can-Learn-From-the-Incredible-Steve-Jobs.jpg'),
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 40),
              WebinarFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
