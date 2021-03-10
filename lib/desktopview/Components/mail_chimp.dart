import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MailChimp());
}

class MailChimp extends StatefulWidget {
  @override
  _MailChimpState createState() => _MailChimpState();
}

class _MailChimpState extends State<MailChimp> {
  final _formkey = GlobalKey<FormState>();
  String email;
  String sendResponse;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Text("download pdf"),
              Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(8.0),
                //width: 200,
                child: TextFormField(
                  decoration: InputDecoration(hintText: "enter ur email"),
                  onChanged: (value) {
                    value = email;
                  },
                ),
              ),
              isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor),
                    )
                  : (sendResponse == null)
                      ? Container(
                          child: RaisedButton(
                            onPressed: submit,
                          ),
                        )
                      : Text("${sendResponse}"),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> submit() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      try {
        setState(() {
          isLoading = true;
        });
        final response = await http.post(
          "https://us1.admin.mailchimp.com/",
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
          },
          body: jsonEncode({"email": email}),
        );
        if (response.statusCode == 200) {
          setState(() {
            sendResponse = "check your email";
            isLoading = false;
          });
        } else {
          sendResponse = response.body;
          isLoading = false;
        }
      } catch (e) {
        sendResponse = "something get wromng";
        isLoading = false;
        print(e);
      }
    }
  }
}
