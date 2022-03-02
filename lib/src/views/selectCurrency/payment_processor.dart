import 'package:coinforbarter_sdk/coinforbarter.dart';
import 'package:flutter/material.dart';

void coinForBarterInit(PaymentConfig paymentConfig) async {
  final ServiceController _serviceController = Get.find();
  final GlobalizerController _globerlizerController = Get.find();
  final SelectCurrencyController _selectCurrencyController = Get.find();
  //making the paymentconfig globally accessible
  _globerlizerController.globalizerMethod(paymentConfig);
  await _serviceController.getCurrencyListings();

  await _serviceController.runPostData(_globerlizerController.paymentConfig);
  debugPrint(
      "The statusCode after posting payment config is: ${_serviceController.postDataStatusCode}");

  if (_serviceController.postDataStatusCode == 401) {
    Get.snackbar('Unathourized', 'Check your API key');
    _serviceController.isLoading.value = false;
    throw Exception(
        ["A value in your PaymentConfig() object is not correctly set"]);
  } else if (_serviceController.postDataStatusCode == 400) {
    Get.snackbar('Bad Request', 'Check your Payment Config object');

    _serviceController.isLoading.value = false;
    // throw Exception(
    //     ["A value in your PaymentConfig() object is not correctly set"]);
  } else {
    await _serviceController.getPaymentDetails(_serviceController.paymentID);
    CoinForBarterButton.businessName =
        _selectCurrencyController.getBusinessName();
    Get.to(() => SelectCurrency());
    _serviceController.isLoading.value = false;
  }
}
