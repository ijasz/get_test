import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:ocean_project/desktopview/Components/thanks_purchasing.dart';

import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

//conditional import
import 'package:ocean_project/desktopview/Components/UiFake.dart'
    if (dart.library.html) 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class RazorPayWeb extends StatefulWidget {
  String courseName;
  String amount;
  String courseImage;
  List course;
  String studentname;
  String studentemail;
  List batchid;

  RazorPayWeb(
      {this.amount,
      this.course,
      this.courseName,
      this.courseImage,
      this.batchid});
  @override
  _RazorPayWebState createState() => _RazorPayWebState();
}

class _RazorPayWebState extends State<RazorPayWeb> {
  var date;
  final _firestore = FirebaseFirestore.instance;
  TextEditingController rupees = TextEditingController(text: '5');
  TextEditingController email = TextEditingController();
  TextEditingController name;
  TextEditingController mobilenumber;
  session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('login', 1);
    await prefs.setString('user', LogIn.registerNumber);
    print('Otp Submited');
    print('000000000000');
    print(LogIn.registerNumber);
  }

  // TextEditingController duration = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    session();
    var test = DateTime.now();
    date = (DateFormat("dd-MM-y").format(test));
    print(date);
    name = TextEditingController(text: CoursesView.courseEnroll);
    mobilenumber = TextEditingController(text: CoursesView.courseEnroll);
    print("${CoursesView.courseEnroll}priyeee");
    print("${CoursesView.studentemail}priyeee");
  }

  @override
  Widget build(BuildContext context2) {
    //final provider = // Provider.of<SyllabusView>(context, listen: false)
    //     .updateCourseSyllabus(routing: ThanksForPurchasing());
    print(widget.amount);
    ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
      IFrameElement element = IFrameElement();
      //Event Listener
      window.onMessage.forEach((element) {
        print('Event Received in callback: ${element.data}');
        if (element.data == 'MODAL_CLOSED') {
          Navigator.pop(context2);
        } else if (element.data == 'SUCCESS') {
          print('PAYMENT SUCCESSFULL!!!!!!!');
          print('${widget.course} wwwwwwwwwwwwwwwwwww');
          _firestore.collection("new users").doc(LogIn.registerNumber).update({
            "Courses": FieldValue.arrayUnion(widget.course),
            "batchid": FieldValue.arrayUnion(widget.batchid),
          });

          _firestore
              .collection("new users")
              .doc(LogIn.registerNumber)
              .collection("payment")
              .add({
            "coursename": widget.courseName,
            "amount": widget.amount,
            "date": date,
            "image": widget.courseImage,
            "paid_via": "debit card",
            "status": "Completed",
          });
          Navigator.pop(context2);
          Provider.of<SyllabusView>(context, listen: false)
              .updateCourseSyllabus(routing: ThanksForPurchasing());
          print('PAYMENT SUCCESSFULL !!!!!!!');
        }
      });

      element.requestFullscreen();

      /// todo amount int.parse(widget.amount)
      // element.height="650px";
      // element
      element.srcdoc = """ <!DOCTYPE html><html>

<meta name="viewport" content="width=device-width, initial-scale=0.5">
<head><title>RazorPay Web Payment</title></head>

<body>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>

       var options = {
         "key": "rzp_live_yI4lHyiI5FRJWt",
          "amount": "${1 * 100}", "currency": "INR",
          "name": "${CoursesView.courseEnroll}",
          "description": "Online Payment Transaction",
          "image": "https://example.com/your_logo",
          "handler": function (response){
             window.parent.postMessage("SUCCESS","*");      //2
            
          },
          "prefill": {
             "name": "${CoursesView.courseEnroll}",
             "email": "${CoursesView.studentemail}",
             "contact": "${LogIn.registerNumber}"
           },
           "notes": {
             "address": "Autofy"
          },
        
          "modal": {
            "ondismiss": function(){
               //window.parent.postMessage("MODAL_CLOSED","*");   //3
            }
          }
       };

       var rzp1 = new Razorpay(options);
       
       window.onload = function(e){  //1
       
          rzp1.open();
           e.preventDefault();
          
       }
       
      

     </script>
     
<style>


</style>

</body>
</html> """;

      element.style.border = 'none';

      return element;
    });
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return Center(
        child: Column(
          children: [
            Container(
              width: 600,
              height: 670,
              //color: Colors.lightBlueAccent,
              child: HtmlElementView(
                viewType: 'rzp-html',
              ),
            ),
          ],
        ),
      );
      // RaisedButton(onPressed: () {
      //   //register view factory
      // })
    }));
  }
}

/// alert
