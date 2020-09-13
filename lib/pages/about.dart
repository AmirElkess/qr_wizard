import 'package:flutter/material.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:qr_wizard/res/licenses.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "ABOUT",
            style: TextStyle(color: Colors.black),
          ),
          leading: SoftButton(
            margin: 8,
            radius: 24,
            width: 5,
            height: 5,
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
            padding: universalPadding,
            child: SoftButton(
              radius: 12,
              width: double.infinity,
              height: 2640,
              child: Padding(
                padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Who am I", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("An independent Hobbyist/Developer who's interested in Flutter app development."),
                    SizedBox(height: 12,),
                    Text("Contact me", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Name: Amir Elkess"),
                    Text("Email: amir.elkess@gmail.com"),
                    SizedBox(height: 12,),
                    SoftButton(
                      width: double.infinity,
                      radius: 12,
                      height: 30,
                      child: Text("Privacy Policy"),
                      onTap: (){
                          Navigator.pushNamed(context, '/privacy_policy');
                      },
                    ),
                    Text("Open source licenses", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Flutter", style: TextStyle(fontStyle: FontStyle.italic), ),
                    SoftButton(
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
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}

