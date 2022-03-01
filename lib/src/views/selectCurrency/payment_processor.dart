import 'package:coinforbarter_sdk/coinforbarter.dart';
import 'package:flutter/material.dart';

void processPaymentRequest(PaymentConfig paymentConfig) async {
  final ServiceController _serviceController = Get.find();
  final GlobalizerController _globerlizerController = Get.find();
  final SelectCurrencyController _selectCurrencyController = Get.find();
  //making the paymentconfig globally accessible
  _globerlizerController.globalizerMethod(paymentConfig);
  await _serviceController.getCurrencyListings();
  debugPrint(
      "This is the user's payment config: ${_globerlizerController.paymentConfig.amount}");
  await _serviceController.runPostData(_globerlizerController.paymentConfig);

  if (_serviceController.postDataResponse['message'] == 'Unauthorized') {
    Get.snackbar('Unathourized', 'Check your API key');
    _serviceController.isLoading.value = false;
  } else {
    await _serviceController.getPaymentDetails(_serviceController.paymentID);
    CoinForBarterButton.businessName =
        _selectCurrencyController.getBusinessName();
    Get.to(() => SelectCurrency());
  }
}
