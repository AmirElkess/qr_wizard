import 'package:flutter/services.dart';

Future<void> openWifiSettings() async {
  MethodChannel _methodChannel = MethodChannel('main/wifi');
  print ("Calling native fn");
  await _methodChannel.invokeMethod("openWifiSettings");
  print ("native fn called");
}