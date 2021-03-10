import 'package:flutter/material.dart';

class ContainerServiceWidget extends StatefulWidget {
  final String title;
  final String content;
  final String icon;
  ContainerServiceWidget({this.title, this.content, this.icon});
  @override
  _ContainerServiceWidgetState createState() => _ContainerServiceWidgetState();
}

class _ContainerServiceWidgetState extends State<ContainerServiceWidget> {
  bool isTouching = false;
  @override
  Widget build(BuildContext context) {
    void mouseEnter(PointerEvent details) {
      setState(() {
        isTouching = true;
      });
    }

    void mouseExit(PointerEvent details) {
      setState(() {
        isTouching = false;
      });
    }

    return MouseRegion(
      onEnter: mouseEnter,
      onExit: mouseExit,
      child: Container(
        margin: EdgeInsets.all(40.0),
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        height: 350.0,
        width: 500.0,
        decoration: BoxDecoration(
            color: isTouching ? Colors.grey[200] : Colors.grey[100],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              isTouching
                  ? BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: Offset(0, 3))
                  : BoxShadow(
                      color: Colors.transparent,
                      blurRadius: 0,
                      offset: Offset(0, 0))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: Image.asset(
                widget.icon,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  fontFamily: "Gilroy"),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              widget.content,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20.0,
                  fontFamily: 'Gilroy'),
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
