import 'package:flutter/material.dart';
import 'package:qr_wizard/res/constants.dart';

class SoftButton extends StatelessWidget {

  double radius;
  double width;
  double height;
  Widget child;


  SoftButton ({ Key key , this.radius, @required this.child, this.height, this.width}) : super(key: key) {
    if (radius == null || radius <= 0) radius = 32;
    if (height == null || height <= 0) height = radius;
    if (width == null || width <= 0) width = radius;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(color: shadowColor, offset: Offset(4,4), blurRadius: 2),
            BoxShadow(color: lightShadowColor, offset: Offset(-4,-4), blurRadius: 2),
          ]
      ),
      child: Center(
        child: this.child,
      ),
    );
  }
}
