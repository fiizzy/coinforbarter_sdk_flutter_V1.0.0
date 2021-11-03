// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_sdk_2/controllers/globalizer.dart';
import 'package:flutter_sdk_2/controllers/listening_to_payment_controller.dart';
import 'package:flutter_sdk_2/controllers/lock_currency_controller.dart';
import 'package:flutter_sdk_2/controllers/selectCurrency_controller.dart';
import 'package:flutter_sdk_2/styles/styles.dart';
import 'package:flutter_sdk_2/views/paymentPreview/addressDetails.dart';
import 'package:flutter_sdk_2/views/selectCurrency/productCard.dart';
import 'package:flutter_sdk_2/views/selectCurrency/securedByCoinfForBarter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class PaymentPreview extends StatefulWidget {
  const PaymentPreview({Key? key}) : super(key: key);

  @override
  _PaymentPreviewState createState() => _PaymentPreviewState();
}

class _PaymentPreviewState extends State<PaymentPreview> {
  @override
  Widget build(BuildContext context) {
    //We initialize all controllers for later use
    final SelectCurrencyController _selectCurrencyController = Get.find();
    final LockCurrencyController _lockCurrencyController = Get.find();
    final GlobalizerController _globalizerController =
        Get.put(GlobalizerController());
    debugPrint('${_globalizerController.paymentConfig.publicKey}');
    final ListeningToPaymentController _listeningToPaymentController =
        Get.put(ListeningToPaymentController());
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
    _selectCurrencyController.getExpiryTime();
    _listeningToPaymentController.statusCheker();

    return Scaffold(
        appBar: AppBar(
            // leading: Container(),
            title: const Text("Transfer"),
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
                    amount: _lockCurrencyController.lockCurrencyresponse['data']
                        ['amount'],
                    baseCurrrency: _lockCurrencyController
                        .lockCurrencyresponse['data']['currency'],
                  ),
                  MyStyles.verticalSpaceZero,
                  const SecuredByCoinForBarter(),
                  MyStyles.verticalSpaceOne,
                  Text(
                    "Address",
                    style: MyStyles.headerOneW,
                    textAlign: TextAlign.left,
                  ),
                  MyStyles.verticalSpaceOne,
                  Card(
                      color: MyStyles.gold,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          direction: Axis.horizontal,
                          children: [
                            // Obx(() =>
                            CountdownTimer(
                              endTime: endTime,
                              onEnd: () {
                                _listeningToPaymentController.countDownValue =
                                    0;
                                // _listeningToPaymentController.timer.cancel();
                                debugPrint('the on end works');
                              },
                            ),

                            // Text(
                            //     '${_timerCon.hrCounter}:${_timerCon.minCounter}:${_timerCon.secCounter}s Remaining',
                            //     style: MyStyles.bodyText),
                            // ),
                            MyStyles.horizontalSpaceZero,
                          ],
                        ),
                      )),
                  AddressDetails()
                ],
              ),
            ],
          ),
        ));
  }
}
