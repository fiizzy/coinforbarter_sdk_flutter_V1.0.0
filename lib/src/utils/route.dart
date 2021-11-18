// ignore_for_file: non_constant_identifier_names

class Util {
  static String qrCode =
      'https://www.qr-code-generator.com/wp-content/themes/qr/new_structure/assets/media/images/api_page/qrcodes/bw/Api_page_-_QR-Code-Generator_com-1.png?';
  static String END_POINT = 'https://api.coinforbarter.com/v1';

  static String PUBLIC_KEY =
      "C4B_TEST-ZDOwlonfkWfjeI4UNGuRaUBhUqZID1630870497617";
}

class QRcode {
  String getQRcode(
    currency,
    address,
    amount,
    currencyNetwork,
  ) {
    return 'https://chart.googleapis.com/chart?chs=250x250&cht=qr&chl=$currency:$address&amount=$amount&network=$currencyNetwork&message=coinforbarter-payment';
  }
}
