import 'package:flutter/material.dart';
import 'package:qr_wizard/res/constants.dart';

class SoftButton extends StatelessWidget {
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
      this.blurRadius = 7})
      : super(key: key) {
    if (radius == null || radius <= 0) radius = 32;
    if (height == null || height <= 0) height = radius;
    if (width == null || width <= 0) width = radius;
    if (margin == null || margin <= 0) margin = 5.0;
    if (color == null) color = backgroundColor;
  }

  List<BoxShadow> getShadows() {
    if (!inverted) {
      return [
        BoxShadow(color: shadowColor, offset: Offset(shadowOffset, shadowOffset), blurRadius: blurRadius),
        BoxShadow(
            color: lightShadowColor, offset: Offset(-shadowOffset, -shadowOffset), blurRadius: blurRadius),
      ];
    } else {
      return [
        BoxShadow(color: lightShadowColor, offset: Offset(shadowOffset, shadowOffset), blurRadius: blurRadius),
        BoxShadow(color: shadowColor, offset: Offset(-shadowOffset, -shadowOffset), blurRadius: blurRadius),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        width: this.width,
        height: this.height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: getShadows(),
        ),
        child: Center(
          child: this.child,
        ),
        margin: EdgeInsets.all(margin),
      ),
    );
  }
}
