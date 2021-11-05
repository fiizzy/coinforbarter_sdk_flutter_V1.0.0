// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'dart:async';

class PaymentPreviewController extends GetxController {}

class CountDownTimer extends GetxController {
  Rx<int> secCounter = 60.obs;
  Rx<int> minCounter = 30.obs;
  Rx<int> hrCounter = 1.obs;
  late Timer _timer;

//Seconds count down
  void secondsTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secCounter.value > 0) {
        secCounter.value--;
        if (secCounter.value == 0 && minCounter.value > 0) {
          minCounter.value--;
          if (secCounter.value == 0 && minCounter.value == 0) {
            secCounter.value = 59;
          }
        }
        if (minCounter.value == 0 && hrCounter.value > 0) {
          minCounter.value = 59;
          secCounter.value = 59;
          hrCounter.value--;
        } else if (secCounter.value == 0 &&
            minCounter.value == 0 &&
            hrCounter.value == 0) {
          _timer.cancel();
        }
      } else {
        // _timer.cancel();
        secCounter.value = 59;
      }
    });
  }

  void initTimers() {
    secondsTimer();
  }
}
