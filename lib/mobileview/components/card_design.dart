import 'package:flutter/material.dart';

class ContainerServiceWidget extends StatefulWidget {
  @override
  _ContainerServiceWidgetState createState() => _ContainerServiceWidgetState();
}

class _ContainerServiceWidgetState extends State<ContainerServiceWidget> {
  bool isTouching = false;
  @override
  Widget build(BuildContext context) {
    // void mouseEnter(PointerEvent details) {
    //   setState(() {
    //     isTouching = true;
    //   });
    //   //isTouching = false;
    // }
    //
    // void mouseExit(PointerEvent details) {
    //   setState(() {
    //     isTouching = false;
    //   });
    // }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      // height: 300.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: isTouching ? Colors.blue : Colors.grey[100],
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.ac_unit_outlined,
            size: 70.0,
            color: isTouching ? Colors.white : Color(0xFF2b9dd1),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            "24/7 Service",
            style: TextStyle(
                color: isTouching ? Colors.white : Colors.lightBlue,
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
            style: TextStyle(
              color: isTouching ? Colors.white : Colors.black87,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
