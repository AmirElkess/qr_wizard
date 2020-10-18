import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:qr_wizard/res/constants.dart';

class QrViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> extras = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Text(
          "QR View",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {Navigator.pop(context);},
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Align(
        alignment: universalAlignment,
        child: GestureDetector(
          onTap: (){Navigator.pop(context);},

          child: Hero(
            tag: extras[1],
            child: QrImage(
              data: extras[0],
            ),
          ),
        ),
      ),
    );
  }
}
