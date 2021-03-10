import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;

class WebinarAlert extends StatefulWidget {
  @override
  _WebinarAlertState createState() => _WebinarAlertState();
}

class _WebinarAlertState extends State<WebinarAlert> {
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
        """https://us-central1-ocean-live-project-ea2e7.cloudfunctions.net/sendMail?dest=thamizharasan2373@gmail.com&sub=Zoom Link&html= <!DOCTYPE html>
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        color: Colors.white,
        onPressed: () {
          _displayDialog(context);
        },
        child: Text('data'),
      ),
    );
  }
}
