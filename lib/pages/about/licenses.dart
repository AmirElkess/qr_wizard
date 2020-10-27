import 'package:flutter/material.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/licenseStrings.dart';
import 'package:qr_wizard/res/button.dart';

class Licenses extends StatefulWidget {
  @override
  _LicensesState createState() => _LicensesState();
}

class _LicensesState extends State<Licenses> {

  Widget licenseCard (String licenseName, String licenseString) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(child: Text(licenseName, style: TextStyle(fontStyle: FontStyle.italic), )),
        SizedBox(height: 5,),
        SoftButton(
          inverted: true,
          radius: 8,
          width: double.infinity,
          height: 180,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(licenseString),
            ),
          ),
        ),
        SizedBox(height: 18,),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Text(
          "Open Source Licenses",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: SoftButton(
          margin: 8,
          radius: 24,
          width: 5,
          height: 5,
          shadowOffset: 0,
          blurRadius: 0,
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(25),
            child: Column (
              children: [
                licenseCard("Flutter", flutterLicense),

                licenseCard("qr_flutter", qr_flutterLicense),

                licenseCard("qr_code_scanner", qr_code_scannerLicense),

                licenseCard("gallery_saver", gallery_saverLicense),

                licenseCard("screenshot", screenshotLicense),

                licenseCard("url_launcher", url_launcherLicense),

                licenseCard("flutter_launcher_icons", flutter_launcher_iconsLicense),

                licenseCard("quick_actions", quick_actionsLicense),

                licenseCard("flutter_linkify", flutter_linkifyLicense),
                
                licenseCard('simple_vcard_parser', simple_vcard_parserLicense),

                licenseCard("flutter_contact", flutter_contactLicense),

                licenseCard("form_validator", form_validatorLicense),

                licenseCard("vcard", vcardLicense),

                licenseCard("fancy_bottom_bar", fancy_bottom_barLicense),

                licenseCard('permission_handler', permission_handlerLicense),

              ],
            )
        ),
      ),
    );
  }
}
