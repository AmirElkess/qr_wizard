import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:qr_wizard/res/constants.dart';

class QrViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> extras = ModalRoute.of(context).settings.arguments;
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
      body: Center(
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
