import 'package:coinforbarter_sdk/src/models/config.dart';
import 'package:coinforbarter_sdk/src/utils/checkout_api_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

///This class contains a method that makes non-service variables global
//well, I could have easily made this a static class, it would have still held the state globally.
class GlobalizerController extends GetxController {
  late PaymentConfig paymentConfig;
  static bool isTest = false;

  globalizerMethod(param) {
    paymentConfig = param;
    isTest = isAPIkeyTest(paymentConfig.publicKey);
    debugPrint(
        'Is publicKey a TestKey ? : ${isAPIkeyTest(paymentConfig.publicKey)}');
  }
}
