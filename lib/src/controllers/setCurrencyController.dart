// ignore_for_file: prefer_final_fields, file_names

import 'package:coinforbarter_sdk/src/controllers/selectCurrency_controller.dart';
import 'package:coinforbarter_sdk/src/models/setCurrency.dart';
import 'package:coinforbarter_sdk/src/services/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
    } catch (erorr) {}
  }
}
