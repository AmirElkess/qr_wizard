import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:flutter/services.dart';
import 'package:qr_wizard/res/button.dart';

class Read extends StatefulWidget {
  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  bool FLASH_ON = false;
  Icon flashIcon = Icon(Icons.flash_off);
  bool REAR_CAM = true;
  Icon camIcon = Icon(Icons.camera_rear);
  bool playing = true;
  Icon playPause = Icon(Icons.play_arrow);


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
        centerTitle: true,
        title: Text(
          "Scan QR",
          style: TextStyle(color: Colors.black),
        ),
        leading: SoftButton(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Builder(builder:  (context) {
          return Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor, offset: Offset(4, 4), blurRadius: 2),
                    BoxShadow(
                        color: lightShadowColor,
                        offset: Offset(-4, -4),
                        blurRadius: 2),
                  ],
                ),
                child: SizedBox(
                  height: 200,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: (controller) {
                      this.controller = controller;
                      controller.scannedDataStream.listen((event) {
                        setState(() {
                          qrText = event;
                          controller.pauseCamera();
                          playing = false;
                          playPause = Icon(Icons.pause);
                          //print(qrText);
                        });
                      });
                    },
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.blueGrey,
                      borderRadius: 5,
                      borderLength: 60,
                      borderWidth: 5,
                      cutOutSize: 200,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SoftButton(
                    child: flashIcon,
                    radius: 50,
                    onTap: () {
                      setState(() {
                        if (FLASH_ON){
                          flashIcon = Icon(Icons.flash_off);
                        } else {
                          flashIcon = Icon(Icons.flash_on, color: Colors.yellow,);
                        }
                        FLASH_ON = !FLASH_ON;
                        controller.toggleFlash();
                      });
                    },
                  ),
                  SoftButton(
                    child: camIcon,
                    radius: 50,
                    onTap: () {
                      setState(() {
                        if (REAR_CAM){
                          camIcon = Icon(Icons.camera_front);
                        } else {
                          camIcon = Icon(Icons.camera_rear);
                        }
                        REAR_CAM = !REAR_CAM;
                        controller.flipCamera();
                      });
                    },

                  ),
                  SoftButton(
                    child: playPause,
                    radius: 50,
                    onTap: () {
                      setState(() {
                        if (playing){
                          playPause = Icon(Icons.pause);
                          controller.pauseCamera();
                        } else {
                          playPause = Icon(Icons.play_arrow);
                          controller.resumeCamera();
                        }
                        playing = !playing;
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(thickness: 1.5),
              SizedBox(height: 10,),
              SizedBox(
                height: 140,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: SoftButton(
                        height: 150,
                        child: Text(qrText),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SoftButton(
                        height: 150,
                        child: Icon(Icons.content_copy),
                        onTap: (){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Text copied to clipboard", style: TextStyle(color: Colors.black),),
                            backgroundColor: backgroundColor,
                            elevation: 0.0,
                            duration: Duration(seconds: 2),
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        })
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
