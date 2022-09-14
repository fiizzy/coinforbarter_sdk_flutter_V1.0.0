// ignore_for_file: file_names, empty_catches

import 'dart:io';

import 'package:coinforbarter_sdk/src/Exceptions/minimum_payment.dart';
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
      if (postDataStatusCode == 201) {
        debugPrint('Payment Details successfully fetched from the API!');
        paymentID = postDataResponse['data']['payment']['id'];
        isLoading.value = false;
      } else if (postDataStatusCode == 409) {
        //check what kind of error it is from the error message in the body
        if (postDataResponse["message"]
            .contains("Charge must be grater than equivalent of")) {
          throw MinimumPaymentException(postDataResponse["message"]);
        }
        return Get.snackbar(
            'Request Conflict', "There was a conflict with your request");

        //Throw Minimum Payment exception
      }
    } catch (e, s) {
      if (e is SocketException) {
        debugPrint("runPostData() details controller error $e $s");
        Get.snackbar('Internet Error', "Couldn't get payment details");
      } else {
        debugPrint("runPostData() details controller error $e $s");
        Get.snackbar('Error', "Couldn't get payment details");
      }
      rethrow;
    }
  }

  //Get payment Details via ID
  Future getPaymentDetails(paymentID) async {
    try {
      isLoading.value = true;
      paymentDetails = await c4bservices.getPaymentDetails(paymentID);
      // getPaymentDetailsStatusCode = paymentDetails.statusCode;
      isLoading.value = false;
      debugPrint('Payment Details successfully fetched from the API!');
    } catch (e, s) {
      if (e is SocketException) {
        debugPrint("Get payment details controller error $e $s");
        Get.snackbar('Internet Error', "Couldn't get payment details");
      } else {
        debugPrint("Get payment details controller error $e $s");
        Get.snackbar('Error', "Couldn't get payment details");
      }
      rethrow;
    }
  }

  //Get currency Listings
  Future getCurrencyListings() async {
    try {
      isLoading.value = true;
      var listingsMap = await c4bservices.getCurrencyListings();
      currencyListings = listingsMap['data'];
      isLoading.value = false;
      debugPrint('Currencies successfully fetched from the API!');
    } catch (e, s) {
      if (e is SocketException) {
        debugPrint("Get currency details controller error $e $s");
        Get.snackbar('Internet Error', "Couldn't get currency listings");
      } else {
        debugPrint("Get currency details controller error $e $s");
        Get.snackbar('Error', "Couldn't get currency listings");
      }
      rethrow;
    }
  }

  //Cancel Payment
  Future cancelPayment() async {
    try {
      isLoading.value = true;
      await c4bservices.cancelPayments(paymentID);
      isLoading.value = false;
    } catch (e, s) {
      if (e is SocketException) {
        debugPrint("Get currency details controller error $e $s");
        Get.snackbar('Internet Error', "Couldn't get cancel payment");
      } else {
        debugPrint("Get currency details controller error $e $s");
        Get.snackbar('Error', "Couldn't cancel payment");
      }
      isLoading.value = false;
      rethrow;
    }
  }
}
