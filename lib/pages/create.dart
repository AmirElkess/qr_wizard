import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  String qrInput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 140,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      qrInput = text;
                      print(qrInput);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter a term',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              QrImage(
                data: qrInput,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
