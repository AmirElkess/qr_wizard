import 'package:flutter/material.dart';
import 'package:qr_wizard/res/constants.dart';

class SoftButton extends StatelessWidget {
  double radius;
  double margin;
  double width;
  double height;
  Function onTap;
  Widget child;

  SoftButton(
      {Key key,
      this.margin,
      this.radius,
      @required this.child,
      this.height,
      this.width,
      this.onTap})
      : super(key: key) {
    if (radius == null || radius <= 0) radius = 32;
    if (height == null || height <= 0) height = radius;
    if (width == null || width <= 0) width = radius;
    if (margin == null || margin <= 0) margin = 5.0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        //print('button tapped');
      },
      onTapUp: (TapUpDetails details) {
        //print('button untapped');
      },
      onTap: this.onTap,
      child: Container(
        width: this.width,
        height: this.height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                  color: shadowColor, offset: Offset(5, 5), blurRadius: 8),
              BoxShadow(
                  color: lightShadowColor,
                  offset: Offset(-5, -5),
                  blurRadius: 8),
            ]
        ),
        child: Center(
          child: this.child,
        ),
        margin: EdgeInsets.all(margin),
      ),
    );
  }
}
