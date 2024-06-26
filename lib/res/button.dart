import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      this.blurRadius = 8,
      this.isClickable = false})
      : super(key: key) {
    if (radius == null || radius <= 0) radius = 32;
    if (height == null || height <= 0) height = double.infinity;
    if (width == null || width <= 0) width = double.infinity;
    if (margin == null || margin <= 0) margin = 5.0;
    if (color == null) color = backgroundColor;
  }

  @override
  _SoftButtonState createState() => _SoftButtonState();
}

class _SoftButtonState extends State<SoftButton> {
  bool isConcave = false;
  bool isPressed = false;


  Decoration getOuterShadow() {
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

  Decoration getInnerShadow() {
    return ConcaveDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.widget.radius)),
        colors: [lightShadowColor, shadowColor],
        depth: 6);
  }


  @override
  Widget build(BuildContext context) {
    if (widget.inverted || isPressed) {
      isConcave = true;
    } else {
      isConcave = false;
    }


    return GestureDetector(
      onTap: this.widget.onTap,
      child: Listener(
        onPointerDown: (TapDownDetails) {
          if (this.widget.isClickable) {
            SystemSound.play(SystemSoundType.click);
            setState(() {
              isPressed = true;
            });
          }
        },
        onPointerUp: (TapUpDetails) {
          if (this.widget.isClickable) {
            setState(() {
              isPressed = false;
            });
          }
        },
        onPointerCancel: (PointerCancelEvent) {
          if (this.widget.isClickable) {
            setState(() {
              isPressed = false;
            });
          }
        },
        child: Container(
          width: this.widget.width,
          height: this.widget.height,
          decoration: isConcave ? getInnerShadow() : getOuterShadow(),
          child: Center(
            child: this.widget.child,
          ),
          margin: EdgeInsets.all(widget.margin),
        ),
      ),
    );
  }
}
