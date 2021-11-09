// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/src/controllers/lock_currency_controller.dart';
import 'package:coinforbarter_sdk/src/controllers/selectCurrency_controller.dart';
import 'package:coinforbarter_sdk/src/controllers/serviceController.dart';
import 'package:coinforbarter_sdk/src/styles/styles.dart';
import 'package:coinforbarter_sdk/src/views/paymentPreview/paymentPreview.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

Future<void> infoDialog(BuildContext context, Map setCurrencyResponse) async {
  final SelectCurrencyController _selectCurrencyController = Get.find();
  final ServiceController _serviceController = Get.find();
  final LockCurrencyController _lockCurrencyController =
      Get.put(LockCurrencyController());
  String _selectedCurrency = _selectCurrencyController.selectedNetworkArray[
      _selectCurrencyController.selectedNetworkArray.length - 1];
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return Obx(() => AlertDialog(
            title: const Text(
              'Confirm Cryptocurrency',
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  //todo: extract into strings.dart

                  Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      '${setCurrencyResponse['data']['amount']} $_selectedCurrency\n'),
                  Text('Network',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${_selectCurrencyController.selectedNetwork}\n'),
                  Text('Transaction Fee',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      '${setCurrencyResponse['data']['fee']} $_selectedCurrency'),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Text('Close')),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: _lockCurrencyController.isLoading.value ||
                            _serviceController.isLoading.value
                        ? CircularProgressIndicator(
                            color: MyStyles.primaryPurple,
                            strokeWidth: 1,
                          )
                        : InkWell(
                            child: Text('Proceed'),
                            onTap: () async {
                              await _lockCurrencyController
                                  .lockCurrencyService();

                              //Update payment
                              await _serviceController.getPaymentDetails(
                                  _serviceController.paymentID);

                              Get.off(() => PaymentPreview());
                            },
                          ),
                  )
                ],
              )
            ],
          ));
    },
  );
}
