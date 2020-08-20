import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:flutter/services.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  String qrInput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Text(
          "Create QR",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: SoftButton(
          margin: 8,
          radius: 30,
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: SoftButton(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      maxLength: 120,
                      onChanged: (text) {
                        setState(() {
                          qrInput = text;
                          print(qrInput);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter text here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(),
              Expanded(
                flex: 5,
                child: SoftButton(
                  height: double.infinity,
                  width: double.infinity,
                  child: QrImage(
                    data: qrInput,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ),
              SizedBox(height: 25,)
            ],
          ),
        ),
      ),
    );
  }
}
