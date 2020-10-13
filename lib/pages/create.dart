import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  File _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  final textController = TextEditingController();
  String qrInput = "";

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          title: Text(
            "Create QR",
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
              child: SoftButton(
                radius: 12,
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.6,
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
                              padding: const EdgeInsets.all(3),
                              child: Screenshot(
                                controller: screenshotController,
                                child: GestureDetector(
                                  onTap: (){Navigator.pushNamed(context, '/qr_view', arguments: [qrInput, 'tag']);},
                                  child: Hero(
                                    tag: 'tag',
                                    child: QrImage(
                                      data: qrInput,
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
                            width: double.infinity,
                            height: double.infinity,
                            child: Icon(Icons.clear),
                            isClickable: true,
                            onTap: () {
                              setState(() {
                                textController.value =
                                    TextEditingValue(text: "");
                                qrInput = "";
                              });
                            },
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
                      child: SoftButton(
                        inverted: true,
                        radius: 12,
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                          child: SizedBox(
                            height: double.infinity,
                            child: TextField(
                              controller: textController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              maxLength: 120,
                              maxLengthEnforced: true,
                              onChanged: (text) {
                                setState(() {
                                  qrInput = text;
                                  print(qrInput);
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter text here',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
