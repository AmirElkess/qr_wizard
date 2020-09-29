import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/database/qrDataTypes.dart';
import 'package:qr_wizard/res/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_wizard/res/button.dart';
import 'package:vcard_parser/vcard_parser.dart';


class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Entry> entriesList;
  Widget mainWidget;

  Icon findIcon(entry) {
    if (entry.dataType == QrDataTypes.CONTACT.index){
      return Icon(Icons.contact_phone);
    } else if (entry.dataType == QrDataTypes.URL.index){
      return Icon(Icons.link);
    } else {
      return Icon(Icons.text_fields);
    }
  }

  Widget findEntryBody(entry) {
    if (entry.dataType == QrDataTypes.CONTACT.index){
      Map<String, Object> vCardMap = VcardParser(entry.qrString ).parse();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("${vCardMap['FN']}", style: TextStyle(fontWeight: FontWeight.bold),),
          Text("Contact Card", style: TextStyle(fontSize: 12),)
        ],
      );


    } else if (entry.dataType == QrDataTypes.URL.index) {
      return GestureDetector(
        onTap: () async {
          await launch(entry.qrString);
        },
        child: Text(
          entry.qrString,
          style: TextStyle(
              color: Colors.blue,
              decoration:
              TextDecoration.underline),
        ),
      );
    } else {
      return Text(entry.qrString);
    }
  }



  void initiateView(entriesList) async {
    setState(() {
      mainWidget = Align(
          heightFactor: 7,
          child: Text(
            "Loading History",
            style: TextStyle(color: Colors.grey),
          ));
      print('loading screen');
    });
    entriesList = await entries();
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
        print('widgets loaded');
        mainWidget = ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: entriesList.length,
            itemBuilder: (BuildContext context, int index) {
              Icon entryIcon = findIcon(entriesList[index]);

              return Dismissible(
                key: Key(index.toString()),
                onDismissed: (direction) {
                  setState(() {
                    deleteEntry(entriesList[index].id);
                    entriesList.removeAt(index);
                    if(entriesList.length == 0) {
                      mainWidget = Align(
                          heightFactor: 7,
                          child: Text(
                            "History is Empty",
                            style: TextStyle(color: Colors.grey),
                          )); //used to set main screen after all history entries are dismissed
                    }
                  });
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
                                      style: TextStyle( color: Colors.grey, fontSize: 10)),
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
                      Expanded(
                        flex: 1,
                        child: SoftButton(
                          isClickable: true,
                          radius: 9,
                          height: double.infinity,
                          child: Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.pushNamed(context, '/details',
                                arguments: entriesList[index]);
                          },
                        ),
                      ),
                    ],
                  ),
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
