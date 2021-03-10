import 'package:flutter/material.dart';

class AlertDetails extends StatefulWidget {
  static String userID;
  @override
  _AlertDetailsState createState() => _AlertDetailsState();
}

class _AlertDetailsState extends State<AlertDetails> {
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 70.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 50.0,
                                            width: 400.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(3.0)),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(),
                                                  hintText: "Enter your name"),
                                              //controller: _phoneNumberController,
                                              // inputFormatters: [
                                              //   FilteringTextInputFormatter.allow(
                                              //       RegExp(r'^\d+\.?\d{0,1}')),
                                              //   LengthLimitingTextInputFormatter(
                                              //       13),
                                              // ],
                                              onChanged: (value) {
                                                setState(() {
                                                  // phoneNumber = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      height: 50.0,
                                      width: 400.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(3.0)),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(),
                                            hintText: "Enter your email"),
                                        onChanged: (value) {
                                          setState(() {
                                            // phoneNumber = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                  // children: otpCount(6),
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
                                        width: 400.0,
                                        child: Text(
                                          'NEXT',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      elevation: 0.0,
                                      onPressed: () async {},
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
                                      onPressed: () {},
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
