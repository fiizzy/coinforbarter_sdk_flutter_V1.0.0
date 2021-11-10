// ignore_for_file: file_names

import 'package:coinforbarter_sdk/src/utils/calculate_expiry_time.dart';
import 'package:coinforbarter_sdk/src/views/paymentPreview/test_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:coinforbarter_sdk/src/controllers/globalizer.dart';
import 'package:coinforbarter_sdk/src/controllers/listening_to_payment_controller.dart';
import 'package:coinforbarter_sdk/src/controllers/lock_currency_controller.dart';
import 'package:coinforbarter_sdk/src/controllers/selectCurrency_controller.dart';
import 'package:coinforbarter_sdk/src/styles/styles.dart';
import 'package:coinforbarter_sdk/src/views/paymentPreview/addressDetails.dart';
import 'package:coinforbarter_sdk/src/views/selectCurrency/productCard.dart';
import 'package:coinforbarter_sdk/src/views/selectCurrency/securedByCoinfForBarter.dart';
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
    final GlobalizerController _globalizerController = Get.find();
    debugPrint(_globalizerController.paymentConfig.publicKey);
    final ListeningToPaymentController _listeningToPaymentController =
        Get.put(ListeningToPaymentController());

    //This gets the expiry time sent from the API in UTC format
    String getExpiryTime = _selectCurrencyController.getExpiryTime();

    //This calculates the expiry time difference from the current time.
    int countDownInSeconds = calculateExpiryTime(getExpiryTime);

    //Converting to millisecond since epoch just so our countdown plugin can read it in seconds.
    int endTime =
        DateTime.now().millisecondsSinceEpoch + 1000 * countDownInSeconds;

    //A method called every 30s to get a payment response from the server
    _listeningToPaymentController.statusCheker();

    return Scaffold(
        appBar: AppBar(
            leading: Container(),
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
                  GlobalizerController.isTest
                      ? TestAddressCard()
                      : AddressDetails()
                ],
              ),
            ],
          ),
        ));
  }
}
