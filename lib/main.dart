import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/create.dart';
import 'pages/read.dart';
import 'pages/about.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/create': (context) => Create(),
      '/read': (context) => Read(),
      '/about': (context) => About(),
    }
  ));
}
