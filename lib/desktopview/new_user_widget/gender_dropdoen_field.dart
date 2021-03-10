import 'package:flutter/material.dart';

class GenderDropdownField extends StatefulWidget {
  static String gendVal;
  final validator;
  final Color color;
  final bool visible;
  final String errorText;
  GenderDropdownField(
      {this.validator,
      this.color = Colors.white,
      this.visible,
      this.errorText = 'Invalid Field'});
  @override
  _GenderDropdownFieldState createState() => _GenderDropdownFieldState();
}

class _GenderDropdownFieldState extends State<GenderDropdownField> {
  List<String> genderValue = ['Male', 'Female'];

  List genderVal() {
    List<DropdownMenuItem<String>> dropList = [];
    for (var genders in genderValue) {
      var newList = DropdownMenuItem(
        child: Text(genders),
        value: genders,
      );
      dropList.add(newList);
    }
    return dropList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(
              'Gender',
              style: TextStyle(
                fontSize: 20.0,
                color: widget.color,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
            margin: EdgeInsets.symmetric(vertical: 5.0),
            width: 150.0,
            child: DropdownButtonFormField(
              hint: Text('Select'),
              value: GenderDropdownField.gendVal,
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
              ),
              validator: widget.validator,
              items: genderVal(),
              onChanged: (value) {
                setState(() {
                  GenderDropdownField.gendVal = value;

                  print('${GenderDropdownField.gendVal}');
                });
              },
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
