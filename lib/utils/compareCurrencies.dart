// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_sdk_2/controllers/selectCurrency_controller.dart';
import 'package:flutter_sdk_2/controllers/serviceController.dart';
import 'package:flutter_sdk_2/views/selectCurrency/currencyCard.dart';
import 'package:get/instance_manager.dart';

class CompareCurrencies {
  final SelectCurrencyController _selectCurrencyController = Get.find();
  final ServiceController _serviceController = Get.find();
  List currencies = [];
  List currencyListings = [];
  List<Widget> comapareList = [];

  compareCurrencies() {
    currencies = _selectCurrencyController.currencies;
    currencyListings = _serviceController.currencyListings;

    //Comparing the currencies in order to get the networks, abbrevation and currency name
    for (var currency in currencies) {
      for (Map<String, dynamic> listingCurrency in currencyListings)
        // ignore: curly_braces_in_flow_control_structures
        if (currency == listingCurrency['abbreviation']) {
          comapareList.add(CurrencyCard(
            abbrevation: listingCurrency['abbreviation'],
            networks: listingCurrency['networks'] as List<dynamic>,
            currency: listingCurrency['currency'],
          ));
        } else {
          null;
        }
    }
    return comapareList;
  }
}
