import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  DatePicker(
      {this.onChanged,
      this.inputFormatters,
      this.datePickerIcon,
      this.validator,
      this.controller,
      this.visible = false,
      this.color = Colors.white,
      this.errorText = 'Invalid Field',
      this.rReadOnly = false});
  final controller;
  final Function onChanged;
  final inputFormatters;
  final datePickerIcon;
  final validator;
  final Color color;
  final bool visible;
  final String errorText;
  final bool rReadOnly;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(
              'Date of Brith',
              style: TextStyle(fontSize: 20.0, color: widget.color),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
            margin: EdgeInsets.symmetric(vertical: 5.0),
            width: 250.0,
            child: TextFormField(
              readOnly: true,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  errorStyle: TextStyle(fontSize: 20.0, color: Colors.red),
                  hintText: 'MM-DD-YYYY',
                  suffixIcon: widget.datePickerIcon),
              validator: widget.validator,
              onChanged: widget.onChanged,
              inputFormatters: widget.inputFormatters,
              controller: widget.controller,
            ),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Visibility(
              visible: widget.visible,
              child: Text(
                widget.errorText,
                style: TextStyle(color: Colors.red, fontSize: 20.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
