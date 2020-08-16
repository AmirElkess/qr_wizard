import 'package:flutter/material.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double btnWidth = 180;
  double btnHeight = 40;
  double btnRadius = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 160,
              ),
              SoftButton(
                radius: btnRadius,
                height: btnHeight,
                width: btnWidth,
                child: Text("READ"),
                onTap: () {
                  Navigator.pushNamed(context, '/read');
                },
              ),
              SoftButton(
                radius: btnRadius,
                height: btnHeight,
                width: btnWidth,
                child: Text("CREATE"),
                onTap: () {
                  Navigator.pushNamed(context, '/create');
                },
              ),
              SoftButton(
                radius: btnRadius,
                height: btnHeight,
                width: btnWidth,
                child: Text("ABOUT"),
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
