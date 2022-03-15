// ignore_for_file: prefer_final_fields, file_names

import 'dart:io';

import 'package:coinforbarter_sdk/src/controllers/selectCurrency_controller.dart';
import 'package:coinforbarter_sdk/src/models/setCurrency.dart';
import 'package:coinforbarter_sdk/src/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SetCurrencyController extends GetxController {
  final Rx<bool> isLoading = false.obs;
  SetCurrency _setCurrencyModel = SetCurrency();
  final SelectCurrencyController _selectCurrencyController = Get.find();
  Map? toJsonTestMap;
  Map? setCurrencyResponse;

  initTojson() {
    _setCurrencyModel.amount = _selectCurrencyController.baseAmount.value;
    _setCurrencyModel.txRef = _selectCurrencyController.getTxRef();
    _setCurrencyModel.baseCurrency = _selectCurrencyController.baseCurrency;
    _setCurrencyModel.customer = _selectCurrencyController.getCustomer();
    toJsonTestMap = _setCurrencyModel.toJson();
    // return toJsonTestMap;
  }

  Future setCurrencyFromController(
      paymentID, selectedCurrency, network, toJsonMap) async {
    try {
      isLoading.value = true;
      setCurrencyResponse = await Services()
          .setCurrency(paymentID, selectedCurrency, network, toJsonMap);
      isLoading.value = false;
      return setCurrencyResponse;
      // ignore: empty_catches
    } catch (e, s) {
      if (e is SocketException) {
        debugPrint("Get payment details controller error $e $s");
        Get.snackbar('Internet Error', "Couldn't get Set Currency");
      } else {
        debugPrint("Get payment details controller error $e $s");
        Get.snackbar('Error', "Couldn't get set currency");
      }
      isLoading.value = false;
      rethrow;
    }
  }
}
