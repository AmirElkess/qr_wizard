List<String> parseWifi (String baseString) {
  String ssid;
  String pwd;
  RegExp ssidm = RegExp(r'(?<=S:).+(?=;P)');
  RegExp pwdm = RegExp(r'(?<=;P:).*(?=;;)');
  RegExp typem = RegExp(r'(?<=T:)(WEP|WPA|WPA2\-EAP|nopass)(?=;)');
  String type = typem.firstMatch(baseString).group(0);
  baseString = baseString.replaceAll(new RegExp( r'T:(WEP|WPA|WPA2\-EAP|nopass);'), '');
  baseString = baseString.replaceAll('H:true', '');



  if (type == 'nopass') {
    pwd = '-1';
  } else {
    pwd = pwdm.firstMatch(baseString).group(0).replaceAll('\\:', ':');
  }
  ssid = ssidm.firstMatch(baseString).group(0).replaceAll('\\:', ':');

  return [ssid, pwd];
}