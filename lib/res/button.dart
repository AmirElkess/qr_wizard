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

  SoftButton(
      {Key key,
      this.margin,
      this.radius,
      @required this.child,
      this.height,
      this.width,
      this.onTap,
      this.inverted,
      this.color})
      : super(key: key) {
    if (radius == null || radius <= 0) radius = 32;
    if (height == null || height <= 0) height = radius;
    if (width == null || width <= 0) width = radius;
    if (margin == null || margin <= 0) margin = 5.0;
    if (inverted == null) inverted = false;
    if (color == null) color = backgroundColor;
  }

  List<BoxShadow> getShadows() {
    if (!inverted) {
      return [
        BoxShadow(color: shadowColor, offset: Offset(5, 5), blurRadius: 8),
        BoxShadow(
            color: lightShadowColor, offset: Offset(-5, -5), blurRadius: 8),
      ];
    } else {
      return [
        BoxShadow(color: lightShadowColor, offset: Offset(5, 5), blurRadius: 8),
        BoxShadow(color: shadowColor, offset: Offset(-5, -5), blurRadius: 8),
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
