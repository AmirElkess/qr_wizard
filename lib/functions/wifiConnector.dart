import 'package:flutter/services.dart';

Future<void> connectWifi(ssid, [pwd]) async {
  MethodChannel _methodChannel = MethodChannel('main/wifi');
  print ("Calling native fn");
  dynamic res = await _methodChannel.invokeMethod("connectWifi", {'ssid': ssid, 'pwd': pwd});
  print ("native fn called");

}