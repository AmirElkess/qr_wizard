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
            return SingleChildScrollView(
              child: Padding(
                padding: universalPadding,
                child: SoftButton(
                  radius: 12,
                  width: double.infinity,
                  height: 400,
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
                              child: Screenshot(
                                controller: screenshotController,
                                child: QrImage(
                                  data: qrInput,
                                  version: QrVersions.auto,
                                  size: 200.0,
                                  backgroundColor: backgroundColor,
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
                          radius: 12,
                          width: double.infinity,
                          height: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                            child: TextField(
                              controller: textController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              maxLength: 120,
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
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
