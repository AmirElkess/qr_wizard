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
              height: 500,
              child: Padding(
                padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Who am I", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("An independent Hobbyist/Developer who's interested in Flutter app development."),
                    SizedBox(height: 12,),
                    Text("Contact me", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Email: amir.elkess@gmail.com"),
                    SizedBox(height: 12,),
                    Text("Open source licenses", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Flutter", style: TextStyle(fontStyle: FontStyle.italic), ),
                    SoftButton(
                      radius: 8,
                      width: double.infinity,
                      child: Text(flutterLicense),
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

