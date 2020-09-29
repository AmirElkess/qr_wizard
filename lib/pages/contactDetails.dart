import 'package:flutter/material.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:qr_wizard/res/constants.dart';

class ContactDetails extends StatefulWidget {
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    Entry entry = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          title: Text(
            "Contact",
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
            child: SoftButton(
              radius: 12,
              width: double.infinity,
              height: 400,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Row(children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Text("Hello there"),
                      ),

                    ]),
                  ),
                  Expanded(
                    flex: 4,
                    child: SoftButton(
                        radius: 12,
                        width: double.infinity,
                        height: double.infinity,
                        child: SingleChildScrollView(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(entry.qrString))
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
