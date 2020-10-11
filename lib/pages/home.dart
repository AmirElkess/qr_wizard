import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/pages/read.dart';
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
  double btnRadius = 16;
  String qrLogo = "QRWizard by AE";

  @override
  void initState() {
    final QuickActions quickActions = QuickActions();
    quickActions.initialize((shortcutType) {
      if (shortcutType == 'scan_qr') {
        Navigator.pushNamed(context, '/read');
      } else if (shortcutType == 'create_qr') {
        Navigator.pushNamed(context, '/create');
      } else if (shortcutType == 'history') {
        Navigator.pushNamed(context, '/history');
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
          type: 'scan_qr', localizedTitle: 'SCAN QR', icon: 'scan_icon'),
      const ShortcutItem(
          type: 'create_qr', localizedTitle: 'CREATE QR', icon: 'create_icon'),
      const ShortcutItem(
          type: 'history',
          localizedTitle: 'Scan History',
          icon: 'history_icon'),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Align(
          alignment: homeAlignment,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Text(" QR WIZARD", textAlign: TextAlign.left,
                      style: GoogleFonts.nunitoSans(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10,),
                Expanded(
                  flex: 5,
                  child: SoftButton(
                    inverted: false,
                    radius: 16,
                    //child: Image.asset('lib/res/logo.png', ),
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: QrImage(
                        data: qrLogo,
                        version: QrVersions.auto,
                        backgroundColor: backgroundColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SoftButton(
                    radius: btnRadius,
                    isClickable: true,
                    child: Text(
                      "Scan QR",
                      style: GoogleFonts.nunitoSans(fontSize: 18),
                    ),
                    onTap: () {
                      //Navigator.push(context, CupertinoPageRoute(builder: (context) => Read()));
                      Navigator.pushNamed(context, '/read');
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SoftButton(
                    radius: btnRadius,

                    isClickable: true,
                    child: Text("Create QR",
                        style: GoogleFonts.nunitoSans(fontSize: 18)),
                    onTap: () {
                      Navigator.pushNamed(context, '/create');
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SoftButton(
                    radius: btnRadius,

                    isClickable: true,
                    child: Text("Scan History",
                        style: GoogleFonts.nunitoSans(fontSize: 18)),
                    onTap: () {
                      Navigator.pushNamed(context, '/history');
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SoftButton(
                    radius: btnRadius,

                    isClickable: true,
                    child: Text("About",
                        style: GoogleFonts.nunitoSans(fontSize: 18)),
                    onTap: () {
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
