import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';

import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/new_user_widget/contry_states.dart';

import 'package:ocean_project/desktopview/new_user_widget/date_picker.dart';
import 'package:ocean_project/desktopview/new_user_widget/dropdown.dart';
import 'package:ocean_project/desktopview/new_user_widget/gender_dropdoen_field.dart';
import 'package:ocean_project/desktopview/new_user_widget/input_text_field.dart';
import 'package:ocean_project/desktopview/route/routing.dart';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _firestore = FirebaseFirestore.instance;
  //text field controller and variable
  // GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String eMail;
  String companyOrSchool;
  String dgree;
  String country;
  String state;
  String phoneNumber;
  String portfolioLink;
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  String dOB;
  final _dateOfBirth = TextEditingController();
  Future<DateTime> _selectDateTime(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime.now());
  }

  final _eMail = TextEditingController();
  final _companyOrSchool = TextEditingController();
  final _dgree = TextEditingController();
  final _country = TextEditingController();
  final _state = TextEditingController();
  final _phoneNumber = TextEditingController(text: LogIn.registerNumber);

  List inputFormatte({@required String regExp, int length}) {
    List<TextInputFormatter> formater = [
      FilteringTextInputFormatter.allow(RegExp(regExp)),
      LengthLimitingTextInputFormatter(length)
    ];
    return formater;
  }

  session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('login', 1);
    print('Otp Submited');
  }

  Uint8List uploadFile;
  String fileName;
  String profilePictureLink;

  Map<String, List> stateAndContry = {};
  contryPicker() {
    for (var i in contryState.entries) {
      List countryList = i.value;
      for (var j in countryList) {
        String contry = j['country'];
        List states = j['states'];
        stateAndContry.addAll({contry: states});
      }
    }
    splitCountryAndState();
  }

  List<DropdownMenuItem<String>> countryList = [];
  splitCountryAndState() {
    setState(() {
      countryList.clear();
    });
    for (var i in stateAndContry.entries) {
      DropdownMenuItem<String> addCountry = DropdownMenuItem(
        child: Text(i.key),
        value: i.key,
      );
      countryList.add(addCountry);
    }
  }

  List<DropdownMenuItem<String>> states = [];
  statePicker(String state) {
    setState(() {
      states.clear();
    });
    for (var i in stateAndContry[state]) {
      print(i);
      DropdownMenuItem<String> state = DropdownMenuItem(
        child: Text(i),
        value: i,
      );
      states.add(state);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contryPicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Color(0xff2B9DD1),
          height: 1000.0,
        ),
        Positioned(
            top: -70,
            left: -250.0,
            child: Image.asset(
              'images/rectangle-01.png',
              width: 600.0,
            )),
        Positioned(
            top: -90,
            right: 100.0,
            child: Image.asset(
              'images/tryangle-01.png',
              width: 350.0,
            )),
        Positioned(
            bottom: 90,
            right: 0.0,
            child: Image.asset(
              'images/circle-01.png',
              width: 450.0,
            )),
        Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: 1250,
              decoration: BoxDecoration(
                  color: Color(0xff006793),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register Your Account',
                        style: TextStyle(fontSize: 50.0, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(500.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 8.0,
                                  offset: Offset(4.0, 4.0))
                            ]),
                        child: GestureDetector(
                          onTap: () async {
                            FilePickerResult result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result != null) {
                              uploadFile = result.files.single.bytes;
                              fileName = basename(result.files.single.name);
                              print(fileName);
                            } else {
                              print('pick image');
                            }
                            // Upload to  firebase Storage
                            Future uploadProfilePicture(
                                BuildContext context) async {
                              Reference firebaseStorageRef = FirebaseStorage
                                  .instance
                                  .ref()
                                  .child(fileName);
                              UploadTask uploadTask =
                                  firebaseStorageRef.putData(uploadFile);
                              // SnakBar Message
                              TaskSnapshot taskSnapShot =
                                  await uploadTask.whenComplete(() {
                                setState(() {
                                  print('Profile Picuter Upload Complete');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Profile picture Uploaded')));
                                  // get Link
                                  uploadTask.snapshot.ref
                                      .getDownloadURL()
                                      .then((value) {
                                    setState(() {
                                      profilePictureLink = value;
                                    });
                                  });
                                });
                              });
                            }

                            print(profilePictureLink);
                            uploadProfilePicture(
                                context); // call upload function
                          },
                          child: CircleAvatar(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(500.0),
                              child: Container(
                                color: Colors.white,
                                width: 300.0,
                                height: 300.0,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    profilePictureLink != null
                                        ? Image.network(
                                            profilePictureLink,
                                            width: 500.0,
                                            height: 500.0,
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(
                                            Icons.add_a_photo,
                                            color: Colors.blue,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            radius: 50.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    // key: formkey,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        LableWithTextField(
                          lableText: 'First Name',
                          errorText: 'Enter First Name',
                          width: 300.0,
                          controller: _firstName,
                          visible: isFirstName,
                          onChanged: (value) {},
                          inputFormatters: inputFormatte(
                              regExp: r"[a-zA-Z]+|\s", length: 15),
                        ),
                        LableWithTextField(
                            lableText: 'Last Name',
                            errorText: 'Enter Last Name',
                            width: 300.0,
                            visible: isLastName,
                            controller: _lastName,
                            onChanged: (value) {},
                            inputFormatters: inputFormatte(
                                regExp: r"[a-zA-Z]+|\s", length: 15)),
                        GenderDropdownField(
                          visible: isGender,
                          errorText: 'Select',
                        ),
                        DatePicker(
                          errorText: 'Date Required',
                          datePickerIcon: IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () async {
                              final selectedDate =
                                  await _selectDateTime(context);
                              setState(() {
                                dOB = DateFormat('d-M-y').format(selectedDate);
                                _dateOfBirth.text = dOB;
                                print('${dOB}');
                              });
                            },
                          ),
                          controller: _dateOfBirth,
                          visible: isDateOfBirth,
                          onChanged: (value) {
                            setState(() {
                              _dateOfBirth.text = value;
                            });
                          },
                        ),
                        LableWithTextField(
                          lableText: 'E-Mail Adsress',
                          errorText: 'Invalid Email Adress',
                          visible: isEmail,
                          width: 300.0,
                          controller: _eMail,
                          onChanged: (value) {},
                        ),
                        LableWithTextField(
                          lableText: 'Company/School',
                          errorText: 'Your Company/School Name',
                          width: 300.0,
                          visible: isCompanyOrSchool,
                          controller: _companyOrSchool,
                          inputFormatters:
                              inputFormatte(regExp: r"[a-zA-Z]+|\s"),
                          onChanged: (value) {},
                        ),
                        LableWithTextField(
                          lableText: 'Degree',
                          errorText: 'Enter your Education Qualification',
                          width: 250.0,
                          visible: isDegree,
                          controller: _dgree,
                          onChanged: (value) {},
                        ),
                        ContryPicker(
                          labelText: 'Country',
                          errorText: 'select country',
                          items: countryList,
                          color: Colors.white,
                          visible: isCountry,
                          value: country,
                          onChanged: (value) {
                            setState(() {
                              country = value;
                              states = [];

                              statePicker(country);
                            });
                          },
                        ),
                        ContryPicker(
                          labelText: 'State',
                          errorText: 'select State',
                          items: states,
                          visible: isState,
                          value: state,
                          onChanged: (value) {
                            setState(() {
                              state = value;
                            });
                          },
                        ),
                        LableWithTextField(
                          lableText: 'Phone Number',
                          errorText: 'Invalid Phonenumber',
                          width: 250.0,
                          rReadOnly: true,
                          visible: isPhoneNumber,
                          controller: _phoneNumber,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                          minWidth: 300.0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            ),
                          ),
                          color: Color(0xff014965),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          onPressed: () {
                            if (registerFormValidation() == true) {
                              print('Completed');

                              fireStoreAdd();

                              textFieldClear();
                              session();
                              // Provider.of<Routing>(context, listen: false)
                              //     .updateRouting(widget: CoursesView());
                              Provider.of<OALive>(context, listen: false)
                                  .updateOA(routing: CoursesView());
                            } else {
                              Provider.of<Routing>(context, listen: false)
                                  .updateRouting(widget: Registration());
                            }

                            // fireStoreAdd();
                            //  textFieldClear();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  void fireStoreAdd() {
    _firestore.collection('new users').doc(_phoneNumber.text).set({
      'Profile Picture': profilePictureLink,
      'First Name': _firstName.text,
      'Last Name': _lastName.text,
      'Gender': GenderDropdownField.gendVal,
      'Date of Birth': dOB,
      'E Mail': _eMail.text,
      'Company or School': _companyOrSchool.text,
      'Degree': _dgree.text,
      'Country': country,
      'State': state,
      'Phone Number': _phoneNumber.text,
      'Courses': [],
      'batchid': [],
    });
  }

  void textFieldClear() {
    setState(() {
      profilePictureLink = profilePictureLink = null;
    });
    _firstName.clear();
    _lastName.clear();
    _dateOfBirth.clear();
    GenderDropdownField.gendVal = null;
    _eMail.clear();
    _companyOrSchool.clear();
    _dgree.clear();
    country = null;
    state = null;
    _phoneNumber.clear();
  }

  bool isEmail = false;
  bool isFirstName = false;
  bool isLastName = false;
  bool isDateOfBirth = false;
  bool isGender = false;
  bool isCompanyOrSchool = false;
  bool isDegree = false;
  bool isCountry = false;
  bool isState = false;
  bool isPhoneNumber = false;

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

  bool validateUrl(String value) {
    Pattern pattern =
        r'^(http:\/\/www\.)*(https:\/\/www\.)*(http:\/\/)*(https:\/\/)*(www\.)*(WWW\.)*[a-z0-9A-Z]+([\-\.]{1}[a-z0-9A-Z]+)*\.[a-zA-Z]{2,5}(:[0-9]{1,5})?(\/.*)?$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool registerFormValidation() {
    bool ifRFV = false;
    bool elseRFV = true;
    // first name
    if (!nameValidation(_firstName.text) || _firstName.text.length < 3) {
      setState(() {
        isFirstName = true;
        ifRFV = isFirstName;
      });
    } else {
      setState(() {
        isFirstName = false;
        elseRFV = isFirstName;
      });
    }
    //last name
    if (!nameValidation(_lastName.text) || _lastName.text.length < 3) {
      setState(() {
        isLastName = true;
        ifRFV = isLastName;
      });
    } else {
      setState(() {
        isLastName = false;
        elseRFV = isLastName;
      });
    }
    // gender
    if (GenderDropdownField.gendVal == null) {
      setState(() {
        isGender = true;
        ifRFV = isGender;
      });
    } else {
      setState(() {
        isGender = false;
        elseRFV = isGender;
      });
    }
    //date
    if (_dateOfBirth.text.isEmpty) {
      setState(() {
        isDateOfBirth = true;
        ifRFV = isDateOfBirth;
      });
    } else {
      setState(() {
        isDateOfBirth = false;
        elseRFV = isDateOfBirth;
      });
    }
    // email
    if (!validateEmail(_eMail.text)) {
      setState(() {
        isEmail = true;
        ifRFV = isEmail;
      });
    } else {
      setState(() {
        isEmail = false;
        elseRFV = isEmail;
      });
    }
    //Company or school
    if (!nameValidation(_companyOrSchool.text) ||
        _companyOrSchool.text.length < 3) {
      setState(() {
        isCompanyOrSchool = true;
        ifRFV = isCompanyOrSchool;
      });
    } else {
      setState(() {
        isCompanyOrSchool = false;
        elseRFV = isCompanyOrSchool;
      });
    }
    //Degree
    if (!nameValidation(_dgree.text) || _dgree.text.length < 1) {
      setState(() {
        isDegree = true;
        ifRFV = isDegree;
      });
    } else {
      setState(() {
        isDegree = false;
        elseRFV = isDegree;
      });
    }
    //Country
    if (country == null) {
      setState(() {
        isCountry = true;
        ifRFV = isCountry;
      });
    } else {
      setState(() {
        isCountry = false;
        elseRFV = isCountry;
      });
    }
    //state
    if (state == null) {
      setState(() {
        isState = true;
        ifRFV = isState;
      });
    } else {
      setState(() {
        isState = false;
        elseRFV = isState;
      });
    }
    //phonenumber
    if (_phoneNumber.text.length < 6) {
      setState(() {
        isPhoneNumber = true;
        ifRFV = isPhoneNumber;
      });
    } else {
      setState(() {
        isPhoneNumber = false;
        elseRFV = isPhoneNumber;
      });
    }

    return ifRFV == elseRFV;
  }
}
