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
  double btnRadius = 24;
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
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.46,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SoftButton(
                    radius: btnRadius,
                    inverted: true,
                    child: Text("QR WIZARD",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.nunitoSans(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  flex: 1,
                  child: SoftButton(
                    shadowOffset: 0,
                    blurRadius: 0,
                    radius: btnRadius,
                    isClickable: true,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 4, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Scan QR",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.nunitoSans(fontSize: 18),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/read');
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SoftButton(
                    radius: btnRadius,
                    shadowOffset: 0,
                    blurRadius: 0,
                    isClickable: true,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 4, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Create QR",
                                style: GoogleFonts.nunitoSans(fontSize: 18)),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/create');
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SoftButton(
                    radius: btnRadius,
                    shadowOffset: 0,
                    blurRadius: 0,
                    isClickable: true,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 4, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Scan History",
                                style: GoogleFonts.nunitoSans(fontSize: 18)),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/history');
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SoftButton(
                    radius: btnRadius,
                    shadowOffset: 0,
                    blurRadius: 0,
                    isClickable: true,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 4, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("About",
                                style: GoogleFonts.nunitoSans(fontSize: 18)),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
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
