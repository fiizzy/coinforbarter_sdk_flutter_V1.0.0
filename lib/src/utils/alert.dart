import 'package:flutter/material.dart';
import '../../coinforbarter_sdk.dart';

showAlert(context) {
  final ListeningToPaymentController listening_to_payment_controller =
      Get.find();
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cancel Transaction ?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Would you like to Cancel the transaction initiated ?'),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Proceed'),
            onPressed: () async {
              ServiceController.paymentID;
              // ServiceController _serviceController = Get.find();
              await ServiceController().cancelPayment();
              listening_to_payment_controller.timer.cancel();
              Get.offAll(() => const PaymentResponse(message: 'cancelled'));
            },
          ),
        ],
      );
    },
  );
}
