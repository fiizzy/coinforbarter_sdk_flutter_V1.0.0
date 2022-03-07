import 'package:coinforbarter_sdk/src/utils/loader.dart';
import 'package:flutter/material.dart';
import '../../coinforbarter_sdk.dart';

showAlert(context) async {
  final ListeningToPaymentController listening_to_payment_controller =
      Get.find();
  ServiceController _serviceController = Get.find();

  return await showDialog<void>(
    context: context,
    barrierDismissible: false,
    // user must tap button!
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
          InkWell(
              child: const Text("Cancel"),
              onTap: _serviceController.isLoading.value
                  ? () {}
                  : () async {
                      Navigator.pop(context);
                    }),
          SizedBox(
            width: 20,
          ),
          Obx(() => ElevatedButton(
                child: _serviceController.isLoading.value
                    ? loader()
                    : const Text('Proceed'),
                onPressed: _serviceController.isLoading.value
                    ? () {}
                    : () async {
                        _serviceController.isLoading.value = true;
                        await _serviceController.cancelPayment();
                        listening_to_payment_controller.timer.cancel();
                        _serviceController.isLoading.value = false;

                        Get.offAll(
                            () => const PaymentResponse(message: 'cancelled'));
                        debugPrint(
                            'This Payment failed because it was Cancelled/cancelled.');
                      },
              )),
        ],
      );
    },
  );
}
