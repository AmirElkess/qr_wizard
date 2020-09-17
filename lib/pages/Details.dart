import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:qr_wizard/res/constants.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Entry entry = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          title: Text(
            "Details",
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
                        child: SoftButton(
                          radius: 12,
                          height: double.infinity,
                          width: double.infinity,
                          child: QrImage(
                            data: entry.qrString,
                            version: QrVersions.auto,
                            size: 200.0,
                            backgroundColor: backgroundColor,
                          ),
                        ),
                      ),

                    ]),
                  ),
                  Expanded(
                    flex: 4,
                    child: SoftButton(
                      radius: 12,
                      width: double.infinity,
                      height: double.infinity,
                      child: Text(entry.qrString)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}