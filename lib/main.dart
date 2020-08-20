import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/create.dart';
import 'pages/read.dart';
import 'pages/about.dart';
import 'package:flutter/services.dart';
import 'pages/settings.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/create': (context) => Create(),
        '/read': (context) => Read(),
        '/about': (context) => About(),
        '/settings': (context) => Settings(),
      }
  ));
}