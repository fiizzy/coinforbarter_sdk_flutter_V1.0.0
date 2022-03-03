import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/src/controllers/globalizer.dart';
import 'package:coinforbarter_sdk/src/models/config.dart';
import 'package:coinforbarter_sdk/src/styles/styles.dart';
import 'package:get/get.dart';

///This function handles coinForbarter's internal payment outcome before firing merchant's callback

class PaymentResponse extends StatelessWidget {
  final String message;
  const PaymentResponse({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final GlobalizerController GlobalizerController = Get.find();!

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(20),
                child: message == 'success'
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 60,
                      )
                    : message == 'cancelled'
                        ? const Icon(Icons.cancel, color: Colors.red, size: 60)
                        : const Icon(Icons.cached_rounded,
                            color: Colors.red, size: 60)),
            MyStyles.verticalSpaceZero,
            message == 'success'
                ? const Text(
                    'Payment successful',
                  )
                : message == 'cancelled'
                    ? const Text(
                        'Payment Cancelled',
                      )
                    : const Text(
                        'Payment Error',
                      ),
            MyStyles.verticalSpaceTwo,
            ElevatedButton(
                onPressed: () {
                  if (message == 'success') {
                    GlobalizerController.paymentConfig!.callback!(
                        200,
                        'payment successful',
                        'Your CoinForbarter payment was successful',
                        Status.success);
                  } else if (message == 'cancelled') {
                    GlobalizerController.paymentConfig!.callback!(
                        200,
                        'payment cancelled',
                        'Your CoinForbarter payment was cancelled',
                        Status.cancelled);
                  } else {
                    GlobalizerController.paymentConfig!.callback!(
                        200,
                        'payment failed',
                        'Your CoinForbarter payment failed',
                        Status.error);
                  }
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                child: Container(
                  color: MyStyles.primaryPurple,
                  width: MediaQuery.of(context).size.width * .8,
                  height: MyStyles.buttonHeight,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Continue', style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
