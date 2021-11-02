import 'package:flutter/material.dart';
import 'package:flutter_sdk_2/controllers/selectCurrency_controller.dart';
import 'package:flutter_sdk_2/models/setCurrency.dart';
import 'package:flutter_sdk_2/styles/styles.dart';
import 'package:flutter_sdk_2/utils/compareCurrencies.dart';
import 'package:flutter_sdk_2/views/selectCurrency/productCard.dart';
import 'package:flutter_sdk_2/views/selectCurrency/securedByCoinfForBarter.dart';
import 'package:get/instance_manager.dart';

class SelectCurrency extends StatelessWidget {
  final SelectCurrencyController _selectCurrencyController =
      Get.put(SelectCurrencyController());
  final SetCurrency _setCurrencyModel = SetCurrency();

  @override
  Widget build(BuildContext context) {
    //This gets a List of currencies available for use
    _selectCurrencyController.getCurrencies();

    return Scaffold(
        appBar: AppBar(
            title: Text("Select Currency"),
            backgroundColor: MyStyles.primaryPurple),
        backgroundColor: MyStyles.primaryPurple,
        body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  ProductCard(
                    businessName: _selectCurrencyController.getBusinessName(),
                    paymentDescription:
                        _selectCurrencyController.getDescription(),
                    amount: _selectCurrencyController.getBaseAmount(),
                    baseCurrrency: _selectCurrencyController.getBaseCurrency(),
                  ),
                  MyStyles.verticalSpaceZero,
                  const SecuredByCoinForBarter(),
                  MyStyles.verticalSpaceOne,
                  Text(
                    "Select Currency",
                    style: MyStyles.headerOneW,
                    textAlign: TextAlign.left,
                  ),
                  MyStyles.verticalSpaceOne,
                  Column(children: CompareCurrencies().compareCurrencies())
                ],
              ),
            ],
          ),
        ));
  }
}
