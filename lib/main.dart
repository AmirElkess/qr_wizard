import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_wizard/database/Entry.dart';
import 'package:qr_wizard/pages/Details.dart';
import 'package:qr_wizard/pages/contactDetails.dart';
import 'package:qr_wizard/pages/history.dart';
import 'package:qr_wizard/pages/licenses.dart';
import 'package:qr_wizard/pages/privacy_policy.dart';
import 'package:qr_wizard/pages/qr_view.dart';
import 'pages/home.dart';
import 'pages/create.dart';
import 'pages/read.dart';
import 'pages/about.dart';
import 'package:flutter/services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    builder: (context, child) {
      return ScrollConfiguration(
        behavior: GlowlessScroll(),
        child: child,
      );
    },

      // ignore: missing_return
      onGenerateRoute: (RouteSettings settings){
        switch(settings.name) {
          case '/': return CupertinoPageRoute(builder: (_) => Home(), settings: settings);
          case '/create': return CupertinoPageRoute(builder: (_) => Create(), settings: settings);
          case '/read': return CupertinoPageRoute(builder: (_) => Read(), settings: settings);
          case '/about': return CupertinoPageRoute(builder: (_) => About(), settings: settings);
          case '/privacy_policy': return CupertinoPageRoute(builder: (_) => PrivacyPolicy(), settings: settings);
          case '/history': return CupertinoPageRoute(builder: (_) => History(), settings: settings);
          case '/details': return CupertinoPageRoute(builder: (_) => Details(), settings: settings);
          case '/licenses': return CupertinoPageRoute(builder: (_)=> Licenses(), settings: settings);
          case '/contact_details': return CupertinoPageRoute(builder: (_) => ContactDetails(), settings: settings);
          case '/qr_view': return MaterialPageRoute(builder: (_) => QrViewer(), settings: settings);
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


//Scroll behaviour
class GlowlessScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}