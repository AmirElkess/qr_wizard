import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/database/qrDataTypes.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Widget qrText = Text('');
  String qrTextString = '';
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
            padding: universalPadding,
            child: Builder(builder: (context) {
              return SoftButton(
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
                                color: shadowColor,
                                offset: Offset(4, 4),
                                blurRadius: 2),
                            BoxShadow(
                                color: lightShadowColor,
                                offset: Offset(-4, -4),
                                blurRadius: 2),
                          ],
                        ),
                        child: SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.resumeCamera();
                                playing = true;
                                playPause = Icon(Icons.play_arrow);
                              });
                            },
                            child: QRView(
                              key: qrKey,
                              onQRViewCreated: (controller) {
                                this.controller = controller;
                                controller.scannedDataStream
                                    .listen((event) async {
                                  qrTextString = event;
                                  Entry entry = Entry(
                                      id: null,
                                      qrString: qrTextString,
                                      timestamp:
                                          DateTime.now().toIso8601String(),
                                      dataType: QrDataTypes.URL.index);
                                  insertEntry(entry);
                                  if (await canLaunch(event)) {
                                    print("Found URL string");
                                    qrText = GestureDetector(
                                      child: Text(
                                        qrTextString,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      onTap: () async {
                                        await launch(qrTextString);
                                      },
                                    );
                                  } else {
                                    print("Found normal string");
                                    qrText = Text(qrTextString);
                                  }
                                  setState(() {
                                    controller.pauseCamera();
                                    playing = false;
                                    playPause = Icon(Icons.pause);
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
                          isClickable: true,
                          onTap: () {
                            setState(() {
                              if (FLASH_ON) {
                                flashIcon = Icon(Icons.flash_off);
                              } else {
                                flashIcon = Icon(
                                  Icons.flash_on,
                                  color: Colors.yellow,
                                );
                              }
                              FLASH_ON = !FLASH_ON;
                              controller.toggleFlash();
                            });
                          },
                        ),
                        SoftButton(
                          child: camIcon,
                          radius: 50,
                          isClickable: true,
                          onTap: () {
                            setState(() {
                              if (REAR_CAM) {
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
                          isClickable: true,
                          onTap: () {
                            setState(() {
                              if (playing) {
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
                    Divider(
                      thickness: 1.5,
                      indent: 14,
                      endIndent: 14,
                    ),
                    SizedBox(
                      height: 8,
                    ),
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
                                    child: qrText,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SoftButton(
                                height: 150,
                                radius: 12,
                                isClickable: true,
                                child: Icon(Icons.content_copy),
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: qrTextString));
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content:
                                          Text('Text Copied to clipboard')));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
