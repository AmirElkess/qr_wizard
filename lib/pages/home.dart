import 'package:flutter/material.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double btnWidth = double.infinity;
  double btnHeight = 40;
  double btnRadius = 17;
  double sideMargin = 55;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(sideMargin, 75, sideMargin, 0),
          child: Center(
            child: Column(
              children: <Widget>[
                SoftButton(
                  width: btnWidth,
                  radius: 10,
                  height: MediaQuery.of(context).size.width - 2*(sideMargin),
                  child: Image.asset('lib/res/logo.png', ),
                ),
                SizedBox(height: 10,),
                SoftButton(
                  radius: btnRadius,
                  height: btnHeight,
                  width: btnWidth,
                  child: Text("SCAN QR", style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),),
                  onTap: () {
                    Navigator.pushNamed(context, '/read');
                  },
                ),
                SizedBox(height: 10,),

                SoftButton(
                  radius: btnRadius,
                  height: btnHeight,
                  width: btnWidth,
                  child: Text("CREATE QR", style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.pushNamed(context, '/create');
                  },
                ),
                SizedBox(height: 10,),

                SoftButton(
                  radius: btnRadius,
                  height: btnHeight,
                  width: btnWidth,
                  child: Text("ABOUT", style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
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
