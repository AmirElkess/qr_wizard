import 'package:flutter/material.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_actions/quick_actions.dart';


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
  void initState() {
    final QuickActions quickActions =  QuickActions();
    quickActions.initialize((shortcutType) {
      if (shortcutType == 'scan_qr') {
        print('The user tapped on the "scan qr" action.');
        Navigator.pushNamed(context, '/read');
      } else if (shortcutType == 'create_qr') {
        print('The user tapped on the "create qr" action.');
        Navigator.pushNamed(context, '/create');
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'scan_qr', localizedTitle: 'SCAN QR', icon: 'scan_icon'),
      const ShortcutItem(type: 'create_qr', localizedTitle: 'CREATE QR', icon: 'create_icon' ),

    ]);
    super.initState();
  }

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
                        Text("QR WIZARD", style: GoogleFonts.robotoMono(fontSize: 16, fontWeight: FontWeight.bold)),
                        Opacity(
                          opacity: 0,
                          child: SoftButton(
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
                    height: 420,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SoftButton(
                          width: btnWidth,
                          inverted: false,
                          radius: btnRadius,
                          height: 220,
                          //child: Image.asset('lib/res/logo.png', ),
                          child: QrImage(
                            data: qrLogo,
                            version: QrVersions.auto,
                            size: 220.0,
                            backgroundColor: backgroundColor,
                          ),
                        ),
                        SoftButton(
                          radius: btnRadius,
                          height: btnHeight,
                          width: btnWidth,
                          isClickable: true,
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
