import 'package:flutter/material.dart';
import '../../coinforbarter.dart';

showAlert(context) {
  final ServiceController _serviceController = Get.find();
  final ListeningToPaymentController listening_to_payment_controller =
      Get.find();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Terminate Transfer'),
              Text('Would you like to terminate the transfer initiated ?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Terminate'),
            onPressed: () async {
              await _serviceController.cancelPayment();
              listening_to_payment_controller.timer.cancel();
              Get.offAll(() => const PaymentResponse(message: 'cancelled'));
            },
          ),
        ],
      );
    },
  );
}
