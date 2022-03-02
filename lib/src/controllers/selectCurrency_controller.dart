// ignore_for_file: avoid_print, file_names

import 'package:coinforbarter_sdk/src/controllers/serviceController.dart';
import 'package:get/get.dart';

class SelectCurrencyController extends GetxController {
  ServiceController serviceController = Get.find();
  String? businessName;
  String? paymentDescription;
  String? baseCurrency;
  RxDouble baseAmount = 0.0.obs;
  RxDouble amount = 0.0.obs;
  String? customer;
  String? txRef;
  List currencies = [];
  RxList selectedNetworkArray = [].obs;
  Rx<dynamic> selectedNetwork = ''.obs;
  Rx<bool> isSelected = false.obs;
  String? expiryTime;
  RxString status = ''.obs;

  getBusinessName() {
    try {
      return businessName =
          serviceController.paymentDetails['data']['branding']['businessName'];
    } catch (e) {
      Get.snackbar('Error', 'Error establishing connection $e');
    }
  }

  getDescription() {
    return paymentDescription =
        serviceController.paymentDetails['data']['description'];
  }

  getBaseAmount() {
    return baseAmount.value =
        serviceController.paymentDetails['data']['baseAmount'];
  }

  getBaseCurrency() {
    return baseCurrency =
        serviceController.paymentDetails['data']['baseCurrency'];
  }

  //Get a list of currencies from the payment details
  getCurrencies() {
    currencies = serviceController.paymentDetails['data']['currencies'];
    return currencies;
  }

  //Get the customer: email address
  getCustomer() {
    customer = serviceController.paymentDetails['data']['customer'];
    // print(customer);
    return customer;
  }

  //Get transfer reference
  getTxRef() {
    txRef = serviceController.paymentDetails['data']['txRef'];
    return txRef;
  }

  //This recieves the changes from the drop down menu
  handleDropDownChnages(network, value) {
    selectedNetworkArray.value = network;
    selectedNetwork.value = value;
  }

  //Get converted amount of selected currency
  getAmount() {
    amount.value = serviceController.paymentDetails['data']['amount'];
    return amount;
  }

  //Get expiry of the payment
  getExpiryTime() {
    expiryTime = serviceController.paymentDetails['data']['expiresBy'];
    // print(expiryTime);
    return expiryTime;
  }

  //Get the payment Status
  getStatus() {
    status.value = serviceController.paymentDetails['data']['status'];
    // print(status);
    return status;
  }
}
