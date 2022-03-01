import 'package:coinforbarter_sdk/src/views/selectCurrency/payment_processor.dart';
import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/src/controllers/globalizer.dart';
import 'package:coinforbarter_sdk/src/controllers/selectCurrency_controller.dart';
import 'package:coinforbarter_sdk/src/controllers/serviceController.dart';
import 'package:coinforbarter_sdk/src/models/config.dart';
import 'package:coinforbarter_sdk/src/styles/styles.dart';
import 'package:coinforbarter_sdk/src/views/selectCurrency/selectCurrency.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CoinForBarterButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final PaymentConfig paymentConfig;
  static String businessName = '';

  CoinForBarterButton({
    Key? key,
    this.color,
    this.textColor,
    required this.paymentConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceController = Get.put(ServiceController());
    final SelectCurrencyController _selectCurrencyController =
        Get.put(SelectCurrencyController());
    final GlobalizerController _globerlizerController =
        Get.put(GlobalizerController());

    return ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: () async {
          processPaymentRequest(paymentConfig);
        },
        child: Container(
          color: color ?? MyStyles.primaryPurple,
          width: MediaQuery.of(context).size.width * .8,
          height: MyStyles.buttonHeight,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  color: textColor ?? MyStyles.white,
                ),
                MyStyles.horizontalSpaceZero,
                Obx(() => !serviceController.isLoading.value
                    ? Text('Pay with CoinForBarterButton',
                        style: TextStyle(color: textColor ?? MyStyles.white))
                    : const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1,
                      ))
              ],
            ),
          ),
        ));
  }
}
