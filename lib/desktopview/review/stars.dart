import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Stars extends StatefulWidget {
  Stars(
      {this.iconColor = Colors.deepOrangeAccent,
      this.containerSize = 30.0,
      this.iconBgColor,
      this.starRating});
  Color iconColor;
  Color iconBgColor;
  num containerSize;
  int starRating;

  @override
  _StarsState createState() => _StarsState();
}

class _StarsState extends State<Stars> {
  bool isActive1 = false;
  bool isActive2 = false;
  bool isActive3 = false;
  bool isActive4 = false;
  bool isActive5 = false;
  starRatingFunction() {
    if (widget.starRating == 1) {
      isActive1 = true;
      isActive2 = false;
      isActive3 = false;
      isActive4 = false;
      isActive5 = false;
    } else if (widget.starRating == 2) {
      isActive1 = true;
      isActive2 = true;
      isActive3 = false;
      isActive4 = false;
      isActive5 = false;
    } else if (widget.starRating == 3) {
      isActive1 = true;
      isActive2 = true;
      isActive3 = true;
      isActive4 = false;
      isActive5 = false;
    } else if (widget.starRating == 4) {
      isActive1 = true;
      isActive2 = true;
      isActive3 = true;
      isActive4 = true;
      isActive5 = false;
    } else if (widget.starRating == 5) {
      isActive1 = true;
      isActive2 = true;
      isActive3 = true;
      isActive4 = true;
      isActive5 = true;
    } else {
      isActive1 = true;
      isActive2 = true;
      isActive3 = true;
      isActive4 = true;
      isActive5 = true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    starRatingFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerSize * 5 + 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            color: widget.iconBgColor,
            width: widget.containerSize,
            height: widget.containerSize,
            child: isActive1 == false
                ? Icon(
                    Icons.star_border,
                    size: 30.0,
                    color: widget.iconColor,
                  )
                : Icon(
                    Icons.star,
                    size: 30.0,
                    color: widget.iconColor,
                  ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isActive1 = true;
                isActive2 = true;
                isActive3 = false;
                isActive4 = false;
                isActive5 = false;
              });
            },
            child: Container(
              color: widget.iconBgColor,
              width: widget.containerSize,
              height: widget.containerSize,
              child: isActive2 == false
                  ? Icon(
                      Icons.star_border,
                      size: 30.0,
                      color: widget.iconColor,
                    )
                  : Icon(
                      Icons.star,
                      size: 30.0,
                      color: widget.iconColor,
                    ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isActive1 = true;
                isActive2 = true;
                isActive3 = true;
                isActive4 = false;
                isActive5 = false;
              });
            },
            child: Container(
              color: widget.iconBgColor,
              width: widget.containerSize,
              height: widget.containerSize,
              child: isActive3 == false
                  ? Icon(
                      Icons.star_border,
                      size: 30.0,
                      color: widget.iconColor,
                    )
                  : Icon(
                      Icons.star,
                      size: 30.0,
                      color: widget.iconColor,
                    ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isActive1 = true;
                isActive2 = true;
                isActive3 = true;
                isActive4 = true;
                isActive5 = false;
              });
            },
            child: Container(
              color: widget.iconBgColor,
              width: widget.containerSize,
              height: widget.containerSize,
              child: isActive4 == false
                  ? Icon(
                      Icons.star_border,
                      size: 30.0,
                      color: widget.iconColor,
                    )
                  : Icon(
                      Icons.star,
                      size: 30.0,
                      color: widget.iconColor,
                    ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isActive1 = true;
                isActive2 = true;
                isActive3 = true;
                isActive4 = true;
                isActive5 = true;
              });
            },
            child: Container(
              color: widget.iconBgColor,
              width: widget.containerSize,
              height: widget.containerSize,
              child: isActive5 == false
                  ? Icon(
                      Icons.star_border,
                      size: 30.0,
                      color: widget.iconColor,
                    )
                  : Icon(
                      Icons.star,
                      size: 30.0,
                      color: widget.iconColor,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
