import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPInput extends StatefulWidget {
  @override
  _OTPInputState createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      width: 70.0,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: TextField(
        decoration: InputDecoration(
            fillColor: Colors.white, border: OutlineInputBorder()),
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d{0,1}")),
          LengthLimitingTextInputFormatter(1),
        ],
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700]),
        onChanged: (value) {
          //
        },
      ),
    );
  }
}
