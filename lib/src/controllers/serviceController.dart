// ignore_for_file: file_names, empty_catches

import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/src/services/services.dart';
import 'package:get/get.dart';

class ServiceController extends GetxController {
  Rx<bool> isLoading = false.obs;
  dynamic postDataResponse;
  dynamic paymentDetails;
  String? paymentID;
  List currencyListings = [];
  List cancelPaymentResponse = [];
  final Services c4bservices = Services();
  int? postDataStatusCode;
  int? getPaymentDetailsStatusCode;

  //Initalize payment
  Future runPostData(config) async {
    try {
      isLoading.value = true;
      postDataResponse = await c4bservices.postData();
      // postDataStatusCode = postDataResponse.statusCode;
      if (postDataStatusCode == 201) {
        paymentID = postDataResponse['data']['payment']['id'];
        isLoading.value = false;
      }
    } catch (error) {
      Get.snackbar('Error!', '$error');
      debugPrint('runPostData() in serviceController throw error :$error');
    }
  }

  //Get payment Details via ID
  Future getPaymentDetails(paymentID) async {
    try {
      isLoading.value = true;
      paymentDetails = await c4bservices.getPaymentDetails(paymentID);
      // getPaymentDetailsStatusCode = paymentDetails.statusCode;
      isLoading.value = false;
    } catch (erorr) {
      Get.snackbar('Error!', '$erorr');
    }
  }

  //Get currency Listings
  Future getCurrencyListings() async {
    try {
      isLoading.value = true;
      var listingsMap = await c4bservices.getCurrencyListings();
      currencyListings = listingsMap['data'];
      isLoading.value = false;
      debugPrint('Currenclisting sucess');
    } catch (erorr) {
      // Get.snackbar('Error', "Couldn't get currency listings");
    }
  }

  //Cancel Payment
  Future cancelPayment() async {
    try {
      isLoading.value = true;
      Map cancelPayments = await c4bservices.cancelPayments(paymentID);
      // currencyListings = listingsMap['data'];
      isLoading.value = false;
    } catch (erorr) {}
  }
}
