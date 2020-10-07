import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/database/qrDataTypes.dart';
import 'package:qr_wizard/functions/wifiParser.dart';
import 'package:simple_vcard_parser/simple_vcard_parser.dart';
import 'package:url_launcher/url_launcher.dart';

import 'button.dart';

class HistoryEntryWidget extends StatefulWidget {
  @override
  _HistoryEntryWidgetState createState() => _HistoryEntryWidgetState();

  Widget icon;
  Entry entry;
  dynamic action;

  HistoryEntryWidget ({this.icon, this.entry, this.action}) {

}
}

class _HistoryEntryWidgetState extends State<HistoryEntryWidget> {

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

  @override
  Widget build(BuildContext context) {
    return SoftButton(
      radius: 8,
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: widget.icon,
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
                          "Scanned on ${DateTime.parse(widget.entry.timestamp).toString().substring(0, 11)}",
                          style: TextStyle(
                              color: Colors.grey, fontSize: 10)),
                    ),
                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: findEntryBody(widget.entry),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          widget.action(),
        ],
      ),
    );
  }
}
