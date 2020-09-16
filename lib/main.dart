import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_wizard/pages/privacy_policy.dart';
import 'pages/home.dart';
import 'pages/create.dart';
import 'pages/read.dart';
import 'pages/about.dart';
import 'package:flutter/services.dart';
import 'pages/settings.dart';
import 'package:quick_actions/quick_actions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);



  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // ignore: missing_return
      onGenerateRoute: (RouteSettings settings){
        switch(settings.name) {
          case '/': return CupertinoPageRoute(builder: (_) => Home(), settings: settings);
          case '/create': return CupertinoPageRoute(builder: (_) => Create(), settings: settings);
          case '/read': return CupertinoPageRoute(builder: (_) => Read(), settings: settings);
          case '/about': return CupertinoPageRoute(builder: (_) => About(), settings: settings);
          case '/privacy_policy': return CupertinoPageRoute(builder: (_) => PrivacyPolicy(), settings: settings);
        }
      },
      // routes: {
      //   '/': (context) => Home(),
      //   '/create': (context) => Create(),
      //   '/read': (context) => Read(),
      //   '/about': (context) => About(),
      //   '/settings': (context) => Settings(),
      //   '/privacy_policy': (context) => PrivacyPolicy(),
      // }
  ));
}