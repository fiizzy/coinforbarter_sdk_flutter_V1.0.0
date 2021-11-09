import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/coinforbarter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //Include Get.key as the value of your navigatorKey likeso
        navigatorKey: Get.key,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ButtonPage());
  }
}

class ButtonPage extends StatelessWidget {
  final PaymentConfig newPayment = PaymentConfig(
      publicKey: 'XXXXXXXX-XXXXXXXX-XXXXXXX',
      txRef: 'Flutter final Reference 1',
      amount: 0.1,
      baseCurrency: 'ETH',
      customer: 'JohnDoe@noemail.cooom',
      customerFullName: 'John Amala Doe',
      callback: myCallBackFunction);

  ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CoinForBarterButton(
              color: Colors.red,
              textColor: Colors.white,
              paymentConfig: newPayment)),
    );
  }
}

myCallBackFunction(int a, String b, dynamic c, Status s) {
  debugPrint('At the end of the day, The call back function works');
}
