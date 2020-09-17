import 'package:flutter/cupertino.dart';
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
      mainWidget = Align(heightFactor: 7, child: Text("Loading History", style: TextStyle(color: Colors.grey),));
      print('loading screen');
    });
    entriesList = await entries();
    if (entriesList.length == 0) {
      setState(() {
        mainWidget = Align(heightFactor: 7, child: Text("History is Empty", style: TextStyle(color: Colors.grey),));
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(
                      flex: 7,
                      child: SoftButton(
                        height: double.infinity,
                        radius: 8,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(00, 0, 0, 0),
                          child: Column(
                            children: [
                              Text("Scanned on ${DateTime.parse(entriesList[index].timestamp).toString().substring(0, 11)}", style: TextStyle(color: Colors.grey)),
                              Text(entriesList[index].qrString),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SoftButton(
                        isClickable: true,
                        radius: 15,
                        height: double.infinity,
                        child: Icon(Icons.delete, color: Colors.red,),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SoftButton(
                        isClickable: true,
                        radius: 15,
                        height: double.infinity,
                        child: Icon(Icons.arrow_forward),
                        onTap: (){
                          Navigator.pushNamed(context, '/details', arguments: entriesList[index]);
                        },
                      ),
                    ),

                  ],),
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
