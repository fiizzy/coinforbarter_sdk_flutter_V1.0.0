import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import '../../coinforbarter_sdk.dart';

class Services {
  ///This posts the payment config to the server and return a response
  Future postData() async {
    try {
      final ServiceController _serviceController = Get.find();
      dynamic response;
      Map filteredConfig = {
        "txRef": GlobalizerController.paymentConfig!.txRef,
        "amount": GlobalizerController.paymentConfig!.amount,
        "baseCurrency": GlobalizerController.paymentConfig!.baseCurrency,
        "customer": GlobalizerController.paymentConfig!.customer,
        "customerFullName":
            GlobalizerController.paymentConfig!.customerFullName,
        "meta": {"from": "Flutter SDK"}
      };

      response = await http.post(
        Uri.parse('${Util.END_POINT}/payments/checkout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer ${GlobalizerController.paymentConfig!.publicKey}',
        },
        body: jsonEncode(filteredConfig),
      );
      //set the statusCode inside of the controller.
      _serviceController.postDataStatusCode = response.statusCode;

      //Handling Status codes Error Via Snackbar
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        //Bad Public key
        debugPrint("Your public key is not authorized");
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        debugPrint("postData() status: 404");

        return jsonDecode(response.body);
      } else if (response.body == "null") {
        debugPrint("postData() returning null from API");

        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } on Exception catch (e) {
      rethrow;
    }
  }

  //Get Payment Details Via ID
  Future getPaymentDetails(paymentID) async {
    try {
      final ServiceController _serviceController = Get.find();

      dynamic response;

      response = await http.get(
        Uri.parse('${Util.END_POINT}/payments/checkout/$paymentID'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer ${GlobalizerController.paymentConfig!.publicKey}',
        },
      );
      //set the statusCode inside of the controller.
      _serviceController.getPaymentDetailsStatusCode = response.statusCode;

      //Handling Status codes Error Via Snackbar
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        //Bad Public key
        debugPrint("Your public key is not authorized");
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        debugPrint("getPaymentDetails() service status: 404");

        return jsonDecode(response.body);
      } else if (response.body == "null") {
        debugPrint("getPaymentDetails() returning null from API");

        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } on Exception catch (e) {
      rethrow;
    }
  }

  //Get a list of supported currencies by CoinForBarter
  Future getCurrencyListings() async {
    try {
      dynamic response;

      response = await http.get(
        Uri.parse('${Util.END_POINT}/currencies'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      //Handling Status codes Error Via Snackbar
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        //Bad Public key
        debugPrint("Your public key is not authorized");
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        debugPrint("getCurrencyListings() service status: 404");

        return jsonDecode(response.body);
      } else if (response.body == "null") {
        debugPrint("getCurrencyListings() returning null from API");

        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  //Set currency inorder to get the fees especially.
  Future setCurrency(paymentID, selectedCurrency, network, toJsonMap) async {
    try {
      dynamic response;
      response = await http.patch(
          Uri.parse(
              '${Util.END_POINT}/payments/checkout/$paymentID/currency/set/$selectedCurrency/$network'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'Bearer ${GlobalizerController.paymentConfig!.publicKey}',
          },
          body: jsonEncode(toJsonMap));
      //Handling Status codes Error Via Snackbar
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        //Bad Public key
        debugPrint("Your public key is not authorized");
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        debugPrint("setCurrency() service status: 404");

        return jsonDecode(response.body);
      } else if (response.body == "null") {
        debugPrint("setCurrency() returning null from API");
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } on Exception catch (e) {
      rethrow;
    }
  }

  //Lock currency inorder to get the fees especially.
  Future lockCurrency(paymentID) async {
    try {
      final LockCurrencyController _lockCurrencyController = Get.find();

      dynamic response;

      response = await http.patch(
        Uri.parse(
            '${Util.END_POINT}/payments/checkout/$paymentID/currency/lock'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer ${GlobalizerController.paymentConfig!.publicKey}',
        },
      );
      //SET THE LOCK RESPONSE STATUSCODE IN ITS CONTROLLERS
      _lockCurrencyController.statusCode = response.statusCode;
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        Get.snackbar('Unathorized', 'Check your Public Key and retry');
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        Get.snackbar('404 Error', 'Check the endpoint again');
        return jsonDecode(response.body);
      } else {
        debugPrint("This is the lock currency response: ${response.body}");

        Get.snackbar(
            'Error', 'Something went wrong from the API locking currency');
        debugPrint(
            'Something went wrong from the API locking currency and the status code is ${response.statusCode} and body :${response.body} ');

        return jsonDecode(response.body);
      }
    } on Exception catch (e) {
      rethrow;
    }
  }

  //Lock currency inorder to get the fees especially.
  Future cancelPayments(paymentID) async {
    try {
      dynamic response;
      response = await http.patch(
        Uri.parse('${Util.END_POINT}/payments/checkout/$paymentID/cancel'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer ${GlobalizerController.paymentConfig!.publicKey}',
        },
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        Get.snackbar('Unathorized', 'Check your Public Key and retry');
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        Get.snackbar('404 Error', 'Check the endpoint again');
        return jsonDecode(response.body);
      } else {
        Get.snackbar('Error', 'Something went wrong from the API Cancelling ');
        debugPrint(
            'Cant cancel payment from server : ${response.statusCode} ${response.body}');

        return jsonDecode(response.body);
      }
    } on Exception catch (e) {
      rethrow;
    }
  }
}
