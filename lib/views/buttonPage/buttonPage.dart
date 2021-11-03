// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_sdk_2/models/config.dart';
import 'package:flutter_sdk_2/views/main_button.dart';

class ButtonPage extends StatelessWidget {
  final PaymentConfig newPayment = PaymentConfig(
      publicKey: 'C4B_TEST-xMxiwbIsK1632761320337oB8yYtGe3K8wBXFPPhZQ',
      txRef: 'Flutter final Reference 1',
      amount: 0.1,
      baseCurrency: 'ETH',
      customer: 'JohnDoe@noemail.com',
      customerFullName: 'John Amala Doe',
      callback: myCallBackFunction);

  ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CustomButton(
              color: Colors.red,
              textColor: Colors.white,
              paymentConfig: newPayment)),
    );
  }
}

myCallBackFunction(int a, String b, dynamic c, Status s) {
  debugPrint('At the end of the day, The call back function works');
}
