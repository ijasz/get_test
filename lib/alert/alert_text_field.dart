import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class AlertTextField extends StatefulWidget {
  AlertTextField(
      {this.controller,
      this.hintText,
      this.icon,
      this.lines,
      this.errorText,
      this.suffixIcon,
      this.onChanged,
      this.letterSpacing,
      this.inputFormatters});
  final controller;
  final String hintText;
  final Icon icon;
  final int lines;
  final String errorText;
  List<TextInputFormatter> inputFormatters;
  final Function onChanged;
  final Icon suffixIcon;
  double letterSpacing;
  @override
  _AlertTextFieldState createState() => _AlertTextFieldState();
}

class _AlertTextFieldState extends State<AlertTextField> {
  FocusNode focusNode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 1.0, color: Colors.grey[350]),
          color: Colors.white,
          boxShadow: [
            focusNode.hasFocus
                ? BoxShadow(
                    color: Colors.black26.withOpacity(0.1),
                    blurRadius: 6.0,
                    offset: Offset(4.0, 4.0))
                : BoxShadow(color: Colors.transparent, blurRadius: 0.0)
          ]),
      width: 360.0,
      child: TextFormField(
        onChanged: widget.onChanged,
        textAlignVertical: TextAlignVertical.center,
        maxLines: widget.lines,
        style: TextStyle(letterSpacing: widget.letterSpacing),
        focusNode: focusNode,
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: widget.icon,
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText,
          hintStyle: TextStyle(letterSpacing: 0.0),
          helperStyle: TextStyle(fontSize: 25.0),
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

class AlertQueryField extends StatefulWidget {
  AlertQueryField(
      {this.controller,
      this.hintText,
      this.icon,
      this.lines,
      this.errorText,
      this.suffixIcon,
      this.onChanged});
  final controller;
  final String hintText;
  final Icon icon;
  final int lines;
  final String errorText;

  final Function onChanged;
  final Icon suffixIcon;
  @override
  _AlertQueryFieldState createState() => _AlertQueryFieldState();
}

class _AlertQueryFieldState extends State<AlertQueryField> {
  FocusNode focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 1.0, color: Colors.grey[350]),
          color: Colors.white,
          boxShadow: [
            focusNode.hasFocus
                ? BoxShadow(
                    color: Colors.black26.withOpacity(0.1),
                    blurRadius: 6.0,
                    offset: Offset(4.0, 4.0))
                : BoxShadow(color: Colors.transparent, blurRadius: 0.0)
          ]),
      width: 360.0,
      child: TextFormField(
        onChanged: widget.onChanged,
        textAlignVertical: TextAlignVertical.center,
        maxLines: widget.lines,
        focusNode: focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: widget.icon,
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText,
          helperStyle: TextStyle(
            fontSize: 25.0,
          ),
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
