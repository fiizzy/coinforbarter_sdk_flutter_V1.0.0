import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:coinforbarter_sdk/controllers/globalizer.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:coinforbarter_sdk/utils/route.dart';
import 'package:get/get.dart';

class Services {
  final GlobalizerController _globerlizerController =
      Get.put(GlobalizerController());

  ///This posts the payment config to the server and return a response
  Future postData() async {
    debugPrint('${_globerlizerController.paymentConfig.customerPhoneNumber}');

    dynamic response;
    Map filteredConfig = {
      "txRef": _globerlizerController.paymentConfig.txRef,
      "amount": _globerlizerController.paymentConfig.amount,
      "baseCurrency": _globerlizerController.paymentConfig.baseCurrency,
      "customer": _globerlizerController.paymentConfig.customer,
      "customerFullName": _globerlizerController.paymentConfig.customerFullName,
      // "customerPhoneNumber":
      //     _globerlizerController.paymentConfig.customerPhoneNumber ??
      //         'No Phone Number',
      "meta": {"from": "Flutter SDK Version 1.0.0"}
    };
    try {
      response = await http.post(
        Uri.parse('${Util.END_POINT}/payments/checkout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer ${_globerlizerController.paymentConfig.publicKey}',
        },
        body: jsonEncode(filteredConfig),
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
      } else if (response.body == "null") {
        Get.snackbar('Server', 'API returning null');
        return jsonDecode(response.body);
      } else {}

      debugPrint(response);
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      Get.snackbar('Error', 'Error establishing connection');
    }
  }

  //Get Payment Details Via ID
  Future getPaymentDetails(paymentID) async {
    dynamic response;

    try {
      response = await http.get(
        Uri.parse('${Util.END_POINT}/payments/checkout/$paymentID'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer ${_globerlizerController.paymentConfig.publicKey}',
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
        Uri.parse('${Util.END_POINT}/currencies/'),
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
                'Bearer ${_globerlizerController.paymentConfig.publicKey}',
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
              'Bearer ${_globerlizerController.paymentConfig.publicKey}',
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
        Get.snackbar('Error', 'Something went wrong from the API');
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
              'Bearer ${_globerlizerController.paymentConfig.publicKey}',
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
        Get.snackbar('Error', 'Something went wrong from the API');
      }
      return jsonDecode(response.body);
    } catch (erorr) {
      Get.snackbar('Error', 'Error setCurrency trying');
    }
  }
}
