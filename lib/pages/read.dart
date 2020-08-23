import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class Read extends StatefulWidget {
  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {

  double notificationOpacityLevel = 0;
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
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: universalPadding,
          child: Builder(builder:  (context) {
            return Column(
              children: <Widget>[
                SoftButton(
                  width: double.infinity,
                  height: 420,
                  radius: 12,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
                        child: Container(
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
                            width: double.infinity,
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
                      ),
                      SizedBox(
                        height: 8,
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
                        height: 8,
                      ),
                      Divider(thickness: 1.5, indent: 14, endIndent: 14,),
                      SizedBox(height: 8,),
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: SoftButton(
                                  height: 150,
                                  radius: 12,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(9.0),
                                      child: Text(qrText),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SoftButton(
                                  height: 150,
                                  radius: 12,
                                  child: Icon(Icons.content_copy),
                                  onTap: (){
                                    setState(() {
                                      Clipboard.setData(ClipboardData(text: qrText));
                                      notificationOpacityLevel = 1;
                                      print(notificationOpacityLevel);
                                      new Timer(Duration(seconds: 2), (){
                                        setState(() {
                                          notificationOpacityLevel = 0;
                                        });
                                      });
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                AnimatedOpacity(
                  opacity: notificationOpacityLevel,
                  duration: Duration(milliseconds: 600),
                  child: SoftButton(
                    height: 30,
                    radius: 12,
                    width: double.infinity,
                    child: Text("Text copied to clipboard"),
                  ),
                )
              ],
            );
          })
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
