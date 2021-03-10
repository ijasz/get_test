import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/new_user_widget/contry_states.dart';

class ContryPicker extends StatefulWidget {
  final String value;
  final Function onChanged;
  final String labelText;
  final validator;
  final Color color;
  final bool visible;
  final List items;
  final String errorText;
  ContryPicker(
      {this.validator,
      this.items,
      this.onChanged,
      this.value,
      this.labelText,
      this.color = Colors.white,
      this.visible,
      this.errorText = 'Invalid Field'});
  @override
  _ContryPickerState createState() => _ContryPickerState();
}

class _ContryPickerState extends State<ContryPicker> {
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
  }

  @override
  Widget build(BuildContext context) {
    contryPicker();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(
              widget.labelText,
              style: TextStyle(fontSize: 20.0, color: widget.color),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
            margin: EdgeInsets.symmetric(vertical: 5.0),
            width: 350.0,
            child: DropdownButtonFormField(
              hint: Text('Select'),
              value: widget.value,
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
              // validator: widget.validator,
              items: widget.items,
              onChanged: widget.onChanged,
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
