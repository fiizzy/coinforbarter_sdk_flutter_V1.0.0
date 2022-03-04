import 'package:coinforbarter_sdk/coinforbarter_sdk.dart';
import 'package:coinforbarter_sdk/src/controllers/services_extension.dart';
import 'package:flutter/material.dart';

Future<void> coinForBarterInit(PaymentConfig paymentConfig) async {
  GlobalizerController.globalizerMethod(paymentConfig);
  final ServiceController _serviceController = Get.put(ServiceController());
  Get.put(LockCurrencyController());
  Get.put(SelectCurrencyController());
  Get.put(ServiceExtension());

  ServiceExtension _serviceExtension = Get.find();

  final SelectCurrencyController _selectCurrencyController = Get.find();
  //making the paymentconfig globally accessible
  // GlobalizerController.globalizerMethod(paymentConfig);
  await _serviceController.getCurrencyListings();

  await _serviceController.runPostData(GlobalizerController.paymentConfig);
  debugPrint(
      "The statusCode after posting payment config is: ${_serviceController.postDataStatusCode}");

  if (_serviceController.postDataStatusCode == 401) {
    Get.snackbar('Unathourized', 'Check your API key');
    _serviceController.isLoading.value = false;
    throw Exception(
        ["A value in your PaymentConfig() object is not correctly set"]);
  } else if (_serviceController.postDataStatusCode == 400) {
    Get.snackbar('Bad Request', 'Check your Payment Config object');

    _serviceExtension.isLoading.value = false;
    // throw Exception(
    //     ["A value in your PaymentConfig() object is not correctly set"]);
  } else {
    await _serviceController.getPaymentDetails(_serviceController.paymentID);
    CoinForBarterButton.businessName =
        _selectCurrencyController.getBusinessName();
    Get.to(() => SelectCurrency());
    _serviceExtension.isLoading.value = false;
  }
}
