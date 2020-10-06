import 'package:flutter/material.dart';
import 'package:qr_wizard/res/concaveDecoration.dart';
import 'package:qr_wizard/res/constants.dart';

class SoftButton extends StatefulWidget {
  double radius;
  double margin;
  double width;
  double height;
  Function onTap;
  Widget child;
  bool inverted;
  Color color;
  double shadowOffset;
  double blurRadius;
  bool isClickable;

  SoftButton(
      {Key key,
      this.margin,
      this.radius,
      @required this.child,
      this.height,
      this.width,
      this.onTap,
      this.inverted = false,
      this.color,
      this.shadowOffset = 4,
      this.blurRadius = 7,
      this.isClickable = false})
      : super(key: key) {
    if (radius == null || radius <= 0) radius = 32;
    if (height == null || height <= 0) height = radius;
    if (width == null || width <= 0) width = radius;
    if (margin == null || margin <= 0) margin = 5.0;
    if (color == null) color = backgroundColor;
  }

  @override
  _SoftButtonState createState() => _SoftButtonState();
}

class _SoftButtonState extends State<SoftButton> {

  bool isPressed = false;

  Decoration getOuterShadow () {
    return BoxDecoration(
      color: widget.color,
      borderRadius: BorderRadius.circular(widget.radius),
      boxShadow: [
        BoxShadow(
            color: shadowColor,
            offset: Offset(widget.shadowOffset, widget.shadowOffset),
            blurRadius: widget.blurRadius),
        BoxShadow(
            color: lightShadowColor,
            offset: Offset(-widget.shadowOffset, -widget.shadowOffset),
            blurRadius: widget.blurRadius),
      ],
    );
  }

  Decoration getInnerShadow () {
    return ConcaveDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.widget.radius)),
        colors: [lightShadowColor, shadowColor],
        depth: 3);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.widget.onTap,
      onTapDown: (TapDownDetails) {
        if (this.widget.isClickable) {
          setState(() {
            isPressed = true;
          });
        }
      },
      onTapUp: (TapUpDetails) {
        if (this.widget.isClickable) {
          setState(() {
            isPressed = false;
          });
        }
      },
      onTapCancel: () {
        if (this.widget.isClickable) {
          setState(() {
            isPressed = false;
          });
        }
      },
      child: Container(
        width: this.widget.width,
        height: this.widget.height,
        decoration: isPressed ? getInnerShadow() : getOuterShadow(),
        child: Center(
          child: this.widget.child,
        ),
        margin: EdgeInsets.all(widget.margin),
      ),
    );
  }
}
