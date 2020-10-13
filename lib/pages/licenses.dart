import 'package:flutter/material.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/licenseStrings.dart';
import 'package:qr_wizard/res/button.dart';

class Licenses extends StatefulWidget {
  @override
  _LicensesState createState() => _LicensesState();
}

class _LicensesState extends State<Licenses> {
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
                Text("Flutter", style: TextStyle(fontStyle: FontStyle.italic), ),
                SoftButton(
                  inverted: true,
                  radius: 8,
                  width: double.infinity,
                  height: 250,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(flutterLicense),
                    ),
                  ),
                ),
                SizedBox(height: 12,),

                Text("qr_flutter", style: TextStyle(fontStyle: FontStyle.italic), ),
                SoftButton(
                  inverted: true,

                  radius: 8,
                  width: double.infinity,
                  height: 250,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(qr_flutterLicense),
                    ),
                  ),
                ),
                SizedBox(height: 12,),

                Text("qr_code_scanner", style: TextStyle(fontStyle: FontStyle.italic), ),
                SoftButton(
                  inverted: true,

                  radius: 8,
                  width: double.infinity,
                  height: 250,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(qr_code_scannerLicense),
                    ),
                  ),
                ),
                SizedBox(height: 12,),

                Text("gallery_saver", style: TextStyle(fontStyle: FontStyle.italic), ),
                SoftButton(
                  inverted: true,

                  radius: 8,
                  width: double.infinity,
                  height: 250,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(gallery_saverLicense),
                    ),
                  ),
                ),
                SizedBox(height: 12,),

                Text("screenshot", style: TextStyle(fontStyle: FontStyle.italic), ),
                SoftButton(
                  inverted: true,

                  radius: 8,
                  width: double.infinity,
                  height: 250,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(screenshotLicense),
                    ),
                  ),
                ),
                SizedBox(height: 12,),

                Text("url_launcher", style: TextStyle(fontStyle: FontStyle.italic), ),
                SoftButton(
                  inverted: true,

                  radius: 8,
                  width: double.infinity,
                  height: 250,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(url_launcherLicense),
                    ),
                  ),
                ),
                SizedBox(height: 12,),

                Text("flutter_launcher_icons", style: TextStyle(fontStyle: FontStyle.italic), ),
                SoftButton(
                  inverted: true,

                  radius: 8,
                  width: double.infinity,
                  height: 250,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(flutter_launcher_iconsLicense),
                    ),
                  ),
                ),
                SizedBox(height: 12,),

                Text("quick_actions", style: TextStyle(fontStyle: FontStyle.italic), ),
                SoftButton(
                  inverted: true,

                  radius: 8,
                  width: double.infinity,
                  height: 250,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(quick_actionsLicense),
                    ),
                  ),
                ),
                SizedBox(height: 12,),

                Text("flutter_linkify", style: TextStyle(fontStyle: FontStyle.italic), ),
                SoftButton(
                  inverted: true,

                  radius: 8,
                  width: double.infinity,
                  height: 250,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(flutter_linkifyLicense),
                    ),
                  ),
                ),
                SizedBox(height: 12,),
              ],
            )
        ),
      ),
    );
  }
}
