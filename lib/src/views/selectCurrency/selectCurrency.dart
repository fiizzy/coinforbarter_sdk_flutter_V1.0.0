// ignore_for_file: file_names
import 'package:coinforbarter_sdk/coinforbarter_sdk.dart';
import 'package:flutter/material.dart';

class SelectCurrency extends StatelessWidget {
  SelectCurrency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SelectCurrencyController _selectCurrencyController =
        Get.put(SelectCurrencyController());
    //This gets a List of currencies available for use
    _selectCurrencyController.getCurrencies();

    return Scaffold(
        appBar: AppBar(
            title: const Text("Select Currency"),
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
