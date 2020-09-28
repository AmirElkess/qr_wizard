import 'package:qr_wizard/database/qrDataTypes.dart';
import 'package:url_launcher/url_launcher.dart';


Future<int> classifyType (qrString) async {
  //classify qr codes based on type (text, url, contact),
  //and return int that corresponds to that type in qrDataType enum.
  if (await canLaunch(qrString)){
    return QrDataTypes.URL.index;
  } else if (qrString.startsWith('BEGIN:VCARD')) {
    return QrDataTypes.CONTACT.index;
  } else {
    return QrDataTypes.TEXT.index;
  }
}