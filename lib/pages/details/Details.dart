import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  ScreenshotController screenshotController = ScreenshotController();
  final textController = TextEditingController();
  //String qrInput = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Entry entry = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          title: Text(
            "Details",
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
        body: Builder(
          builder: (BuildContext context) {
            return Align(
              alignment: universalAlignment,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.6,
                child: SoftButton(
                  radius: 12,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Row(children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: SoftButton(
                              radius: 12,
                              height: double.infinity,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(3),
                                child: Screenshot(
                                  controller: screenshotController,
                                  child: GestureDetector(
                                    onTap: (){Navigator.pushNamed(context, '/qr_view', arguments: [entry.qrString, 'tag']);},
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
                              radius: 12,
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
                                      print("Image and path correct");
                                      print(image.path);
                                      await GallerySaver.saveImage(
                                        image.path,
                                        albumName: "QR Wizard",
                                      );
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content:
                                              Text('QR saved to gallery')));
                                    }
                                  });
                                });
                              },
                            ),
                          )
                        ]),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: SoftButton(
                                radius: 12,
                                width: double.infinity,
                                height: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: FittedBox(alignment: Alignment.centerLeft, child: Text("Scanned on ${DateTime.parse(entry.timestamp).toString().substring(0, 11)}, at ${DateTime.parse(entry.timestamp).toString().substring(11, 16)}.", style: TextStyle( color: Colors.grey),)),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: SingleChildScrollView(child: Linkify(text: entry.qrString, onOpen: (link) => {launch(link.url)},)),
                                        )
                                      ],
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
                                radius: 12,
                                isClickable: true,
                                child: Icon(Icons.content_copy),
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: entry.qrString));
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content:
                                      Text('Text Copied to clipboard')));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
