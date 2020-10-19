import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simple_vcard_parser/simple_vcard_parser.dart';

class ContactDetails extends StatefulWidget {
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {

  @override
  Widget build(BuildContext context) {
    Entry entry = ModalRoute.of(context).settings.arguments;
    VCard vc = VCard(entry.qrString);

    String getName() {
      String _name = vc.formattedName;
      if (_name.isEmpty) {
        _name = vc.name.reversed.join(' ');
      }
      return _name;
    }

    String getTelephones() {
      List<dynamic> _tels = vc.typedTelephone;
      List<String> _telephones = List<String>();
      for (var tel in _tels){
        _telephones.add(tel[0]);
      }
      return _telephones.join(', ');
    }


    ScreenshotController screenshotController = ScreenshotController();

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          title: Text(
            "Contact",
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
                            flex: 11,
                            child: SoftButton(
                              radius: 12,
                              height: double.infinity,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(3),
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
                            flex: 2,
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
                          ),

                        ]),
                      ),
                      Expanded(
                        flex: 4,
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
                                  child: FittedBox(child: Text("Scanned on ${DateTime.parse(entry.timestamp).toString().substring(0, 10)}, at ${DateTime.parse(entry.timestamp).toString().substring(11, 16)}.", style: TextStyle(color: Colors.grey),)),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: SingleChildScrollView(
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(color: Colors.black, wordSpacing: 1.5, height: 1.4),
                                        children: <TextSpan>[
                                          TextSpan(text: 'Name: '),
                                          TextSpan(text: getName(), style: TextStyle(color: Colors.black54)),
                                          TextSpan(text: '\n'),

                                          TextSpan(text: 'Organisation: '),
                                          TextSpan(text: vc.organisation, style: TextStyle(color: Colors.black54)),
                                          TextSpan(text: '\n'),

                                          TextSpan(text: 'Title: '),
                                          TextSpan(text: vc.title, style: TextStyle(color: Colors.black54)),
                                          TextSpan(text: '\n'),

                                          TextSpan(text: 'Telephone: '),
                                          TextSpan(text: getTelephones(), style: TextStyle(color: Colors.black54)),
                                          TextSpan(text: '\n'),

                                          TextSpan(text: 'Email: '),
                                          TextSpan(text: vc.email, style: TextStyle(color: Colors.black54)),
                                          TextSpan(text: '\n'),




                                        ]
                                      ),
                                    ),
                                  )
                                )
                              ],
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
        ),
    );
  }
}
