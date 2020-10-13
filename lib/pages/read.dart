import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/database/qrDataTypes.dart';
import 'package:qr_wizard/functions/wifiParser.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_wizard/functions/typeClassifier.dart';

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
      body: Builder(builder: (context) {
        return Align(
          alignment: universalAlignment,
          child: SoftButton(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.65,
            radius: 12,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 11,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: shadowColor,
                              offset: Offset(3, 3),
                              blurRadius: 2),
                          BoxShadow(
                              color: lightShadowColor,
                              offset: Offset(-3, -3),
                              blurRadius: 2),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: QRView(
                          key: qrKey,
                          onQRViewCreated: (controller) {
                            this.controller = controller;
                            controller.scannedDataStream.listen((event) async {
                              setState(() {
                                controller.pauseCamera();
                                playing = false;
                                playPause = Icon(Icons.pause);
                              });

                              qrTextString = event;
                              var qrDataType = QrDataTypes
                                  .values[await classifyType(qrTextString)];
                              print(qrDataType);
                              Entry entry = Entry(
                                  id: null,
                                  qrString: qrTextString,
                                  timestamp: DateTime.now().toIso8601String(),
                                  dataType: await classifyType(qrTextString));
                              insertEntry(entry);

                              if (qrDataType == QrDataTypes.TEXT ||
                                  qrDataType == QrDataTypes.URL) {
                                qrText = Linkify(
                                    text: qrTextString,
                                    onOpen: (link) => {launch(link.url)});
                              } else if (qrDataType == QrDataTypes.CONTACT) {
                                //qrText = Text("Contact: " + qrTextString);
                                await Navigator.pushNamed(
                                    context, '/contact_details',
                                    arguments: entry);
                                setState(() {
                                  controller.resumeCamera();
                                  playing = true;
                                  playPause = Icon(Icons.play_arrow);
                                });
                              } else if (qrDataType == QrDataTypes.WIFI) {
                                await Navigator.pushNamed(
                                    context, '/wifi_details',
                                    arguments: entry);
                                setState(() {
                                  controller.resumeCamera();
                                  playing = true;
                                  playPause = Icon(Icons.play_arrow);
                                });
                              }
                            });
                          },
                          overlay: QrScannerOverlayShape(
                            borderColor: Colors.blueGrey,
                            borderRadius: 12,
                            borderLength: 60,
                            borderWidth: 4,
                            cutOutSize:
                                MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SoftButton(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: SoftButton(
                            child: FittedBox(child: camIcon),
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
                        ),
                        Expanded(
                          flex: 3,
                          child: SoftButton(
                            child: FittedBox(child: flashIcon),
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
                        ),
                        Expanded(
                          flex: 2,
                          child: SoftButton(
                            child: FittedBox(child: playPause),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Padding(padding: EdgeInsets.fromLTRB(8,0,8,0), child: Divider(),),
                Expanded(
                  flex: 6,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: SoftButton(
                          radius: 12,
                          child: Padding(
                            padding: const EdgeInsets.all(9),
                            child: SingleChildScrollView(
                              child: qrText,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SoftButton(
                          isClickable: true,
                          child: Icon(Icons.content_copy),
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: qrTextString));
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Text Copied to clipboard')));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
