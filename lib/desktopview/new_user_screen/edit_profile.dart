import 'dart:html';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';

import 'package:ocean_project/desktopview/new_user_widget/date_picker.dart';
import 'package:ocean_project/desktopview/new_user_widget/gender_dropdoen_field.dart';
import 'package:ocean_project/desktopview/new_user_widget/input_text_field.dart';
import 'package:ocean_project/desktopview/route/routing.dart';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ocean_project/desktopview/Components/my_course.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  static bool readOnly = false;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _firestore = FirebaseFirestore.instance;
  //text field controller and variable
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime(1990),
        lastDate: DateTime(2025));
  }

  final _eMail = TextEditingController();
  final _companyOrSchool = TextEditingController();
  final _dgree = TextEditingController();
  final _country = TextEditingController();
  final _state = TextEditingController();
  final _phoneNumber = TextEditingController();

  List inputFormatte({@required String regExp, int length}) {
    List<TextInputFormatter> formater = [
      FilteringTextInputFormatter.allow(RegExp(regExp)),
      LengthLimitingTextInputFormatter(length)
    ];
    return formater;
  }

  editProfile() async {
    var details = await _firestore
        .collection('new users')
        .doc(OALive.stayUser != null ? OALive.stayUser : LogIn.registerNumber)
        .get(); // 8015122373 insted of  LogIn.userNum
    var detailsData = details.data();

    setState(() {
      _firstName.text = detailsData['First Name'];
      _lastName.text = detailsData['Last Name'];

      GenderDropdownField.gendVal = detailsData['Gender'];
      _dateOfBirth.text = detailsData['Date of Birth'];
      _eMail.text = detailsData['E Mail'];
      _companyOrSchool.text = detailsData['Company or School'];
      _dgree.text = detailsData['Degree'];
      _country.text = detailsData['Country'];
      _state.text = detailsData['State'];
      _phoneNumber.text = detailsData['Phone Number'];
      profilePictureLink = detailsData['Profile Picture'];
    });
  }

// profile picture
  Uint8List uploadFile;
  String fileName;
  String profilePictureLink;
  @override
  void initState() {
    super.initState();
    editProfile();
    EditProfile.readOnly = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                // TODO: Navigator to back
              });
            },
            child: Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 100.0,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                    ),
                    color: Colors.blue,
                    iconSize: 50,
                    splashRadius: 30,
                    onPressed: () {
                      CoursesView.isCheckCourse = true;
                      Provider.of<CourseProvide>(context, listen: false)
                          .updateCourseName(
                              routing: CourseList(),
                              isCheck: CoursesView.isCheckCourse);
                      Provider.of<SyllabusView>(context, listen: false)
                          .updateCourseSyllabus(
                        routing: MyCourse(),
                      );
                    },
                  ),
                  Text(
                    'My Profile',
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 1500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 200,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
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
                                    print(profilePictureLink);
                                  });
                                });
                              });
                            }

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
                                            '${profilePictureLink}',
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
                      Visibility(
                        child: EditProfile.readOnly != false
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    EditProfile.readOnly = false;
                                    print(EditProfile.readOnly);
                                  });
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Edit Account',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  width: 150.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  FilePickerResult result = await FilePicker
                                      .platform
                                      .pickFiles(type: FileType.image);
                                  if (result != null) {
                                    uploadFile = result.files.single.bytes;
                                    fileName =
                                        basename(result.files.single.name);
                                    print(fileName);
                                  } else {
                                    print('pick image');
                                  }
                                  // Upload to  firebase Storage
                                  Future uploadProfilePicture(
                                      BuildContext context) async {
                                    Reference firebaseStorageRef =
                                        FirebaseStorage.instance
                                            .ref()
                                            .child(fileName);
                                    UploadTask uploadTask =
                                        firebaseStorageRef.putData(uploadFile);
                                    // SnakBar Message
                                    TaskSnapshot taskSnapShot =
                                        await uploadTask.whenComplete(() {
                                      setState(() {
                                        print(
                                            'Profile Picuter Upload Complete');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Profile picture Uploaded')));
                                        // get Link
                                      });
                                    });
                                  }

                                  uploadProfilePicture(
                                      context); // call upload function
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Upload Photos',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  width: 150.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                ),
                              ),
                      ),
                      Visibility(
                        visible: EditProfile.readOnly != false,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.0)),
                          width: 150.0,
                          height: 150.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Courses Enrolled',
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '28',
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: EditProfile.readOnly != false,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.0)),
                          width: 150.0,
                          height: 150.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Courses Completed',
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '02',
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: double.infinity,
                  child: Form(
                    // key: formkey,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        LableWithTextField(
                          color: Colors.black,
                          lableText: 'First Name',
                          errorText: 'Enter First Name',
                          rReadOnly:
                              EditProfile.readOnly == false ? false : true,
                          width: 300.0,
                          controller: _firstName,
                          visible: isFirstName,
                          onChanged: (value) {},
                          inputFormatters: inputFormatte(
                              regExp: r"[a-zA-Z]+|\s", length: 15),
                        ),
                        LableWithTextField(
                            color: Colors.black,
                            lableText: 'Last Name',
                            errorText: 'Enter Last Name',
                            rReadOnly:
                                EditProfile.readOnly == false ? false : true,
                            width: 300.0,
                            visible: isLastName,
                            controller: _lastName,
                            onChanged: (value) {},
                            inputFormatters: inputFormatte(
                                regExp: r"[a-zA-Z]+|\s", length: 15)),
                        GenderDropdownField(
                          visible: isGender,
                          errorText: 'Select',
                          color: Colors.black,
                        ),
                        DatePicker(
                          color: Colors.black,
                          errorText: 'Date Required',
                          datePickerIcon: IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () async {
                              final selectedDate =
                                  await _selectDateTime(context);
                              setState(() {
                                dOB = DateFormat('d-M-y').format(selectedDate);
                                _dateOfBirth.text = dOB;
                                print(dOB);
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
                          color: Colors.black,
                          lableText: 'E-Mail Adsress',
                          errorText: 'Invalid Email Adress',
                          rReadOnly:
                              EditProfile.readOnly == false ? false : true,
                          visible: isEmail,
                          width: 300.0,
                          controller: _eMail,
                          onChanged: (value) {},
                        ),
                        LableWithTextField(
                          color: Colors.black,
                          lableText: 'Company/School',
                          errorText: 'Your Company/School Name',
                          rReadOnly:
                              EditProfile.readOnly == false ? false : true,
                          width: 300.0,
                          visible: isCompanyOrSchool,
                          controller: _companyOrSchool,
                          inputFormatters:
                              inputFormatte(regExp: r"[a-zA-Z]+|\s"),
                          onChanged: (value) {},
                        ),
                        LableWithTextField(
                          color: Colors.black,
                          lableText: 'Degree',
                          errorText: 'Enter your Education Qualification',
                          rReadOnly:
                              EditProfile.readOnly == false ? false : true,
                          width: 250.0,
                          visible: isDegree,
                          controller: _dgree,
                          onChanged: (value) {},
                        ),
                        LableWithTextField(
                          color: Colors.black,
                          lableText: 'Country',
                          errorText: 'Enter Your Country',
                          rReadOnly:
                              EditProfile.readOnly == false ? false : true,
                          width: 250.0,
                          visible: isCountry,
                          controller: _country,
                          inputFormatters:
                              inputFormatte(regExp: r"[a-zA-Z]+|\s"),
                          onChanged: (value) {},
                        ),
                        LableWithTextField(
                          color: Colors.black,
                          lableText: 'State',
                          errorText: 'Enter Your State',
                          rReadOnly:
                              EditProfile.readOnly == false ? false : true,
                          width: 250.0,
                          visible: isState,
                          controller: _state,
                          inputFormatters:
                              inputFormatte(regExp: r"[a-zA-Z]+|\s"),
                          onChanged: (value) {},
                        ),
                        LableWithTextField(
                          color: Colors.black,
                          lableText: 'Phone Number',
                          errorText: 'Invalid Phonenumber',
                          width: 250.0,
                          rReadOnly: true,
                          visible: isPhoneNumber,
                          controller: _phoneNumber,
                          onChanged: (value) {},
                          inputFormatters: inputFormatte(
                              regExp: r'^\d+\.?\d{0,2}', length: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: EditProfile.readOnly == false,
                        child: FlatButton(
                            minWidth: 300.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Update',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25.0),
                              ),
                            ),
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            onPressed: () {
                              if (registerFormValidation() == true) {
                                fireStoreAdd();
                                EditProfile.readOnly = true;
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    ));
  }

  void fireStoreAdd() {
    _firestore.collection('new users').doc(LogIn.registerNumber).update({
      'Profile Picture': profilePictureLink,
      'First Name': _firstName.text,
      'Last Name': _lastName.text,
      'Gender': GenderDropdownField.gendVal,
      'Date of Birth': dOB,
      'E Mail': _eMail.text,
      'Company or School': _companyOrSchool.text,
      'Degree': _dgree.text,
      'Country': _country.text,
      'State': _state.text,
      'Phone Number': _phoneNumber.text,
    });
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
  bool isPortfolioLink = false;
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

  // void registerFormValidation() {
  //   // first name
  //   if (!nameValidation(_firstName.text) || _firstName.text.length < 3) {
  //     setState(() {
  //       isFirstName = true;
  //     });
  //   } else {
  //     setState(() {
  //       isFirstName = false;
  //     });
  //   }
  //   //last name
  //   if (!nameValidation(_lastName.text) || _lastName.text.length < 3) {
  //     setState(() {
  //       isLastName = true;
  //     });
  //   } else {
  //     setState(() {
  //       isLastName = false;
  //     });
  //   }
  //   // gender
  //   if (GenderDropdownField.gendVal == null) {
  //     setState(() {
  //       isGender = true;
  //     });
  //   } else {
  //     setState(() {
  //       isGender = false;
  //     });
  //   }
  //   //date
  //   if (_dateOfBirth.text.isEmpty || _dateOfBirth.text == null) {
  //     setState(() {
  //       isDateOfBirth = true;
  //     });
  //   } else {
  //     setState(() {
  //       isDateOfBirth = false;
  //     });
  //   }
  //   // email
  //   if (!validateEmail(_eMail.text)) {
  //     setState(() {
  //       isEmail = true;
  //     });
  //   } else {
  //     setState(() {
  //       isEmail = false;
  //     });
  //   }
  //   //Company or school
  //   if (!nameValidation(_companyOrSchool.text) ||
  //       _companyOrSchool.text.length < 3) {
  //     setState(() {
  //       isCompanyOrSchool = true;
  //     });
  //   } else {
  //     setState(() {
  //       isCompanyOrSchool = false;
  //     });
  //   }
  //   //Degree
  //   if (!nameValidation(_dgree.text) || _dgree.text.length < 1) {
  //     setState(() {
  //       isDegree = true;
  //     });
  //   } else {
  //     setState(() {
  //       isDegree = false;
  //     });
  //   }
  //   //Country
  //   if (!nameValidation(_country.text) || _country.text.length < 3) {
  //     setState(() {
  //       isCountry = true;
  //     });
  //   } else {
  //     setState(() {
  //       isCountry = false;
  //     });
  //   }
  //   //state
  //   if (!nameValidation(_state.text) || _state.text.length < 3) {
  //     setState(() {
  //       isState = true;
  //     });
  //   } else {
  //     setState(() {
  //       isState = false;
  //     });
  //   }
  //   //phonenumber
  //   if (_phoneNumber.text.length < 6) {
  //     setState(() {
  //       isPhoneNumber = true;
  //     });
  //   } else {
  //     setState(() {
  //       isPhoneNumber = false;
  //     });
  //   }
  //   //portfolio
  // }
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
    if (_country.text.isEmpty) {
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
    if (_state.text.isEmpty) {
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
