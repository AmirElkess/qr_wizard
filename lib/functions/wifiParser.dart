List<String> parseWifi(String baseString) {
  String ssid = '';
  String pwd = '-1';
  RegExp ssidm = RegExp(r'(?<=S:).+(?=;P)');
  RegExp pwdm = RegExp(r'(?<=;P:).*(?=(;;)|;H:)');
  RegExp typem = RegExp(r'T:(WEP|WPA|WPA2\-EAP|nopass);');
  baseString = baseString.replaceAll(typem, '');

  if (ssidm.hasMatch(baseString)) {
    ssid = ssidm.firstMatch(baseString).group(0).replaceAll(r'\\', r'\').replaceAll(r'\:', ':').replaceAll(r'\;', ';');
  }
  if (pwdm.hasMatch(baseString)) {
    pwd = pwdm.firstMatch(baseString).group(0).replaceAll(r'\\', r'\').replaceAll(r'\:', ':').replaceAll(r'\;', ';');
    if (pwd.isEmpty) {
      pwd = '-1';
    }
  }

  return [ssid, pwd];
}
