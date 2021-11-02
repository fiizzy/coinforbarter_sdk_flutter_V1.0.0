import 'package:flutter_sdk_2/models/config.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class GlobalizerController extends GetxController {
  late PaymentConfig paymentConfig;

  globalizerMethod(param) {
    paymentConfig = param;
  }
}

doSomething() {}
