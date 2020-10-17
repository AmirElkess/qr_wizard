import 'package:fancy_bottom_bar/fancy_bottom_bar.dart';
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
import 'package:share/share.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  File _imageFile;
  int selectedPos = 0;
  ScreenshotController screenshotController = ScreenshotController();
  final textController = TextEditingController();
  String qrInput = "";

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void saveImageToGallery(ctx) {
    screenshotController
        .capture(pixelRatio: 2, delay: Duration(milliseconds: 150))
        .then((File image) async {
      if (image != null && image.path != null) {
        await GallerySaver.saveImage(
          image.path,
          albumName: "QR Wizard",
        );
        SnackBar saveSB = SnackBar(content: Text('QR saved to gallery'));
        Scaffold.of(ctx).showSnackBar(saveSB);
      }
    });
  }

  void shareImage() {
    screenshotController
        .capture(pixelRatio: 2, delay: Duration(milliseconds: 50))
        .then((File image) async {
      if (image != null && image.path != null) {
        Share.shareFiles([image.path]);
      }
    });
  }

  Widget getInputWidget() {
    // TEXT - WIFI - CONTACT - URL
    switch (selectedPos) {
      case 0: {
        return SoftButton(
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
        );
      }
      case 1: {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SoftButton(
              inverted: true,
              radius: 12,
              width: double.infinity,
              height: 60,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                child: SizedBox(
                  height: double.infinity,
                  child: TextField(
                    controller: textController,
                    keyboardType: TextInputType.name,
                    onChanged: (text) {
                      setState(() {
                        qrInput = text;
                        print(qrInput);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'SSID',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            SoftButton(
              inverted: true,
              radius: 12,
              width: double.infinity,
              height: 60,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                child: SizedBox(
                  height: double.infinity,
                  child: TextField(
                    controller: textController,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (text) {
                      setState(() {
                        qrInput = text;
                        print(qrInput);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
      case 2: {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
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
                            keyboardType: TextInputType.name,
                            onChanged: (text) {
                              setState(() {
                                qrInput = text;
                                print(qrInput);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
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
                            keyboardType: TextInputType.name,
                            onChanged: (text) {
                              setState(() {
                                qrInput = text;
                                print(qrInput);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Last Name',
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
            Expanded(
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
                      keyboardType: TextInputType.name,
                      onChanged: (text) {
                        setState(() {
                          qrInput = text;
                          print(qrInput);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Organisation',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
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
                      keyboardType: TextInputType.phone,
                      onChanged: (text) {
                        setState(() {
                          qrInput = text;
                          print(qrInput);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
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
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (text) {
                        setState(() {
                          qrInput = text;
                          print(qrInput);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
      case 3: {
        return Column(
          children: [
            SoftButton(
              inverted: true,
              radius: 12,
              width: double.infinity,
              height: 100,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                child: SizedBox(
                  height: double.infinity,
                  child: TextField(
                    controller: textController,
                    keyboardType: TextInputType.url,
                    onChanged: (text) {
                      setState(() {
                        qrInput = text;
                        print(qrInput);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'URL',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
      default: {
        return Text("HELLO");
      }
    }

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
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 10,
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
                                      arguments: [qrInput, 'tag']);
                                },
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
                              textController.value = TextEditingValue(text: "");
                              qrInput = "";
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                              child: SoftButton(
                                child: Icon(Icons.save_alt),
                                isClickable: true,
                                onTap: () {
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    saveImageToGallery(context);
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: SoftButton(
                                child: Icon(Icons.share),
                                isClickable: true,
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  shareImage();
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 9,
                    child: getInputWidget(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: FancyBottomBar(
        items: [
          FancyBottomItem(title: Text("Text"), icon: Icon(Icons.text_fields, color: Colors.grey,)),
          FancyBottomItem(title: Text("WiFi"), icon: Icon(Icons.wifi, color: Colors.grey)),
          FancyBottomItem(title: Text("Contact"), icon: Icon(Icons.person, color: Colors.grey)),
          FancyBottomItem(title: Text("URL"), icon: Icon(Icons.link, color: Colors.grey)),
        ],
        onItemSelected: (i) => setState(() => selectedPos = i),
        selectedPosition: selectedPos,
        elevation: 0,
        bgColor: backgroundColor,
        //height: MediaQuery.of(context).size.height * 0.07,
      ),
    );
  }
}