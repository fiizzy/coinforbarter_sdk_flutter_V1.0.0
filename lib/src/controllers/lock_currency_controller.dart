import 'dart:io';

import 'package:coinforbarter_sdk/src/controllers/serviceController.dart';
import 'package:coinforbarter_sdk/src/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LockCurrencyController extends GetxController {
  final ServiceController _serviceController = Get.find();
  Map lockCurrencyresponse = {}.obs;
  Rx<bool> isLoading = false.obs;
  int? statusCode;

//Call lock currency service

  Future<Map> lockCurrencyService() async {
    try {
      isLoading.value = true;
      lockCurrencyresponse =
          await Services().lockCurrency(_serviceController.paymentID);
      isLoading.value = false;
      return lockCurrencyresponse;
    } on Exception catch (e, s) {
      if (e is SocketException) {
        debugPrint("Get payment details controller error $e, $s");
        Get.snackbar('Internet Error', "Couldn't get Set Currency");
      } else {
        debugPrint("Get payment details controller error $e, $s");
        Get.snackbar('Error', "Couldn't get set currency");
      }
      isLoading.value = false;

      rethrow;
    }
  }
}
