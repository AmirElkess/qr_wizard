import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:qr_wizard/res/licenses.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:qr_wizard/res/button.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Entry> entriesList;
  Widget mainWidget;

  void initiateView(entriesList) async {
    setState(() {
      mainWidget = Text("Loading QR scan history");
      print('loading screen');
    });
    entriesList = await entries();
    if (entriesList.length == 0) {
      setState(() {
        mainWidget = Text("History is empty");
        print('Empty history');
      });
    } else {
      setState(() {
        print('widgets loaded');
        mainWidget = ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: entriesList.length,
            itemBuilder: (BuildContext context, int index) {
              return SoftButton(
                radius: 8,
                height: 100,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entriesList[index].qrString),
                      QrImage(
                        data: entriesList[index].qrString,
                        version: QrVersions.auto,
                        size: 90.0,
                        backgroundColor: backgroundColor,
                      ),
                      GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/details');
                          },
                          child: Icon(Icons.arrow_forward))
                    ],),
                ),
              );
            });
      });
    }
  }

  @override
  void initState() {
    initiateView(entriesList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          title: Text(
            "Scan History",
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
        body: mainWidget,
    );
  }
}
