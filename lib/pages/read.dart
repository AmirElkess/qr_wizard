import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';



class Read extends StatefulWidget {
  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {

  var qrText = '';
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Text(
          "Scan QR",
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
      body: Column(
        children: <Widget>[
          Text("only next"),
          SizedBox(
            height: 200,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (controller) {
                this.controller = controller;
                controller.scannedDataStream.listen((event) {
                  setState(() {
                    qrText = event;
                    print(qrText);
                  });
                });
              },
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
