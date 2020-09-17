import 'package:flutter/material.dart';
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

  @override
  void initState(){
    testRetrieve();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Text("Scan History", style: TextStyle(color: Colors.black),),
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
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(25),
            child: Text("HISTORY_PAGE", textAlign: TextAlign.justify,)),
      ),
    );
  }
}
