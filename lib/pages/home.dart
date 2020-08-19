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
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 75, 20, 0),
          child: Center(
            child: Column(
              children: <Widget>[
                SoftButton(
                  width: btnWidth,
                  height: btnWidth,
                  child: Image.asset('lib/res/logo.png', ),
                ),
                SizedBox(height: 10,),
                SoftButton(
                  radius: btnRadius,
                  height: btnHeight,
                  width: btnWidth,
                  child: Text("SCAN QR"),
                  onTap: () {
                    Navigator.pushNamed(context, '/read');
                  },
                ),
                SizedBox(height: 10,),

                SoftButton(
                  radius: btnRadius,
                  height: btnHeight,
                  width: btnWidth,
                  child: Text("CREATE QR"),
                  onTap: () {
                    Navigator.pushNamed(context, '/create');
                  },
                ),
                SizedBox(height: 10,),

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
      ),
    );
  }
}
