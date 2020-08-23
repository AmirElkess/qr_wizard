
import 'package:flutter/material.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:qr_flutter/qr_flutter.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double btnWidth = double.infinity;
  double btnHeight = 40;
  double btnRadius = 12;
  double sideMargin = 55;
  String qrLogo = "QRWizard by AE";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: universalPadding,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 2, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("QR Wizard", style: TextStyle(fontWeight: FontWeight.bold),),
                        Opacity(
                          opacity: 0,
                          child: SoftButton(
//                        radius: 24,
//                        height: 5,
//                        width: 5,
                            child: Icon(Icons.settings),
//                          onTap: (){
//                            Navigator.pushNamed(context, '/settings');
//                          },
                          ),
                        )
                      ],
                    ),
                  ),

                  SoftButton(
                    width: double.infinity,
                    radius: 12,
                    height: 450,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SoftButton(
                          width: btnWidth,
                          inverted: false,
                          radius: btnRadius,
                          height: MediaQuery.of(context).size.width - 2*(sideMargin),
                          //child: Image.asset('lib/res/logo.png', ),
                          child: QrImage(
                            data: qrLogo,
                            version: QrVersions.auto,
                            size: 220.0,
                          ),
                        ),
                        SoftButton(
                          radius: btnRadius,
                          height: btnHeight,
                          width: btnWidth,
                          child: Text("SCAN QR", style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),),
                          onTap: () {
                            Navigator.pushNamed(context, '/read');
                          },
                        ),
                        SoftButton(
                          radius: btnRadius,
                          height: btnHeight,
                          width: btnWidth,
                          child: Text("CREATE QR", style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
                          onTap: () {
                            Navigator.pushNamed(context, '/create');
                          },
                        ),
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
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
