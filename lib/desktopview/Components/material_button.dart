import 'package:flutter/material.dart';

class MaterialFlatButton extends StatelessWidget {
  MaterialFlatButton({this.icon, this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.only(top: 30.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30.0,
        ),
      ),
      onTap: onPressed,
      // constraints: BoxConstraints.tightFor(
      //   width: 40.0,
      //   height: 40.0,
      // ),
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
