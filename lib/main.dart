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
      routes: {
        '/': (context) => Home(),
        '/create': (context) => Create(),
        '/read': (context) => Read(),
        '/about': (context) => About(),
        '/settings': (context) => Settings(),
        '/privacy_policy': (context) => PrivacyPolicy(),
      }
  ));
}