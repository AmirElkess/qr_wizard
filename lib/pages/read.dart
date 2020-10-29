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

  void togglePlayButton() {
    if (playing) {
      pauseButton();
    } else {
      playButton();
    }
  }

  void pauseButton() {
    setState(() {
      controller.pauseCamera();
      playing = false;
      playPause = Icon(Icons.pause);
    });
  }

  void playButton() {
    setState(() {
      controller.resumeCamera();
      playing = true;
      playPause = Icon(Icons.play_arrow);
    });
  }

  String displayString = '';
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
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
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
                              if (event.isNotEmpty) {

                                pauseButton();

                                var qrDataType = QrDataTypes
                                    .values[await classifyType(event)];

                                var _type = await classifyType(event);

                                Entry entry = Entry(
                                    id: null,
                                    qrString: event,
                                    timestamp: DateTime.now().toIso8601String(),
                                    dataType: _type);

                                insertEntry(entry);

                                if (qrDataType == QrDataTypes.TEXT ||
                                    qrDataType == QrDataTypes.URL) {

                                  setState(() {
                                    displayString = event;
                                  });

                                } else if (qrDataType == QrDataTypes.CONTACT) {
                                  displayString = "";
                                  await Navigator.pushNamed(
                                      context, '/contact_details',
                                      arguments: entry);
                                  playButton();
                                } else if (qrDataType == QrDataTypes.WIFI) {
                                  displayString = "";
                                  await Navigator.pushNamed(
                                      context, '/wifi_details',
                                      arguments: entry);
                                  playButton();
                                }
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
                              togglePlayButton();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: SoftButton(
                    radius: 12,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: SoftButton(
                            radius: 12,
                            child: Padding(
                              padding: const EdgeInsets.all(9),
                              child: SingleChildScrollView(
                                child: Linkify(
                                    text: displayString,
                                    onOpen: (link) => {launch(link.url)}),
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
                                  ClipboardData(text: displayString));
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Text Copied to clipboard')));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: AnimatedOpacity(
                    opacity: displayString.trim().isNotEmpty ? 1 : 0,
                    duration: Duration(milliseconds: 450),
                    child: SoftButton(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            FittedBox(child: Icon(Icons.search_rounded, color: backgroundColor)),
                            Expanded(child: Text("Search google")),
                            Icon(Icons.search_rounded)
                          ],
                        ),
                      ),
                      isClickable: true,
                      onTap: () async {
                        await launch(
                            "https://www.google.com/search?q=$displayString");
                      },
                    ),
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
    playButton();
    controller.dispose();
    super.dispose();
  }
}
