import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/functions/wifiParser.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:screenshot/screenshot.dart';

class WifiDetails extends StatefulWidget {
  @override
  _WifiDetailsState createState() => _WifiDetailsState();
}

class _WifiDetailsState extends State<WifiDetails> {
  @override
  Widget build(BuildContext context) {
    Entry entry = ModalRoute.of(context).settings.arguments;
    ScreenshotController screenshotController = ScreenshotController();

    Widget getWifiBody() {
      if (parseWifi(entry.qrString)[1] == '-1') {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("SSID: " + parseWifi(entry.qrString)[0], style: TextStyle(fontSize: 18)),
            Text(
              'PASSWORD: [Password-less WiFi]',
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 18),
            ),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("SSID: " + parseWifi(entry.qrString)[0], style: TextStyle(fontSize: 18)),
            Text(
              "Password: " + parseWifi(entry.qrString)[1],
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 18),
            ),
          ],
        );
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Text(
          "WiFi",
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
      body: Align(
        alignment: universalAlignment,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.55,
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 12,
                    child: Row(children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: SoftButton(
                          radius: 12,
                          height: double.infinity,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Screenshot(
                              controller: screenshotController,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/qr_view',
                                      arguments: [entry.qrString, 'tag']);
                                },
                                child: Hero(
                                  tag: 'tag',
                                  child: QrImage(
                                    data: entry.qrString,
                                    version: QrVersions.auto,
                                    backgroundColor: backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SoftButton(
                          height: double.infinity,
                          width: double.infinity,
                          child: Icon(Icons.save_alt),
                          isClickable: true,
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).unfocus();
                              screenshotController
                                  .capture(
                                      pixelRatio: 2,
                                      delay: Duration(milliseconds: 150))
                                  .then((File image) async {
                                if (image != null && image.path != null) {
                                  await GallerySaver.saveImage(
                                    image.path,
                                    albumName: "QR Wizard",
                                  );
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('QR saved to gallery')));
                                }
                              });
                            });
                          },
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    flex: 5,
                    child: SoftButton(
                      radius: 12,
                      width: double.infinity,
                      height: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 1,
                              child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Scanned on ${DateTime.parse(entry.timestamp).toString().substring(0, 10)}, at ${DateTime.parse(entry.timestamp).toString().substring(11, 16)}.",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                            ),
                            SizedBox(height: 6,),
                            Expanded(
                              flex: 5,
                              child: SingleChildScrollView(child: getWifiBody()),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: SoftButton(
                            isClickable: true,
                            width: double.infinity,
                            height: double.infinity,
                            child: Text("Copy SSID"),
                            onTap: (){
                              setState(() {
                                Clipboard.setData(ClipboardData(text: parseWifi(entry.qrString)[0]));
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('SSID Copied to clipboard')));
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: SoftButton(
                            isClickable: true,
                            width: double.infinity,
                            height: double.infinity,
                            child: Text("Copy Password"),
                            onTap: (){
                              setState(() {
                                String _password = parseWifi(entry.qrString)[1];
                                if (_password == '-1') {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('WiFi is Password-less')));
                                } else {
                                  Clipboard.setData(ClipboardData(text: _password));
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Password Copied to clipboard')));
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
