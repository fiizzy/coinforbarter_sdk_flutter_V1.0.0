import 'package:coinforbarter_sdk/src/models/config.dart';
import 'package:coinforbarter_sdk/src/utils/checkout_api_key.dart';
import 'package:flutter/material.dart';

///This class contains a method that makes non-service variables global
//well, I could have easily made this a static class, it would have still held the state globally.
class GlobalizerController {
  static PaymentConfig? paymentConfig;
  static bool isTest = false;

  static globalizerMethod(param) {
    paymentConfig = param;
    isTest = isAPIkeyTest(paymentConfig!.publicKey);
    debugPrint(
        'Is publicKey a TestKey ? : ${isAPIkeyTest(paymentConfig!.publicKey)}');
  }
}
