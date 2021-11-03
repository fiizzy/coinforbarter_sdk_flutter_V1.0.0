import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/controllers/serviceController.dart';
import 'package:coinforbarter_sdk/views/dialog/payment_success_dialog.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

showAlert(context) {
  final ServiceController _serviceController = Get.find();
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
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
              Get.off(() => const PaymentResponse(message: 'error'));
            },
          ),
        ],
      );
    },
  );
}
