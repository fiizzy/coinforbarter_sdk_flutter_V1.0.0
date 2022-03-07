import 'package:coinforbarter_sdk/src/controllers/services_extension.dart';
import 'package:coinforbarter_sdk/src/views/selectCurrency/payment_processor.dart';
import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/src/models/config.dart';
import 'package:coinforbarter_sdk/src/styles/styles.dart';
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
    final ServiceExtension _serviceExtension = Get.put(ServiceExtension());

    // final GlobalizerController _globerlizerController =
    //     Get.put(GlobalizerController());

    return ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: () async {
          //The other loading value is set to false inside of the function below
          _serviceExtension.isLoading.value = true;
          await coinForBarterInit(paymentConfig);
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
                Obx(() => !_serviceExtension.isLoading.value
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
