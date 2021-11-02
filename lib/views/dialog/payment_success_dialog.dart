import 'package:flutter/material.dart';
import 'package:flutter_sdk_2/controllers/globalizer.dart';
import 'package:flutter_sdk_2/models/config.dart';
import 'package:flutter_sdk_2/styles/styles.dart';
import 'package:get/get.dart';

///This function handles coinForbarter's internal payment outcome before firing merchant's callback

class PaymentResponse extends StatelessWidget {
  final String message;
  const PaymentResponse({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalizerController _globalizerController = Get.find();

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
                    : const Icon(Icons.cached_rounded,
                        color: Colors.red, size: 60)),
            MyStyles.verticalSpaceZero,
            message == 'sucess'
                ? const Text(
                    'Payment successful',
                  )
                : const Text(
                    'Payment Error',
                  ),
            MyStyles.verticalSpaceTwo,
            ElevatedButton(
                onPressed: () {
                  if (message == 'success') {
                    _globalizerController.paymentConfig.callback!(
                        200,
                        'payment successful',
                        'Your CoinForbarter payment was successful',
                        Status.success);
                  } else {
                    _globalizerController.paymentConfig.callback!(
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
