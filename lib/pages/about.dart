import 'package:flutter/material.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';

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
            "About",
            style: TextStyle(color: Colors.black),
          ),
          leading: SoftButton(
            margin: 8,
            radius: 24,
            width: 5,
            height: 5,
            blurRadius: 0,

            shadowOffset: 0,
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Align(
          alignment: universalAlignment,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Who am I", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("An independent Hobbyist/Developer who's interested in Flutter app development."),
                  SizedBox(height: 12,),
                  Text("Contact me", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Name: Amir Elkess"),
                  Text("Email: amir.elkess@gmail.com"),
                  SizedBox(height: 20,),
                  SoftButton(
                    width: double.infinity,
                    radius: 16,
                    height: 40,
                    shadowOffset: 0,
                    blurRadius: 0,
                    isClickable: true,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(6, 0, 4, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Privacy Policy"),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    onTap: (){
                        Navigator.pushNamed(context, '/privacy_policy');
                    },
                  ),
                  SizedBox(height: 10,),
                  SoftButton(
                    width: double.infinity,
                    radius: 16,
                    height: 40,
                    shadowOffset: 0,
                    blurRadius: 0,
                    isClickable: true,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(6, 0, 4, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Open Source Licenses"),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, '/licenses');
                    },
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}

