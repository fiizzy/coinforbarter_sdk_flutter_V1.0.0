import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import '../../coinforbarter_sdk.dart';

class Services {
  // final GlobalizerController GlobalizerController =
  //     Ge!t.put(GlobalizerController());

  ///This posts the payment config to the server and return a response
  Future postData() async {
    final ServiceController _serviceController = Get.find();
    // debugPrint('${GlobalizerController.paymentConfig!.customerPhoneNumber}');
    dynamic response;
    Map filteredConfig = {
      "txRef": GlobalizerController.paymentConfig!.txRef,
      "amount": GlobalizerController.paymentConfig!.amount,
      "baseCurrency": GlobalizerController.paymentConfig!.baseCurrency,
      "customer": GlobalizerController.paymentConfig!.customer,
      "customerFullName": GlobalizerController.paymentConfig!.customerFullName,
      // "customerPhoneNumber":
      //     GlobalizerController.paymentConfig!.customerPhoneNumber ??
      //         'No Phone Number',
      "meta": {"from": "Flutter SDK Version 1.0.1"}
    };
    try {
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
        Get.snackbar('Unathorized', 'Check your Public Key and retry');
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        Get.snackbar('404 Error', 'Check the endpoint again');
        return jsonDecode(response.body);
      } else if (response.body == "null") {
        Get.snackbar('Server', 'API returning null');
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }

      // ignore: unused_catch_clause
    } on Exception catch (e) {
      Get.snackbar('Error', 'Error establishing connection');
    }
  }

  //Get Payment Details Via ID
  Future getPaymentDetails(paymentID) async {
    final ServiceController _serviceController = Get.find();

    dynamic response;

    try {
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
        Get.snackbar('Unathorized', 'Check your Public Key and retry');
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        Get.snackbar('404 Error', 'Check the endpoint again');
        return jsonDecode(response.body);
      } else {
        Get.snackbar('Error',
            'Something went wrong from the API getting payment Details');
      }

      return jsonDecode(response.body);
    } catch (erorr) {
      Get.snackbar('Error', 'Error establishing connection');

      return response;
    }
  }

  //Get a list of supported currencies by CoinForBarter
  Future getCurrencyListings() async {
    dynamic response;

    try {
      response = await http.get(
        Uri.parse('https://coinforbarter-app.herokuapp.com/v1/currencies'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      //Handling Status codes Error Via Snackbar
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        Get.snackbar('Unathorized', 'Check your Public Key and retry');
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        Get.snackbar('404 Error', 'Check the endpoint again');
        return jsonDecode(response.body);
      } else {
        Get.snackbar(
            'Error', 'Something went wrong from the API: CurrencyListing');
      }

      return jsonDecode(response.body);
    } catch (erorr) {
      Get.snackbar('Error', 'Error establishing connection');
      return response;
    }
  }

  //Set currency inorder to get the fees especially.
  Future setCurrency(paymentID, selectedCurrency, network, toJsonMap) async {
    dynamic response;
    try {
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
        Get.snackbar('Unathorized', 'Check your Public Key and retry');
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        Get.snackbar('404 Error', 'Check the endpoint again');
        return jsonDecode(response.body);
      } else {
        Get.snackbar('Error', 'Something went wrong from the API');
      }

      return jsonDecode(response.body);
    } catch (erorr) {
      Get.snackbar('Error', 'Error setCurrency trying');
      return response;
    }
  }

  //Lock currency inorder to get the fees especially.
  Future lockCurrency(paymentID) async {
    dynamic response;
    try {
      response = await http.patch(
        Uri.parse(
            '${Util.END_POINT}/payments/checkout/$paymentID/currency/lock'),
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
        debugPrint("This is the lock currency response: ${response.body}");

        Get.snackbar(
            'Error', 'Something went wrong from the API locking currency');
        return jsonDecode(response.body);
      }
      // print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } catch (erorr) {
      Get.snackbar('Error', 'Error setCurrency trying');
      return response;
    }
  }

  //Lock currency inorder to get the fees especially.
  Future cancelPayments(paymentID) async {
    dynamic response;
    try {
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
        Get.snackbar('Error', 'Something went wrong from the API Cancelling');
        return jsonDecode(response.body);
      }
      debugPrint('Internal Server error : ${response.body}');
      return jsonDecode(response.body);
    } catch (erorr) {
      Get.snackbar('Error', 'Can not cancel payment');
    }
  }
}
