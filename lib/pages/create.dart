import 'dart:io';
import 'package:fancy_bottom_bar/fancy_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share/share.dart';
import 'package:vcard/vcard.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  Map controllers = {
    'txt': TextEditingController(),
    'url': TextEditingController(),
    'wifi': {
      'ssid': TextEditingController(),
      'password': TextEditingController(),
      'security': TextEditingController(),
    },
    'contact': {
      'first_name': TextEditingController(),
      'last_name': TextEditingController(),
      'org': TextEditingController(),
      'phone': TextEditingController(),
      'email': TextEditingController(),
      'title': TextEditingController(),
    }
  };

  double inputHeight = 60;
  int selectedPos = 0; //bottom app bar choice
  ScreenshotController screenshotController = ScreenshotController();
  String qrInput = ""; //will be fed to the QrImage view & the enlarged qr view

  @override
  void dispose() {
    controllers['contact'].forEach((key, value) {
      value.dispose();
    });
    controllers['wifi'].forEach((key, value) {
      value.dispose();
    });
    controllers['txt'].dispose();
    controllers['url'].dispose();
    super.dispose();
  }

  @override
  void initState() {
    controllers['wifi']['security'].text = 'WPA2-EAP';
    super.initState();
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

  void clearContact() {
    controllers['contact'].forEach((key, value) {
      value.clear();
    });
  }

  void clear() {
    // TEXT - WIFI - CONTACT - URL
    switch (selectedPos) {
      case 0: //TEXT
        {
          controllers['txt'].value = TextEditingValue(text: "");
          break;
        }
      case 1: //WiFi
        {
          controllers['wifi'].forEach((key, value) {
            value.clear();
          });

          controllers['wifi']['security'].text = 'WPA2-EAP';

          break;
        }
      case 2: //Contact
        {
          clearContact();
          break;
        }
      case 3: //URL
        {
          controllers['url'].value = TextEditingValue(text: "");
          break;
        }
      default:
        {
          qrInput = '';
        }
    }
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

  void updateQrInput() {
    // TEXT - WIFI - CONTACT - URL
    switch (selectedPos) {
      case 0: //TEXT
        {
          qrInput = controllers['txt'].text;
          break;
        }
      case 1: //WiFi
        {
          String ssid = controllers['wifi']['ssid']
              .text
              .replaceAll(r'\', r'\\')
              .replaceAll(r';', r'\;')
              .replaceAll(r',', r'\,')
              .replaceAll(r':', r'\:');
          String password = controllers['wifi']['password']
              .text
              .replaceAll(r'\', r'\\')
              .replaceAll(r';', r'\;')
              .replaceAll(r',', r'\,')
              .replaceAll(r':', r'\:');
          String auth = controllers['wifi']['security'].text;
          String wifiResult = "";
          if (ssid.trim().isNotEmpty) {
            if (password.trim().isEmpty) {
              wifiResult = 'WIFI:T:nopass;S:$ssid;P:;;';
            } else {
              wifiResult = 'WIFI:T:$auth;S:$ssid;P:$password;;';
            }
            qrInput = wifiResult;
          } else {
            qrInput = "";
          }
          break;
        }
      case 2:
        {
          //Contact
          VCard vCard = VCard();
          if (controllers['contact']['first_name'].text.trim().isNotEmpty) {
            vCard.firstName = controllers['contact']['first_name'].text.trim();
          }
          if (controllers['contact']['last_name'].text.trim().isNotEmpty) {
            vCard.lastName = controllers['contact']['last_name'].text.trim();
          }
          if (controllers['contact']['org'].text.trim().isNotEmpty) {
            vCard.organization = controllers['contact']['org'].text.trim();
          }
          if (controllers['contact']['email'].text.trim().isNotEmpty) {
            vCard.email = controllers['contact']['email'].text.trim();
          }
          if (controllers['contact']['title'].text.trim().isNotEmpty) {
            vCard.jobTitle = controllers['contact']['title'].text.trim();
          }
          if (controllers['contact']['email'].text.trim().isNotEmpty) {
            vCard.email = controllers['contact']['email'].text.trim();
          }
          if (controllers['contact']['phone'].text.trim().isNotEmpty) {
            vCard.cellPhone = controllers['contact']['phone'].text.trim();
          }
          qrInput = vCard.getFormattedString();
          break;
        }
      case 3:
        {
          qrInput = controllers['url'].text;
          break;
        }
      default:
        {
          qrInput = '';
        }
    }
  }

  Widget getInputWidget() {
    // TEXT - WIFI - CONTACT - URL
    switch (selectedPos) {
      case 0: //TEXT
        {
          return SoftButton(
            inverted: true,
            radius: 12,
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
              child: SizedBox(
                height: double.infinity,
                child: TextFormField(
                  controller: controllers['txt'],
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  maxLength: 120,
                  maxLengthEnforced: true,
                  onChanged: (text) {
                    setState(() {
                      updateQrInput();
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
      case 1: //WiFi
        {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SoftButton(
                  inverted: true,
                  radius: 12,
                  width: double.infinity,
                  height: inputHeight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                    child: SizedBox(
                      height: double.infinity,
                      child: TextFormField(
                        controller: controllers['wifi']['ssid'],
                        keyboardType: TextInputType.name,
                        onChanged: (text) {
                          setState(() {
                            updateQrInput();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'SSID (Required)',
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
                  height: inputHeight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                    child: SizedBox(
                      height: double.infinity,
                      child: TextFormField(
                        controller: controllers['wifi']['password'],
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (text) {
                          setState(() {
                            updateQrInput();
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
                AnimatedOpacity(
                  opacity: controllers['wifi']['password'].text.trim().isNotEmpty ? 1 : 0,
                  duration: Duration(milliseconds: 450),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Authentication', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                AnimatedOpacity(
                  opacity: controllers['wifi']['password'].text.trim().isNotEmpty ? 1 : 0,
                  duration: Duration(milliseconds: 450),
                  child: Row(children: [
                    Expanded(
                      child: SoftButton(
                        inverted: controllers['wifi']['security'].text == 'WPA2-EAP',
                        radius: 16,
                        blurRadius: 5,
                        shadowOffset: 1.5,
                        width: double.infinity,
                        height: inputHeight,
                        child: Text('WPA2-EAP'),
                        onTap: () {
                          setState(() {
                            controllers['wifi']['security'].text = 'WPA2-EAP';
                            updateQrInput();
                          });
                          },
                      ),
                    ),
                    Expanded(
                      child: SoftButton(
                        blurRadius: 5,
                        shadowOffset: 1.5,
                        inverted: controllers['wifi']['security'].text == 'WPA',
                        radius: 16,
                        width: double.infinity,
                        height: inputHeight,
                        child: Text('WPA'),
                        onTap: () {
                          setState(() {
                            controllers['wifi']['security'].text = 'WPA';
                            updateQrInput();
                          });
                          },
                      ),
                    ),
                    Expanded(
                      child: SoftButton(
                        inverted: controllers['wifi']['security'].text == 'WEP',
                        radius: 16,
                        blurRadius: 5,
                        shadowOffset: 1.5,
                        width: double.infinity,
                        height: inputHeight,
                        child: Text('WEP'),
                        onTap: () {
                          setState(() {
                            controllers['wifi']['security'].text = 'WEP';
                            updateQrInput();
                          });
                          },
                      ),
                    ),
                  ],),
                )
              ],
            ),
          );
        }
      case 2: //Contact
        {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SoftButton(
                        inverted: true,
                        radius: 12,
                        width: double.infinity,
                        height: inputHeight,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                          child: SizedBox(
                            height: double.infinity,
                            child: TextFormField(
                              controller: controllers['contact']['first_name'],
                              keyboardType: TextInputType.name,
                              onChanged: (text) {
                                setState(() {
                                  updateQrInput();
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
                        height: inputHeight,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                          child: SizedBox(
                            height: double.infinity,
                            child: TextFormField(
                              controller: controllers['contact']['last_name'],
                              keyboardType: TextInputType.name,
                              onChanged: (text) {
                                setState(() {
                                  updateQrInput();
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
                ), //fname lname
                SoftButton(
                  inverted: true,
                  radius: 12,
                  width: double.infinity,
                  height: inputHeight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                    child: SizedBox(
                      height: double.infinity,
                      child: TextFormField(
                        controller: controllers['contact']['org'],
                        keyboardType: TextInputType.name,
                        onChanged: (text) {
                          setState(() {
                            updateQrInput();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Organisation',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ), //org
                SoftButton(
                  inverted: true,
                  radius: 12,
                  width: double.infinity,
                  height: inputHeight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                    child: SizedBox(
                      height: double.infinity,
                      child: TextFormField(
                        controller: controllers['contact']['phone'],
                        keyboardType: TextInputType.phone,
                        onChanged: (text) {
                          setState(() {
                            updateQrInput();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ), //phone
                SoftButton(
                  inverted: true,
                  radius: 12,
                  width: double.infinity,
                  height: inputHeight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                    child: SizedBox(
                      height: double.infinity,
                      child: TextFormField(
                        controller: controllers['contact']['email'],
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (text) {
                          setState(() {
                            updateQrInput();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ), //email
                SoftButton(
                  inverted: true,
                  radius: 12,
                  width: double.infinity,
                  height: inputHeight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                    child: SizedBox(
                      height: double.infinity,
                      child: TextFormField(
                        controller: controllers['contact']['title'],
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          setState(() {
                            updateQrInput();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ), //title
              ],
            ),
          );
        }
      case 3: //URL
        {
          return SingleChildScrollView(
            child: SoftButton(
              inverted: true,
              radius: 12,
              width: double.infinity,
              height: 100,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 6, 15, 12),
                child: SizedBox(
                  height: double.infinity,
                  child: TextFormField(
                    controller: controllers['url'],
                    keyboardType: TextInputType.url,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: ValidationBuilder().url('This is not a valid URL address').build(),
                    onChanged: (text) {
                      setState(() {
                        updateQrInput();
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
          );
        }
      default:
        {
          return Text("OOpsie");
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
                              clear();
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
                  SizedBox(
                    height: 10,
                  ),
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
          FancyBottomItem(
              title: Text("Text"),
              icon: Icon(
                Icons.text_fields,
                color: Colors.grey,
              )),
          FancyBottomItem(
              title: Text("WiFi"), icon: Icon(Icons.wifi, color: Colors.grey)),
          FancyBottomItem(
              title: Text("Contact"),
              icon: Icon(Icons.person, color: Colors.grey)),
          FancyBottomItem(
              title: Text("URL"), icon: Icon(Icons.link, color: Colors.grey)),
        ],
        onItemSelected: (i) {
          setState(() => selectedPos = i);
          updateQrInput();
          SystemSound.play(SystemSoundType.click);
        },
        selectedPosition: selectedPos,
        elevation: 0,
        bgColor: backgroundColor,
        //height: MediaQuery.of(context).size.height * 0.07,
      ),
    );
  }
}
