import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/database/qrDataTypes.dart';
import 'package:qr_wizard/functions/wifiParser.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:simple_vcard_parser/simple_vcard_parser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_wizard/res/button.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Entry> entriesList;

  Widget mainWidget = Align(
      heightFactor: 7,
      child: Text(
        "Loading History",
        style: TextStyle(color: Colors.grey),
      ));


  Icon findIcon(entry) {
    if (entry.dataType == QrDataTypes.CONTACT.index) {
      return Icon(Icons.contact_phone);
    } else if (entry.dataType == QrDataTypes.URL.index) {
      return Icon(Icons.link);
    } else if (entry.dataType == QrDataTypes.WIFI.index) {
      return Icon(Icons.wifi);
    } else {
      return Icon(Icons.text_fields);
    }
  }

  Widget findEntryBody(entry) {
    if (entry.dataType == QrDataTypes.CONTACT.index) {
      VCard vCard = VCard(entry.qrString);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "${vCard.name.reversed.join(' ')}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Contact Card",
            style: TextStyle(fontSize: 12),
          )
        ],
      );
    } else if (entry.dataType == QrDataTypes.WIFI.index) {
      if (parseWifi(entry.qrString)[1] == '-1') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("SSID: " + parseWifi(entry.qrString)[0]),
            Text(
              'PASSWORD: [Password-less Wifi]',
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("SSID: " + parseWifi(entry.qrString)[0]),
            Text(
              "Password: " + parseWifi(entry.qrString)[1],
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        );
      }
    } else {
      return Linkify(
        text: entry.qrString,
        onOpen: (link) => {launch(link.url)},
      );
    }
  }

  Widget findAction(entry) {
    return Expanded(
      flex: 1,
      child: SoftButton(
        isClickable: true,
        radius: 9,
        height: double.infinity,
        child: Icon(Icons.arrow_forward),
        onTap: () async{

          if (entry.dataType == QrDataTypes.CONTACT.index) {
            await Navigator.pushNamed(context, '/contact_details', arguments: entry);
            viewBuilder(entriesList);
          } else if (entry.dataType == QrDataTypes.URL.index || entry.dataType == QrDataTypes.TEXT.index) {
            await Navigator.pushNamed(context, '/details', arguments: entry);
            viewBuilder(entriesList);
          } else if (entry.dataType == QrDataTypes.WIFI.index) {
            await Navigator.pushNamed(context, '/wifi_details', arguments: entry);
            viewBuilder(entriesList);
          }
        },
      ),
    );
  }

  void viewBuilder(entriesList) async {
    List<Entry> entriesListCache = new List<Entry>.from(entriesList);
    if (entriesList.length == 0) {
      setState(() {
        mainWidget = Align(
            heightFactor: 7,
            child: Text(
              "History is Empty",
              style: TextStyle(color: Colors.grey),
            ));
        print('Empty history');
      });
    } else {
      setState(() {
        mainWidget = ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: entriesList.length,

            itemBuilder: (BuildContext context, int index) {
              Icon entryIcon = findIcon(entriesList[index]);
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    deleteEntry(entriesList[index].id);
                    entriesList.removeAt(index);
                    if (entriesList.length == 0) {
                      mainWidget = Align(
                          heightFactor: 7,
                          child: Text(
                            "History is Empty",
                            style: TextStyle(color: Colors.grey),
                          )); //used to set main screen after all history entries are dismissed
                    }
                  });
                  print(entriesList);
                },
                child: SoftButton(
                  radius: 8,
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: entryIcon,
                      ),
                      Expanded(
                        flex: 7,
                        child: SoftButton(
                          height: double.infinity,
                          radius: 8,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      "Scanned on ${DateTime.parse(entriesList[index].timestamp).toString().substring(0, 11)}",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10)),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SingleChildScrollView(
                                    child: findEntryBody(entriesList[index]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      findAction(entriesList[index]),
                    ],
                  ),
                ),
              );
            });
      });
    }
  }


  void initiateView() async {
    entriesList = await entries();
    viewBuilder(entriesList);
  }

  @override
  void initState() {
    super.initState();
    initiateView();
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
