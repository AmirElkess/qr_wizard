import 'package:flutter/material.dart';
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
  List<BoxShadow> getShadows() {
    if (!widget.inverted) {
      return [
        BoxShadow(color: shadowColor, offset: Offset(widget.shadowOffset, widget.shadowOffset), blurRadius: widget.blurRadius),
        BoxShadow(
            color: lightShadowColor, offset: Offset(-widget.shadowOffset, -widget.shadowOffset), blurRadius: widget.blurRadius),
      ];
    } else {
      return [
        BoxShadow(color: lightShadowColor, offset: Offset(widget.shadowOffset, widget.shadowOffset), blurRadius: widget.blurRadius),
        BoxShadow(color: shadowColor, offset: Offset(-widget.shadowOffset, -widget.shadowOffset), blurRadius: widget.blurRadius),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.widget.onTap,
      onTapDown: (TapDownDetails) {
        if (this.widget.isClickable){
          setState(() {
            this.widget.color = shadowColor;
          });
        }
      },
      onTapUp: (TapUpDetails){
        if (this.widget.isClickable){
          setState(() {
            this.widget.color = backgroundColor;
          });
        }
      },
      onTapCancel: (){
        if (this.widget.isClickable){
          setState(() {
            this.widget.color = backgroundColor;
          });
        }
      },
      child: Container(
        width: this.widget.width,
        height: this.widget.height,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: getShadows(),
        ),
        child: Center(
          child: this.widget.child,
        ),
        margin: EdgeInsets.all(widget.margin),
      ),
    );
  }
}
