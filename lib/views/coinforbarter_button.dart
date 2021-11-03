import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/controllers/globalizer.dart';
import 'package:coinforbarter_sdk/controllers/selectCurrency_controller.dart';
import 'package:coinforbarter_sdk/controllers/serviceController.dart';
import 'package:coinforbarter_sdk/models/config.dart';
import 'package:coinforbarter_sdk/styles/styles.dart';
import 'package:coinforbarter_sdk/views/selectCurrency/selectCurrency.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

// ignore: must_be_immutable
class CoinForBarterButton extends StatelessWidget {
  final serviceController = Get.put(ServiceController());
  final SelectCurrencyController _selectCurrencyController =
      Get.put(SelectCurrencyController());
  final GlobalizerController _globerlizerController =
      Get.put(GlobalizerController());
  final Color? color;
  final Color? textColor;
  final PaymentConfig paymentConfig;
  String businessName = '';

  CoinForBarterButton({
    Key? key,
    this.color,
    this.textColor,
    required this.paymentConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //making the paymentconfig globally accessible
    _globerlizerController.globalizerMethod(paymentConfig);
    return ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: () async {
          await serviceController.getCurrencyListings();
          await serviceController.runPostData(paymentConfig);
          if (serviceController.postDataResponse['message'] == 'Unauthorized') {
            Get.snackbar('Unathourized', 'Check your API key');
            serviceController.isLoading.value = false;
          } else {
            await serviceController
                .getPaymentDetails(serviceController.paymentID);
            businessName = _selectCurrencyController.getBusinessName();
            Get.to(() => SelectCurrency());
          }
        },
        child: Container(
          color: color,
          width: MediaQuery.of(context).size.width * .8,
          height: MyStyles.buttonHeight,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  color: textColor,
                ),
                MyStyles.horizontalSpaceZero,
                Obx(() => !serviceController.isLoading.value
                    ? Text('Pay with CoinForBarterButton',
                        style: TextStyle(color: textColor))
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
